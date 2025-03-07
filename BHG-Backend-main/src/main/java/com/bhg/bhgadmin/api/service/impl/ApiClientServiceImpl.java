package com.bhg.bhgadmin.api.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.api.dto.request.*;
import com.bhg.bhgadmin.api.dto.response.ClientsLoginResponse;
import com.bhg.bhgadmin.api.service.IApiClientService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizMailReceiverDTO;
import com.bhg.bhgadmin.dto.biz.BizMailjetSenderDTO;
import com.bhg.bhgadmin.dto.request.client.*;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.entity.InvestmentEntities;
import com.bhg.bhgadmin.entity.LoginUser;
import com.bhg.bhgadmin.entity.Notification;
import com.bhg.bhgadmin.mapper.ClientsMapper;
import com.bhg.bhgadmin.mapper.InvestmentEntitiesMapper;
import com.bhg.bhgadmin.properties.DynamicProperties;
import com.bhg.bhgadmin.properties.StaticProperties;
import com.bhg.bhgadmin.service.IClientService;
import com.bhg.bhgadmin.service.VisitorLogService;
import com.bhg.bhgadmin.share.constants.CommonConstants;
import com.bhg.bhgadmin.share.constants.MailJetConstants;
import com.bhg.bhgadmin.share.constants.RedisConstants;
import com.bhg.bhgadmin.share.enums.LanguageEnum;
import com.bhg.bhgadmin.share.enums.UserTypeEnum;
import com.bhg.bhgadmin.share.error.ClientsErrorEnum;
import com.bhg.bhgadmin.share.error.CommonErrorEnum;
import com.bhg.bhgadmin.share.utils.*;
import com.google.common.collect.Maps;
import com.mailjet.client.errors.MailjetException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-13 12:40
 **/
@Slf4j
@Service
@RefreshScope
public class ApiClientServiceImpl implements IApiClientService {

    public static String CLIENT_PASSWORD_RESET_EMAIL_SUBJECT = "Verification code to reset your password";
    public static String REGISTER_CLIENT_EMAIL_SUBJECT = "Register Client For BHG";
    public static String VISITOR_CLIENT_EMAIL_SUBJECT = "Visitor For BHG";
    public static String RESET_PIN_EMAIL_SUBJECT = "Reset Pin For BHG";

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private DynamicProperties dynamicProperties;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private StaticProperties staticProperties;

    @Resource
    private IClientService clientService;

    @Resource
    private InvestmentEntitiesMapper investmentEntitiesMapper;

    @Resource
    VisitorLogService visitorLogService;

    @Value("${dynamic-properties.pushUrl:https://fc-mp-d9db3028-a54f-4a9d-9553-b68006a8a687.next.bspapp.com/push}")
    private String pushUrl;
    @Resource
    MsgUtil msgUtil;

    @Value("${dynamic-properties.isLogoff:1}")
    private String isLogoff;
    @Value("${dynamic-properties.isRegister:1}")
    private String isRegister;
    Pattern pattern = Pattern.compile("^04\\d{8}$");

    @Override
    public CommonResponse<ClientsLoginResponse> clientLogin(ClientLoginRequest request, HttpServletRequest servletRequest)  {
        // use authenticate function in AuthenticationManager of Spring Security
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
            new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword());
        // set userType in detail
        usernamePasswordAuthenticationToken.setDetails(UserTypeEnum.CLIENT);
        Authentication authenticate = authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        // authenticate fail
        if (Objects.isNull(authenticate)){
            ClientsErrorEnum.UNAUTHORIZED.throwException();
        }
        LoginUser loginUser = (LoginUser)authenticate.getPrincipal();
        String clientId = loginUser.getClientsEntity().getId().toString();
        // generate JWT to front-end
        // set expired time
        String jwt = JwtUtil.createJWT(clientId, dynamicProperties.getTokenExpireTime());

        ClientsLoginResponse clientsLoginResponse = new ClientsLoginResponse();
        clientsLoginResponse.setClientEmail(request.getEmail());
        // client token start with Beaver-client:
        clientsLoginResponse.setToken(new StringBuilder(
            CommonConstants.TokenPrefix.CLIENT_TOKEN_PREFIX).append(jwt).toString());

        // put client info into Redis
        redisCache.setCacheObject(RedisConstants.CLIENT_LOGIN_INFO + clientId, loginUser,
                                  dynamicProperties.getTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);

        CompletableFuture.runAsync(() -> {
            clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                                .set(ObjectUtil.isNotNull(loginUser.getClientsEntity().getCurrentSignInAt()), ClientsEntity::getLastSignInAt, loginUser.getClientsEntity().getCurrentSignInAt())
                                .set(ClientsEntity::getCurrentSignInAt, new Date())
                                .set(StringUtils.hasText(loginUser.getClientsEntity().getCurrentSignInIp()), ClientsEntity::getLastSignInIp, loginUser.getClientsEntity().getCurrentSignInIp())
                                .set(ClientsEntity::getCurrentSignInIp, getIpAddress(servletRequest))
                                .eq(ClientsEntity::getId, loginUser.getClientsEntity().getId()));
        }, executor);

        return CommonResponse.success(clientsLoginResponse);
    }

    @Override
    public String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":ip;
    }

    @Override
    public CommonResponse<String> clientLogout() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        Long clientId = loginUser.getClientsEntity().getId();
        redisCache.deleteObject(RedisConstants.CLIENT_LOGIN_INFO+clientId);
        return CommonResponse.success(loginUser.getClientsEntity().getName() + " logout success");
    }

    @Override
    public CommonResponse<String> resetPasswordCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        ClientsEntity entityFromDB = clientsMapper.selectOne(Wrappers.<ClientsEntity>query().lambda()
                               .eq(ClientsEntity::getEmail, request.getEmail())
                               .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        String securityCode = RandomUtil.randomNumbers(6);
        redisCache.setCacheObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + entityFromDB.getId(), securityCode,
                                  dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        Date now = new Date();
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                            .set(ClientsEntity::getResetPasswordToken, securityCode)
                            .set(ClientsEntity::getResetPasswordSentAt, now)
                            .set(ClientsEntity::getUpdatedAt, now)
                            .eq(ClientsEntity::getId, entityFromDB.getId()));
        // generate Email
        emailSend(entityFromDB, securityCode);
        return CommonResponse.success(request.getEmail());
    }

    @Override
    public CommonResponse<String> resetPassword(ResetPasswordRequest request) {
        String mobile = request.getMobile();
        boolean mobileFlag = CharSequenceUtil.isNotBlank(mobile);
        ClientsEntity entityFromDB =  clientsMapper.selectOne(Wrappers.<ClientsEntity>query().lambda()
                    .eq(CharSequenceUtil.isNotBlank(request.getEmail()), ClientsEntity::getEmail, request.getEmail())
                    .eq(mobileFlag, ClientsEntity::getMobile, mobile)
                    .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        // get securityCode from redis
        Serializable redisKey = mobileFlag ? mobile : entityFromDB.getId();
        String securityCode = redisCache.getCacheObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + (redisKey));
        if (!request.getVerificationCode().equals(securityCode)){
            ClientsErrorEnum.WRONG_VERIFICATION_CODE.throwException();
        }
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                .set(ClientsEntity::getEncryptedPassword, passwordEncoder.encode(request.getPassword()))
                .set(ClientsEntity::getUpdatedAt, new Date())
                .eq(!mobileFlag, ClientsEntity::getId, entityFromDB.getId())
                .eq(mobileFlag, ClientsEntity::getMobile, mobile));
        redisCache.deleteObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + redisKey);
        return CommonResponse.success(mobileFlag?request.getMobile():request.getEmail());
    }

    @Override
    public CommonResponse<Long> editClient(ClientEditRequest request) {
        ClientsEntity clientsEntity = clientsMapper.selectById(LoginUserUtil.getLoginUserId());
        ClientEditRequest clientEditRequest = BeanUtil.copyProperties(clientsEntity, ClientEditRequest.class);
        clientEditRequest.setName(request.getName());
        clientEditRequest.setMobile(request.getMobile());
        clientEditRequest.setBirth(request.getBirth());
        return clientService.editClient(clientEditRequest);
    }

    @Override
    public CommonResponse<Long> editEntity(InvestmentCreateRequest request) {
        InvestmentEntities investmentEntities = investmentEntitiesMapper.selectOne(new LambdaQueryWrapper<InvestmentEntities>()
                .eq(InvestmentEntities::getClientId, LoginUserUtil.getLoginUserId())
                .eq(InvestmentEntities::getId, request.getId())
        );
        if (investmentEntities != null) {
            request.setClientId(LoginUserUtil.getLoginUserId());
            return clientService.editEntity(request, null, null, null, null);
        }
        return CommonResponse.error("unknow entity");
    }

    @Override
    public CommonResponse<String> editPassword(EditPasswordRequest request) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient == null) {
            CommonResponse.error("not login");
        }
        ClientsEntity entityFromDB = clientsMapper.selectOne(Wrappers.<ClientsEntity>query().lambda()
                .eq(ClientsEntity::getId, loginClient.getId())
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        if (!Objects.equals(request.getPassword(), request.getConfirmPassword())) {
            ClientsErrorEnum.WRONG_CONFIRM_PASSWORD.throwException();
        }
        if (!passwordEncoder.matches(request.getCurrentPassword(), entityFromDB.getEncryptedPassword())) {
            ClientsErrorEnum.WRONG_PASSWORD.throwException();
        }
        if (Objects.equals(request.getPassword(), request.getCurrentPassword())) {
            ClientsErrorEnum.SAME_PASSWORD.throwException();
        }
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                .set(ClientsEntity::getEncryptedPassword, passwordEncoder.encode(request.getPassword()))
                .set(ClientsEntity::getUpdatedAt, new Date())
                .eq(ClientsEntity::getId, entityFromDB.getId()));
        redisCache.deleteObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + entityFromDB.getId());

        return CommonResponse.success(loginClient.getEmail());
    }

    @Override
    public CommonResponse<Long> shareApp(ShareAppRequest request, HttpServletRequest httpRequest) throws Exception {
        CommonResponse<Long> success = CommonResponse.success(1L);
        if (request == null || CharSequenceUtil.isBlank(request.getPhone()) || !pattern.matcher(request.getPhone()).matches()) {
            return success;
        }
        try {
            // 获取请求IP
            /*String ipAddress = getIpAddress(httpRequest);
            if (CharSequenceUtil.isNotBlank(ipAddress)) {
                Long count = redisCache.getCacheObject(RedisConstants.MSG_FROM_IP_LIMIT+ipAddress);
                if (count == null) {
                    count = 0L;
                    redisCache.setCacheObject(RedisConstants.MSG_FROM_IP_LIMIT+ipAddress, count, DateFormatUtil.getRemainSecondsOneDay(new Date()),  TimeUnit.SECONDS);
                }
                count = redisCache.increment(RedisConstants.MSG_FROM_IP_LIMIT + ipAddress);
                if (count > 50) {
                    log.info("ip:{},limit", ipAddress);
                    return success;
                }
            }
            Long count = redisCache.getCacheObject(RedisConstants.MSG_TO_NUM_LIMIT+request.getPhone());
            if (count == null) {
                count = 0L;
                redisCache.setCacheObject(RedisConstants.MSG_TO_NUM_LIMIT+request.getPhone(), count, DateFormatUtil.getRemainSecondsOneDay(new Date()),  TimeUnit.SECONDS);
            }
            count = redisCache.increment(RedisConstants.MSG_TO_NUM_LIMIT+request.getPhone());
            if (count > 50) {
                log.info("num:{},limit", request.getPhone());
                return success;
            }*/
            msgUtil.send("61"+request.getPhone(),"bhg", "Apple Store link: [Insert Apple Store link]\n" +
                    "Google Play link: [Insert Google Play link]");
        } catch (Exception e) {
            log.error("msg error, phone:{}", "+61"+request.getPhone(), e);
        }
        return success;
    }

    @Override
    public CommonResponse<Long> editPushClientId(ClientPushIdRequest request) {
        Long id = LoginUserUtil.getLoginUserId();
        if (id != null) {
            clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                    .set(ClientsEntity::getPushClientId, request.getPushId())
                    .set(request.getLanguage() != null, ClientsEntity::getLanguage, request.getLanguage())
                    .eq(ClientsEntity::getId, id));
            return CommonResponse.success(id);
        }
        return CommonResponse.error("not login");
    }

    @Override
    @Async
    public void pushMsg(Notification notification) {
        LambdaQueryWrapper<ClientsEntity> wrapper = new LambdaQueryWrapper<ClientsEntity>().isNotNull(ClientsEntity::getPushClientId);
        if (Boolean.FALSE.equals(notification.getIsAll())) {
            if (CollUtil.isNotEmpty(notification.getClientIdArr())) {
                wrapper.in(ClientsEntity::getId, notification.getClientIdArr());
            } else {
                return;
            }
        }
        Map<String, Object> param = Maps.newHashMap();

        param.put("pushType", 0);
        List<ClientsEntity> clientsEntities = clientsMapper.selectList(wrapper);
        for (ClientsEntity clientsEntity : clientsEntities) {
            try {
                param.put("title", !ObjectUtil.equals(clientsEntity.getLanguage(), LanguageEnum.CN.getCode()) ?
                        notification.getTitle() : notification.getTitleCn());
                param.put("content", !ObjectUtil.equals(clientsEntity.getLanguage(), LanguageEnum.CN.getCode()) ?
                        notification.getMessage() : notification.getMessageCn());
                param.put("pushClientId", clientsEntity.getPushClientId());
                HttpUtil.post(pushUrl, JSONUtil.toJsonStr(param));
            } catch (Exception e) {
                log.info("push error,title:{}, clientName:{}, {}", notification.getTitle(), clientsEntity.getName(), e.getMessage());
            }
        }
    }

    @Override
    public void pushPurchasedMsg(ClientsEntity clientsEntity, Long pfId, Long fundId) {
        if (CharSequenceUtil.isNotBlank(clientsEntity.getPushClientId())) {
            Map<String, Object> param = Maps.newHashMap();
            try {
                param.put("title", ObjectUtil.equals(LanguageEnum.CN.getCode(), clientsEntity.getLanguage()) ? "您收到1条新的认购凭证" : "Please review your new unit certificate");
                param.put("pushType", 3);
                param.put("content", MapUtil.getStr(param, "title"));
                param.put("pushClientId", clientsEntity.getPushClientId());
                param.put("purchaseId", pfId);
                param.put("fundId", fundId);
                HttpUtil.post(pushUrl, JSONUtil.toJsonStr(param));
            } catch (Exception e) {
                log.info("push purchased error, param:{}, clientName:{}, {}", JSONUtil.toJsonStr(param), clientsEntity.getName(), e.getMessage());
            }
        }
    }

    @Override
    public void pushEventMsg(List<Long> clientId) {
        LambdaQueryWrapper<ClientsEntity> wrapper = new LambdaQueryWrapper<ClientsEntity>()
                .isNotNull(ClientsEntity::getPushClientId)
                .in(CollUtil.isNotEmpty(clientId), ClientsEntity::getId, clientId);
        Map<String, Object> param = Maps.newHashMap();
        param.put("pushType", 2);
        List<ClientsEntity> clientsEntities = clientsMapper.selectList(wrapper);
        for (ClientsEntity clientsEntity : clientsEntities) {
            try {
                param.put("title", ObjectUtil.equals(LanguageEnum.CN.getCode(), clientsEntity.getLanguage()) ? "海利有新的活动" : "New BHG event is coming");
                param.put("pushClientId", clientsEntity.getPushClientId());
                param.put("content", MapUtil.getStr(param, "title"));
                HttpUtil.post(pushUrl, JSONUtil.toJsonStr(param));
            } catch (Exception e) {
                log.info("push event error, param:{}, clientName:{}, {}", JSONUtil.toJsonStr(param), clientsEntity.getName(), e.getMessage());
            }
        }
    }

    @Override
    public CommonResponse<String> registerCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        ClientsEntity entityFromDB = clientsMapper.selectOne(Wrappers.<ClientsEntity>query().lambda()
                .eq(ClientsEntity::getEmail, request.getEmail())
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNotNull(entityFromDB)){
            ClientsErrorEnum.EMAIL_EXIST.throwException();
        }
        String securityCode = RandomUtil.randomNumbers(6);
        redisCache.setCacheObject(RedisConstants.CLIENT_REGISTER_TOKEN + request.getEmail(), securityCode,
                dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        // generate Email
        emailSend(request.getEmail(), securityCode, null);
        return CommonResponse.success(request.getEmail());
    }

    @Override
    public CommonResponse<Long> createClient(ClientCreateRequest request) {
        // get securityCode from redis
        String securityCode = redisCache.getCacheObject(RedisConstants.CLIENT_REGISTER_TOKEN + request.getEmail());
        if (!request.getVerificationCode().equals(securityCode)){
            ClientsErrorEnum.WRONG_VERIFICATION_CODE.throwException();
        }

        if (!ObjectUtil.equals(request.getPassword(), request.getConfirmPassword())) {
            ClientsErrorEnum.WRONG_CONFIRM_PASSWORD.throwException();
        }
        return clientService.createClient(request);
    }

    @Override
    public CommonResponse<String> clientLogoff() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        Long clientId = loginUser.getClientsEntity().getId();
        clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                .set(ClientsEntity::getDelFlag, Boolean.TRUE).eq(ClientsEntity::getId, clientId));
        investmentEntitiesMapper.update(null, new LambdaUpdateWrapper<InvestmentEntities>()
                .set(InvestmentEntities::getDelFlag, Boolean.TRUE).eq(InvestmentEntities::getClientId, clientId));
        redisCache.deleteObject(RedisConstants.CLIENT_LOGIN_INFO+clientId);
        return CommonResponse.success(loginUser.getClientsEntity().getName() + " logoff success");
    }

    @Override
    public CommonResponse<Boolean> isLogoff() {
        return CommonResponse.success(ObjectUtil.equals(isLogoff, "1"));
    }

    @Override
    public CommonResponse<Boolean> isRegister() {
        return CommonResponse.success(ObjectUtil.equals(isRegister, "1"));
    }

    @Override
    public CommonResponse<String> resetPasswordCodeMsgSend(ResetPasswordCodeSendRequest request) {
        if (request == null || CharSequenceUtil.isBlank(request.getMobile()) || !pattern.matcher(request.getMobile()).matches()) {
            return CommonResponse.error("wrong number");
        }
        ClientsEntity clientsEntity = clientsMapper.selectOne(new LambdaQueryWrapper<ClientsEntity>()
                .eq(ClientsEntity::getMobile, request.getMobile())
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE).last(" limit 1"));
        if (clientsEntity == null) {
            return CommonResponse.error("client not exist");
        }
        String securityCode = RandomUtil.randomNumbers(6);
        redisCache.setCacheObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + request.getMobile(), securityCode,
                dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        Date now = new Date();
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                .set(ClientsEntity::getResetPasswordToken, securityCode)
                .set(ClientsEntity::getResetPasswordSentAt, now)
                .set(ClientsEntity::getUpdatedAt, now)
                .eq(ClientsEntity::getMobile, request.getMobile()).eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        // generate Email
        try {
            msgUtil.send("61"+request.getMobile(),"bhg", "reset password code:" + securityCode);
        } catch (Exception e) {
            log.error("send msg error:{}", request.getMobile(),e);
            redisCache.deleteObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + request.getMobile());
            return CommonResponse.error("try later");
        }
        return CommonResponse.success(request.getMobile());
    }

    @Override
    public CommonResponse<String> setPin(PinRequest request) {
        Long loginUserId = LoginUserUtil.getLoginUserId();
        clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                .set(ClientsEntity::getPin, request.getPin()).eq(ClientsEntity::getId, loginUserId));
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<String> editPin(EditPinRequest request) {
        Long loginUserId = LoginUserUtil.getLoginUserId();
        ClientsEntity clientsEntity = clientsMapper.selectById(loginUserId);
        if (CharSequenceUtil.isNotEmpty(request.getCurrentPin()) && !ObjectUtil.equals(request.getCurrentPin(), clientsEntity.getPin())) {
            return CommonResponse.error("wrong pin");
        }

        if (CharSequenceUtil.isNotEmpty(request.getCurrentPassword()) && !passwordEncoder.matches(request.getCurrentPassword(), clientsEntity.getEncryptedPassword())) {
            return CommonResponse.error("wrong password");
        }
        clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                .set(ClientsEntity::getPin, request.getPin()).eq(ClientsEntity::getId, loginUserId));
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<String> checkPin(PinRequest request) {
        Long loginUserId = LoginUserUtil.getLoginUserId();
        ClientsEntity clientsEntity = clientsMapper.selectById(loginUserId);
        if (request.getPin().equals(clientsEntity.getPin())) {
            return CommonResponse.success();
        } else {
            return CommonResponse.error("wrong pin");
        }
    }

    @Override
    public CommonResponse<String> visitorCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        Integer count = clientsMapper.selectCount(new LambdaQueryWrapper<ClientsEntity>()
                .eq(ClientsEntity::getEmail, request.getEmail())
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (count != null && count > 0) {
            return CommonResponse.error("The email address already exists. Please log in using your password.");
        }
        String securityCode = RandomUtil.randomNumbers(6);
        String encode = passwordEncoder.encode(securityCode);
        redisCache.setCacheObject(RedisConstants.CLIENT_VISITOR_TOKEN + request.getEmail(), encode,
                dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        emailSend(request.getEmail(), securityCode, VISITOR_CLIENT_EMAIL_SUBJECT);
        return CommonResponse.success(request.getEmail());
    }

    @Override
    public CommonResponse<ClientsLoginResponse> visitorLogin(ClientLoginRequest request) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getVerificationCode());
        usernamePasswordAuthenticationToken.setDetails(UserTypeEnum.VISITOR);
        Authentication authenticate = authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        // authenticate fail
        if (Objects.isNull(authenticate)){
            ClientsErrorEnum.UNAUTHORIZED.throwException();
        }
        LoginUser loginUser = (LoginUser)authenticate.getPrincipal();
        String email = loginUser.getVisitor().getEmail();
        String jwt = JwtUtil.createJWT(email, dynamicProperties.getTokenExpireTime());
        ClientsLoginResponse clientsLoginResponse = new ClientsLoginResponse();
        clientsLoginResponse.setClientEmail(request.getEmail());
        // client token start with Beaver-client:
        clientsLoginResponse.setToken(new StringBuilder(
                CommonConstants.TokenPrefix.CLIENT_TOKEN_PREFIX).append(jwt).toString());
        // put client info into Redis
        redisCache.setCacheObject(RedisConstants.CLIENT_LOGIN_INFO + email, loginUser,
                dynamicProperties.getTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        visitorLogService.save(loginUser.getVisitor());
        redisCache.deleteObject(RedisConstants.CLIENT_VISITOR_TOKEN + request.getEmail());
        return CommonResponse.success(clientsLoginResponse);
    }

    @Override
    public CommonResponse<String> visitorLogout() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        String email = loginUser.getVisitor().getEmail();
        redisCache.deleteObject(RedisConstants.CLIENT_LOGIN_INFO+email);
        return CommonResponse.success(email + " logout success");

    }

    @Override
    public CommonResponse<String> resetPin(EditPinRequest request) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient == null) {
            return CommonResponse.success();
        }
        // get securityCode from redis
        String securityCode = redisCache.getCacheObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + (loginClient.getId()));
        if (!request.getVerificationCode().equals(securityCode)){
            ClientsErrorEnum.WRONG_VERIFICATION_CODE.throwException();
        }
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                .set(ClientsEntity::getPin, request.getPin())
                .set(ClientsEntity::getUpdatedAt, new Date())
                .eq(ClientsEntity::getId, loginClient.getId()));
        redisCache.deleteObject(RedisConstants.CLIENT_PIN_RESET_TOKEN + loginClient.getId());
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<String> resetPinMsgSend() {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient == null) {
            return CommonResponse.error("not login.");
        }
        ClientsEntity clientsEntity = clientsMapper.selectById(loginClient.getId());
        if (clientsEntity.getMobile() == null) {
            return CommonResponse.error("you has not set a phone number.");
        }
        String securityCode = RandomUtil.randomNumbers(6);
        redisCache.setCacheObject(RedisConstants.CLIENT_PIN_RESET_TOKEN + loginClient.getId(), securityCode,
                dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        String s = loginClient.getMobile().trim().replace("+61", "").replaceFirst("^61", "");
        if (!pattern.matcher(s).matches()) {
            return CommonResponse.error("please check your phone number.");
        }
        // generate Email
        try {
            msgUtil.send("61"+s,"bhg", "reset pin code:" + securityCode);
        } catch (Exception e) {
            log.error("send msg error:{}", loginClient.getMobile(),e);
            redisCache.deleteObject(RedisConstants.CLIENT_PASSWORD_RESET_TOKEN + loginClient.getMobile());
            return CommonResponse.error("please check your phone number.");
        }
        return CommonResponse.success(loginClient.getMobile());
    }

    @Override
    public CommonResponse<String> resetPinCodeSend() throws MailjetException {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient == null) {
            return CommonResponse.error("not login.");
        }
        String securityCode = RandomUtil.randomNumbers(6);
        String encode = passwordEncoder.encode(securityCode);
        redisCache.setCacheObject(RedisConstants.CLIENT_PIN_RESET_TOKEN + loginClient.getId(), encode,
                dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        emailSend(loginClient.getEmail(), securityCode, RESET_PIN_EMAIL_SUBJECT);
        return CommonResponse.success(loginClient.getEmail());
    }


    private void emailSend(ClientsEntity entityFromDB, String securityCode) throws MailjetException {
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
        mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
            new BizMailReceiverDTO(entityFromDB.getEmail(), entityFromDB.getName()));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject(CLIENT_PASSWORD_RESET_EMAIL_SUBJECT);
        mailjetSenderDTO.setTemplateId(MailJetConstants.CLIENT_PASSWORD_RESET_SEND_EMAIL_TEMPLATE_ID);
        JSONObject variables = new JSONObject()
            .set("client_name",StringUtils.hasText(entityFromDB.getName()) ? entityFromDB.getName() : "Client")
            .set("security_code", securityCode);
        mailjetSenderDTO.setVariables(variables);
        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        Boolean success = mailjetUtil.sendMailWithTemplate(mailjetUtil);
        if (!success){
            CommonErrorEnum.MAIL_FAIL_TO_SENT.throwException();
        }
    }

    private void emailSend(String email, String securityCode, String subject) throws MailjetException {
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
        mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
                new BizMailReceiverDTO(email, "Client"));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject(CharSequenceUtil.isBlank(subject) ? REGISTER_CLIENT_EMAIL_SUBJECT : subject);
        mailjetSenderDTO.setTemplateId(MailJetConstants.CLIENT_PASSWORD_RESET_SEND_EMAIL_TEMPLATE_ID);
        JSONObject variables = new JSONObject()
                .set("client_name", "Client")
                .set("security_code", securityCode);
        mailjetSenderDTO.setVariables(variables);
        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        Boolean success = mailjetUtil.sendMailWithTemplate(mailjetUtil);
        if (!success){
            CommonErrorEnum.MAIL_FAIL_TO_SENT.throwException();
        }
    }
}
