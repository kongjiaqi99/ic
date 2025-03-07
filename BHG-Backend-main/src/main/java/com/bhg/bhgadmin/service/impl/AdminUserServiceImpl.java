package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizMailReceiverDTO;
import com.bhg.bhgadmin.dto.biz.BizMailjetSenderDTO;
import com.bhg.bhgadmin.dto.request.admin.AdminLoginRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserCreateRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDelRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDetailRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserEditRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserQueryRequest;
import com.bhg.bhgadmin.dto.request.admin.ResetPwdFromEmailRequest;
import com.bhg.bhgadmin.dto.request.admin.SendResetAdminPasswordRequest;
import com.bhg.bhgadmin.dto.response.AdminLoginResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersEditDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersExportDTO;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersResponse;
import com.bhg.bhgadmin.dto.response.admin.RoleResponse;
import com.bhg.bhgadmin.dto.response.permission.PermissionDTO;
import com.bhg.bhgadmin.entity.AdminUsersEntity;
import com.bhg.bhgadmin.entity.AuthRoleEntity;
import com.bhg.bhgadmin.entity.LoginUser;
import com.bhg.bhgadmin.mapper.AdminUsersMapper;
import com.bhg.bhgadmin.mapper.AuthRoleMapper;
import com.bhg.bhgadmin.properties.DynamicProperties;
import com.bhg.bhgadmin.properties.StaticProperties;
import com.bhg.bhgadmin.properties.email.PasswordResetEmailProperties;
import com.bhg.bhgadmin.service.IAdminUserService;
import com.bhg.bhgadmin.service.export.ExportService;
import com.bhg.bhgadmin.share.constants.CommonConstants;
import com.bhg.bhgadmin.share.constants.RedisConstants;
import com.bhg.bhgadmin.share.enums.EnvironmentTypeEnum;
import com.bhg.bhgadmin.share.enums.FilterTypeEnum;
import com.bhg.bhgadmin.share.enums.UserTypeEnum;
import com.bhg.bhgadmin.share.error.AdminUserErrorEnum;
import com.bhg.bhgadmin.share.error.CommonErrorEnum;
import com.bhg.bhgadmin.share.utils.AesUtils;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.JwtUtil;
import com.bhg.bhgadmin.share.utils.MailjetUtil;
import com.bhg.bhgadmin.share.utils.MyHttpUtil;
import com.bhg.bhgadmin.share.utils.RedisCache;
import com.bhg.bhgadmin.share.utils.SpringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:56
 **/
@Slf4j
@Service
public class AdminUserServiceImpl implements IAdminUserService {


    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private StaticProperties staticProperties;

    @Autowired
    private DynamicProperties dynamicProperties;

    @Autowired
    private PasswordResetEmailProperties passwordResetEmailProperties;

    @Autowired
    private AdminUsersMapper adminUsersMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ExportService exportService;

    @Autowired
    private AuthRoleMapper roleMapper;

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Override
    public CommonResponse<AdminLoginResponse> adminLogin(AdminLoginRequest request, HttpServletRequest servletRequest)  {
        // if prod, check recaptcha
        if (EnvironmentTypeEnum.PROD.getMessage().equals(SpringUtils.getActiveProfile())) {
            checkCodeV2(servletRequest.getHeader("g-recaptcha-response"));
        }
//        AdminUsersEntity adminUser =
//            adminUsersMapper.selectOne(new LambdaQueryWrapper<AdminUsersEntity>().eq(AdminUsersEntity::getEmail, request.getUserEmail()));
//        if (ObjectUtils.isNotNull(adminUser) && !passwordEncoder.matches(request.getPassword(), adminUser.getEncryptedPassword())){
//            AdminUserErrorEnum.PASSWORD_ERROR.throwException();
//        }

        // use authenticate function in AuthenticationManager of Spring Security
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
            new UsernamePasswordAuthenticationToken(request.getAdminUserEmail(), request.getPassword());
        usernamePasswordAuthenticationToken.setDetails(UserTypeEnum.ADMIN);
        Authentication authenticate = null;
        try {
            authenticate = authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        } catch (BadCredentialsException e){
            AdminUserErrorEnum.PASSWORD_ERROR.throwException();
        }
        // authenticate failed
        if (Objects.isNull(authenticate)) {
            AdminUserErrorEnum.UNAUTHORIZED.throwException();
        }
        // generate JWT to front-end
        LoginUser loginUser = (LoginUser)authenticate.getPrincipal();
        String adminId = loginUser.getAdminUsersEntity().getId().toString();
        // set expired time
        String jwt = JwtUtil.createJWT(adminId, dynamicProperties.getTokenExpireTime());

        AdminLoginResponse adminLoginResponse = new AdminLoginResponse();
        adminLoginResponse.setAdminEmail(request.getAdminUserEmail());
        adminLoginResponse.setToken(jwt);
        adminLoginResponse.setPerms(loginUser.getPermissions().stream().map(PermissionDTO::getPermissionName).collect(Collectors.toList()));
        adminLoginResponse.setRoles(loginUser.getRoles());

        redisCache.setCacheObject(RedisConstants.ADMIN_USER_LOGIN_INFO +adminId, loginUser,
                                  dynamicProperties.getTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);
        return CommonResponse.success(adminLoginResponse);
    }

    @Override
    public CommonResponse<String> adminLogout() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        Long adminId = loginUser.getAdminUsersEntity().getId();
        redisCache.deleteObject(RedisConstants.ADMIN_USER_LOGIN_INFO+adminId);
        return CommonResponse.success(loginUser.getAdminUsersEntity().getEmail() + " logout success");
    }

    @SneakyThrows
    @Override
    public CommonResponse<Boolean> sendPasswordResetEmail(SendResetAdminPasswordRequest request) {
        // check Email exist
        AdminUsersEntity adminUser =
            adminUsersMapper.selectOne(new LambdaQueryWrapper<AdminUsersEntity>().eq(AdminUsersEntity::getEmail, request.getAdminEmail()));
        if (ObjectUtil.isNull(adminUser)){
            AdminUserErrorEnum.ADMIN_USER_NOT_EXIST.throwException();
        }

        // encrypt adminId, save it in Redis, use it to generate a Getmapping URL
        String passwordResetToken = AesUtils.encrypt(adminUser.getId().toString(), staticProperties.getEncryptKey());

        // generate Email
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
        mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
            new BizMailReceiverDTO(request.getAdminEmail(), request.getAdminEmail().substring(0, request.getAdminEmail().indexOf("@"))));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject(passwordResetEmailProperties.getSubject());
        mailjetSenderDTO.setTextPart(passwordResetEmailProperties.getTextPart());
        mailjetSenderDTO.setHtmlPart(passwordResetEmailProperties.getHtmlPart().replace("{passwordResetToken}", passwordResetToken));

        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        Boolean success = mailjetUtil.sendMail(mailjetUtil);
        if (!success){
            CommonErrorEnum.MAIL_FAIL_TO_SENT.throwException();
        }
        Date resetEmailSentAt = new Date();

        // put admin password reset token into Redis
        redisCache.setCacheObject(RedisConstants.ADMIN_PASSWORD_RESET_TOKEN + adminUser.getId(), passwordResetToken,
                                  dynamicProperties.getResetPasswordTokenExpireTime().intValue(), TimeUnit.MILLISECONDS);

        AdminUsersEntity adminUsersEntity = new AdminUsersEntity();
        adminUsersEntity.setId(adminUser.getId());
        adminUsersEntity.setResetPasswordToken(passwordResetToken);
        adminUsersEntity.setResetPasswordSentAt(resetEmailSentAt);
        adminUsersEntity.setUpdatedAt(resetEmailSentAt);
        adminUsersMapper.updateById(adminUsersEntity);
        return CommonResponse.success();
    }

    @SneakyThrows
    @Override
    public CommonResponse<Integer> resetPwdFromEmail(ResetPwdFromEmailRequest request) {
        String adminIdStr = AesUtils.decrypt(request.getEncryptedToken(), staticProperties.getEncryptKey());
        // get token from redis
        String token = redisCache.getCacheObject(RedisConstants.ADMIN_PASSWORD_RESET_TOKEN + adminIdStr);
        if (ObjectUtil.isNull(token) || !StringUtils.hasText(token)){
            AdminUserErrorEnum.PWD_RESET_TOKEN_EXPIRED.throwException();
        }
        if (!token.equals(request.getEncryptedToken())){
            redisCache.deleteObject(adminIdStr);
            AdminUserErrorEnum.PWD_RESET_TOKEN_INVALID.throwException();
        }
        LambdaUpdateWrapper<AdminUsersEntity> updateWrapper = Wrappers.<AdminUsersEntity>update().lambda()
            .set(AdminUsersEntity::getEncryptedPassword, passwordEncoder.encode(request.getPwd()))
            .set(AdminUsersEntity::getResetPasswordToken, null)
            .set(AdminUsersEntity::getResetPasswordSentAt, null)
            .set(AdminUsersEntity::getUpdatedAt, new Date())
            .eq(AdminUsersEntity::getId, Long.valueOf(adminIdStr));
        int result = adminUsersMapper.update(null, updateWrapper);
        redisCache.deleteObject(RedisConstants.ADMIN_PASSWORD_RESET_TOKEN + adminIdStr);
        return CommonResponse.success(result);
    }

    @Override
    public CommonResponse<PageInfo<AdminUsersResponse>> queryAdminUsers(AdminUserQueryRequest request, int pageNum, int pageSize) {
        PageInfo<AdminUsersEntity> adminUsersEntities = PageHelper.startPage(pageNum, pageSize)
                .doSelectPageInfo(()->getAdminUsersEntities(request));
        PageInfo<AdminUsersResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(adminUsersEntities, responses, "list");
        responses.setList(
            adminUsersEntities.getList().stream().map((AdminUsersEntity a) -> new AdminUsersResponse(a)).collect(
                Collectors.toList())
                         );

        return CommonResponse.success(responses);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createAdminUser(AdminUserCreateRequest request) {
        if (checkEmailExist(null, request.getAdminUserEmail())){
            AdminUserErrorEnum.EMAIL_EXIST.throwException(new Object[]{request.getAdminUserEmail()});
        }
        AdminUsersEntity adminUsersEntity = buildAdminUserEntity(request);
        adminUsersMapper.insert(adminUsersEntity);
        return CommonResponse.success(adminUsersEntity.getId());
    }

    @Override
    public CommonResponse<AdminUsersDetailResponse> queryAdminById(AdminUserDetailRequest request) {
        AdminUsersEntity adminUsersEntity = adminUsersMapper.selectOne(
            Wrappers.<AdminUsersEntity>query().lambda().eq(AdminUsersEntity::getId, request.getId()).eq(
                AdminUsersEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(adminUsersEntity)){
            AdminUserErrorEnum.ADMIN_USER_NOT_EXIST.throwException();
        }
        if (Objects.isNull(adminUsersEntity.getRoleId())){
            AdminUserErrorEnum.ADMIN_NO_ROLE.throwException();
        }
        String role = null;
        AuthRoleEntity roleEntity = roleMapper.selectOne(Wrappers.<AuthRoleEntity>query().lambda()
                            .eq(AuthRoleEntity::getId, adminUsersEntity.getRoleId())
                            .eq(AuthRoleEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNotNull(roleEntity)){
            role = roleEntity.getRoleName();
        }
        AdminUsersDetailResponse response = new AdminUsersDetailResponse(adminUsersEntity, role);
        return CommonResponse.success(response);
    }

    @Override
    public CommonResponse<AdminUsersEditDetailResponse> queryAdminByIdWhenEdit(AdminUserDetailRequest request) {
        AdminUsersEntity adminUsersEntity = adminUsersMapper.selectOne(
            Wrappers.<AdminUsersEntity>query().lambda().eq(AdminUsersEntity::getId, request.getId()).eq(
                AdminUsersEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(adminUsersEntity)){
            AdminUserErrorEnum.ADMIN_USER_NOT_EXIST.throwException();
        }
        AdminUsersEditDetailResponse response = new AdminUsersEditDetailResponse();
        response.setEmail(adminUsersEntity.getEmail());
        response.setRoleId(adminUsersEntity.getRoleId().toString());
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editAdmin(AdminUserEditRequest request) {
        if (checkEmailExist(request.getId(), request.getAdminUserEmail())){
            AdminUserErrorEnum.EMAIL_EXIST.throwException(new Object[]{request.getAdminUserEmail()});
        }
        int update = adminUsersMapper.update(null, Wrappers.<AdminUsersEntity>update().lambda()
            .set(StringUtils.hasText(request.getAdminUserEmail()), AdminUsersEntity::getEmail, request.getAdminUserEmail())
            .set(StringUtils.hasText(request.getPassword()), AdminUsersEntity::getEncryptedPassword, passwordEncoder.encode(request.getPassword()))
            .set(StringUtils.hasText(request.getAdminUserEmail()) && StringUtils.hasText(request.getPassword()), AdminUsersEntity::getUpdatedAt, new Date())
            .set(AdminUsersEntity::getRoleId, request.getRoleId())
            .eq(AdminUsersEntity::getId, request.getId()));

        return CommonResponse.success(request.getId());
    }

    @Override
    public CommonResponse<Integer> delAdmin(AdminUserDelRequest request) {
        int del = adminUsersMapper.update(null, Wrappers.<AdminUsersEntity>update().lambda()
                                         .set(AdminUsersEntity::getDelFlag, Boolean.TRUE)
                                         .set(AdminUsersEntity::getUpdatedAt, new Date())
                                         .eq(AdminUsersEntity::getId, request.getId())
                                         .eq(AdminUsersEntity::getDelFlag, Boolean.FALSE));
        if (del!=1){
            if (ObjectUtil.isNull(adminUsersMapper.selectOne(Wrappers.<AdminUsersEntity>query().lambda()
                                                            .eq(AdminUsersEntity::getId, request.getId())
                                                            .eq(AdminUsersEntity::getDelFlag, Boolean.FALSE)))) {
                AdminUserErrorEnum.ADMIN_USER_NOT_EXIST.throwException();
            }
            AdminUserErrorEnum.DEL_ADMIN_USER_FAIL.throwException();
        }
        return CommonResponse.success(del);
    }

    @Override
    public void exportAdminUsersCsv(AdminUserQueryRequest request, HttpServletResponse response) throws IOException {
        List<AdminUsersExportDTO> exportDTO = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_ADMINS+today+ ".csv";
        exportService.exportList(exportDTO, fileName, response, AdminUsersExportDTO.class);
    }

    @Override
    public List<AdminUsersExportDTO> exportAdminUsersXml(AdminUserQueryRequest request) {
        List<AdminUsersExportDTO> exportDTO = queryExportData(request);
        return exportDTO;
    }

    @Override
    public CommonResponse<List<RoleResponse>> queryRoles() {
        List<RoleResponse> response = roleMapper.queryRoles();
        return CommonResponse.success(response);
    }


    //    -----------------------------------------------------------------------------------------------

    public void checkCodeV2(String checkCode) {
        if (StringUtils.isEmpty(checkCode)) {
            log.error("对方法method :【checkCodeV2】,参数【checkCode】空指针异常！");
            AdminUserErrorEnum.NEED_GOOGLE_RECAPTCHA_RESPONSE.throwException();
        }
        String verifyUrl = "https://www.recaptcha.net/recaptcha/api/siteverify";
        try {
            Map<String, Object> checkMap = new HashMap<>();
            checkMap.put("secret", staticProperties.RECAPTCHA2_SECRET_KEY);
            checkMap.put("response", checkCode.trim());
            String json = MyHttpUtil.sendPost(verifyUrl, checkMap, "UTF-8");
            Map<String, Object> resultMap = new Gson().fromJson(json, new TypeToken<Map<String, Object>>() {
            }.getType());
            boolean resultCode = (boolean) resultMap.get("success");
            if (!resultCode) {
                String errorCode = resultMap.get("error-codes").toString();
                String errorInfo = null;
                if (StringUtils.isEmpty(errorCode)) {
                    errorInfo = errorCode;
                } else if (errorCode.contains("missing-input-secret")) {
                    errorInfo = "私钥参数丢失了。";
                } else if (errorCode.contains("invalid-input-secret")) {
                    errorInfo = "私钥参数无效或格式不正确。";
                } else if (errorCode.contains("missing-input-response")) {
                    errorInfo = "响应参数缺失。";
                } else if (errorCode.contains("invalid-input-response")) {
                    errorInfo = "响应参数无效或格式不正确。";
                } else if (errorCode.contains("bad-request")) {
                    errorInfo = "请求无效或格式不正确。";
                }
                log.info("对方法method :【check2】进行图形验证不通过,返回结果是: " + errorInfo);

            }
        } catch (Exception e) {
            log.error("对方法method :【check2】,参数【checkCode】验证过程中异常！"+e.getMessage());
            AdminUserErrorEnum.GOOGLE_RECAPTCHA_FAIL.throwException();
        }
    }
    private AdminUsersEntity buildAdminUserEntity(AdminUserCreateRequest request) {
        AdminUsersEntity adminUsersEntity = new AdminUsersEntity();
        adminUsersEntity.setEmail(request.getAdminUserEmail());
        adminUsersEntity.setEncryptedPassword(passwordEncoder.encode(request.getPassword()));
        adminUsersEntity.setRoleId(request.getRoleId());
        Date now = new Date();
        adminUsersEntity.setCreatedAt(now);
        adminUsersEntity.setUpdatedAt(now);
        return adminUsersEntity;
    }

    /**
     * true: Exist
     * false: Not Exist
     * @param
     * @return
     */
    private Boolean checkEmailExist(Long id, String email){
        // create
        if (ObjectUtil.isNull(id)){
            AdminUsersEntity adminUsersEntity = adminUsersMapper.selectOne(
                Wrappers.<AdminUsersEntity>query().lambda().eq(AdminUsersEntity::getEmail, email).eq(
                    AdminUsersEntity::getDelFlag, Boolean.FALSE));
            return ObjectUtil.isNull(adminUsersEntity) ? Boolean.FALSE : Boolean.TRUE;
        } else {
            // edit
            AdminUsersEntity adminUsersEntity = adminUsersMapper.selectOne(
                Wrappers.<AdminUsersEntity>query().lambda().eq(AdminUsersEntity::getId, id).eq(
                    AdminUsersEntity::getDelFlag, Boolean.FALSE));
            return adminUsersEntity.getId().equals(id) || ObjectUtil.isNull(adminUsersEntity) ? Boolean.FALSE :
                Boolean.TRUE;
        }
    }

    private List<AdminUsersEntity> getAdminUsersEntities(AdminUserQueryRequest request) {
        QueryWrapper<AdminUsersEntity> queryWrapper = Wrappers.<AdminUsersEntity>query();
        if (ObjectUtil.isNotNull(request.getFilterType())) {
            switch (EnumUtil.getByCode(FilterTypeEnum.class, request.getFilterType())) {
                case CONTAINS:
                    queryWrapper.like("LOWER(email)", request.getAdminUserEmail().toLowerCase());
                    break;
                case EQUALS:
                    queryWrapper.eq("LOWER(email)", request.getAdminUserEmail().toLowerCase());
                    break;
                case STARTS_WITH:
                    queryWrapper.likeRight("LOWER(email)", request.getAdminUserEmail().toLowerCase());
                    break;
                case ENDS_WITH:
                    queryWrapper.likeLeft("LOWER(email)", request.getAdminUserEmail().toLowerCase());
                    break;
                default:
                    break;
            }
        }
        queryWrapper.eq("del_flag", Boolean.FALSE);
        queryWrapper.orderByDesc("id");
        List<AdminUsersEntity> adminUsersEntities = adminUsersMapper.selectList(queryWrapper);
        return adminUsersEntities;
    }

    private List<AdminUsersExportDTO> queryExportData(AdminUserQueryRequest request) {
        List<AdminUsersEntity> adminUsersEntities = getAdminUsersEntities(request);
        List<RoleResponse> roles = roleMapper.queryRoles();
        return adminUsersEntities.stream().map((AdminUsersEntity a) -> new AdminUsersExportDTO(a,
                                                                                               roles.stream().filter(r -> r.getId().equals(a.getRoleId())).collect(
                                                                                                   Collectors.toList()).get(0).getRoleName())).collect(
            Collectors.toList());
    }
}
