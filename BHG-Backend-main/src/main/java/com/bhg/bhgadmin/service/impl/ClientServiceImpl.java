package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.CalendarUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.config.OssClientConfig;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizClientDetailDTO;
import com.bhg.bhgadmin.dto.biz.BizMailReceiverDTO;
import com.bhg.bhgadmin.dto.biz.BizMailjetSenderDTO;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.request.client.*;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.client.ClientDetailResponse;
import com.bhg.bhgadmin.dto.response.client.ClientEditDetailResponse;
import com.bhg.bhgadmin.dto.response.client.ClientsExportDTO;
import com.bhg.bhgadmin.dto.response.client.ClientsResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityEditResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityResponse;
import com.bhg.bhgadmin.dto.response.client.UpperClientsResponse;
import com.bhg.bhgadmin.entity.*;
import com.bhg.bhgadmin.mapper.*;
import com.bhg.bhgadmin.properties.StaticProperties;
import com.bhg.bhgadmin.service.IClientService;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.service.IStorageProcessor;
import com.bhg.bhgadmin.service.OperateLogService;
import com.bhg.bhgadmin.service.export.ExportService;
import com.bhg.bhgadmin.share.constants.CommonConstants;
import com.bhg.bhgadmin.share.constants.MailJetConstants;
import com.bhg.bhgadmin.share.enums.*;
import com.bhg.bhgadmin.share.error.ClientsErrorEnum;
import com.bhg.bhgadmin.share.utils.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mailjet.client.errors.MailjetException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 23:11
 **/
@Slf4j
@Service
public class ClientServiceImpl implements IClientService {

    private final static String INVESTMENT_ENTITY = "investment_entity";
    private final static String FILE_1_FRONT = "file_1_front";
    private final static String FILE_1_BACK = "file_1_back";
    private final static String FILE_2_FRONT = "file_2_front";
    private final static String FILE_2_BACK = "file_2_back";

    private final static String APPLICATION_FORM = "application_form_signed";

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private InvestmentEntitiesMapper investmentEntitiesMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private StaticProperties staticProperties;

    @Autowired
    private ExportService exportService;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private AuditMapper auditMapper;

    @Resource
    private PurchasedFundsMapper pfMapper;

    @Resource
    private IPurchasedFundsService pfService;

    @Resource
    private FundsMapper fundsMapper;

    @Resource
    private InvestmentEntitiesKycMapper investmentEntitiesKycMapper;

    @Resource
    OperateLogService logService;

    private static final List<Function<InvestmentEntities, String>> GET_LIST = Lists.newArrayList(
            InvestmentEntities::getApplicationFormSigned,
            InvestmentEntities::getApplicationFormSignedTwo,
            InvestmentEntities::getApplicationFormSignedThree,
            InvestmentEntities::getApplicationFormSignedFour
    );
    private static final List<BiConsumer<InvestmentEntities, String>> SET_LIST = Lists.newArrayList(
            InvestmentEntities::setApplicationFormSigned,
            InvestmentEntities::setApplicationFormSignedTwo,
            InvestmentEntities::setApplicationFormSignedThree,
            InvestmentEntities::setApplicationFormSignedFour
    );
    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Override
    public CommonResponse<PageInfo<ClientsResponse>> queryClients(ClientsQueryRequest request, int pageNum, int pageSize) {
        PageInfo<ClientsEntity> clientsEntityList = PageHelper.startPage(pageNum, pageSize)
            .doSelectPageInfo(()->getClientsEntities(request));

        PageInfo<ClientsResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(clientsEntityList, responses, "list");
        List<ClientsResponse> clientsResponses = buildClientsResponseList(clientsEntityList.getList());
        List<Long> clientIdList = clientsResponses.stream().map(ClientsResponse::getId).collect(Collectors.toList());
        responses.setList(clientsResponses);
        if (CollUtil.isEmpty(clientsResponses)) {
            return CommonResponse.success(responses);
        }
        List<PurchasedFundsEntity> pfList = pfMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>().in(PurchasedFundsEntity::getClientId, clientIdList)
                .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
        if (CollUtil.isEmpty(pfList)) {
            return CommonResponse.success(responses);
        }

        List<FundsEntity> fundList = fundsMapper.selectList(new LambdaQueryWrapper<FundsEntity>().in(FundsEntity::getId, pfList.stream().map(PurchasedFundsEntity::getFundId).collect(Collectors.toSet())));
        Map<Long, FundsEntity> fundMap = fundList.stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));
        Map<Long, List<PurchasedFundsEntity>> pfMap = pfList.stream().collect(Collectors.groupingBy(PurchasedFundsEntity::getClientId));
        LocalDate now = LocalDate.now();
        Calendar calendar = CalendarUtil.calendar();
        calendar.add(Calendar.MONTH, -1);
        LocalDate lastMonth = DateUtil.endOfMonth(calendar.getTime()).toLocalDateTime().toLocalDate();
        for (ClientsResponse client : clientsResponses) {
            List<PurchasedFundsEntity> tempPfList = pfMap.get(client.getId());
            if (CollUtil.isNotEmpty(tempPfList)) {
                for (PurchasedFundsEntity pf : tempPfList) {
                    FundsEntity fundsEntity = fundMap.get(pf.getFundId());
                    BizPurchasedFundsDTO bizPf = pfService.getBizPf(pf, fundsEntity);
                    client.addTotalAmount(bizPf.getPurchaseAmount());
                    BigDecimal currentReturn = BigDecimal.ZERO;
                    try {
                        currentReturn = pfService.getCurrentTotalReturnByDate(bizPf, now);
                    } catch (Exception e) {
                        log.error("currentReturn error", e);
                    }
                    client.addCurrentReturn(currentReturn);
                    BigDecimal prevReturn = BigDecimal.ZERO;
                    try {
                        prevReturn = pfService.getMonthReturnByDate(bizPf, lastMonth);
                    } catch (Exception e) {
                        log.error("prevReturn error", e);
                    }
                    client.addPrevMonthReturn(prevReturn);
                }
            }
        }
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<ClientDetailResponse> queryClientDetailById(ClientAndEntityDetailQueryRequest request) {
        BizClientDetailDTO bizClientDetailDTO = clientsMapper.queryClientDetailById(request.getId());
        if (ObjectUtil.isNull(bizClientDetailDTO)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        ClientsEntity clientsEntity = new ClientsEntity();
        BeanUtils.copyProperties(bizClientDetailDTO, clientsEntity);
        ClientDetailResponse response = new ClientDetailResponse(clientsEntity, bizClientDetailDTO.getUpperClientName()
                , bizClientDetailDTO.getLevel2UpperClientName());
        List<InvestmentEntitiesKyc> investmentEntities = investmentEntitiesKycMapper.selectList(
                Wrappers.<InvestmentEntitiesKyc>query().lambda().eq(InvestmentEntitiesKyc::getClientId, request.getId())
                        .eq(InvestmentEntitiesKyc::getDelFlag, Boolean.FALSE)
                        .orderByDesc(InvestmentEntitiesKyc::getUpdatedAt));
        if (CollUtil.isNotEmpty(investmentEntities)) {
            response.setKycStatus(investmentEntities.get(0).getKycStatus());
        }
        return CommonResponse.success(response);
    }

    @Override
    public CommonResponse<List<InvestmentEntityResponse>> queryInvestmentEntityById(ClientAndEntityDetailQueryRequest request) {
        List<InvestmentEntitiesKyc> investmentEntities = investmentEntitiesKycMapper.selectList(
            Wrappers.<InvestmentEntitiesKyc>query().lambda().eq(InvestmentEntitiesKyc::getClientId, request.getId()).eq(InvestmentEntitiesKyc::getDelFlag, Boolean.FALSE).orderByDesc(InvestmentEntitiesKyc::getUpdatedAt));
        List<InvestmentEntityResponse> responses =
            investmentEntities.stream().map((InvestmentEntitiesKyc i) -> {
                InvestmentEntityResponse response = BeanUtil.copyProperties(i, InvestmentEntityResponse.class);
                response.setEntity(i);
                if (StringUtils.hasText(i.getFile1Front())) {
                    response.setFile1Front(getInvestmentFileFullPath(FILE_1_FRONT, i.getId(), i.getFile1Front()));
                }
                if (StringUtils.hasText(i.getFile1Back())){
                    response.setFile1Back(getInvestmentFileFullPath(FILE_1_BACK, i.getId(), i.getFile1Back()));
                }
                if (StringUtils.hasText(i.getFile2Front())) {
                    response.setFile2Front(getInvestmentFileFullPath(FILE_2_FRONT, i.getId(), i.getFile2Front()));
                }
                if (StringUtils.hasText(i.getFile2Back())){
                    response.setFile2Back(getInvestmentFileFullPath(FILE_2_BACK, i.getId(), i.getFile2Back()));
                }
                return response;
            }).collect(Collectors.toList());
        return CommonResponse.success(responses);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createClient(ClientCreateRequest request) {
        if (checkEmailExist(null, request.getEmail())){
            ClientsErrorEnum.EMAIL_EXIST.throwException(new Object[]{request.getEmail()});
        }
        ClientsEntity clientsEntity = new ClientsEntity();
        buildClientEntity(request, clientsEntity);
        clientsMapper.insert(clientsEntity);
        logService.saveLog(OperateEntityTypeEnum.CLIENT.getMessage(), clientsEntity.getId(), OperateTypeEnum.CREATE.getMessage(), clientsEntity.getName());
//        batchInsertNewInvestments(buildInvestmentEntities(request.getInvestmentCreateRequestList(), clientsEntity));
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        try {
            List<BizMailReceiverDTO> bizMailReceiverDTOS = Lists.newArrayList(new BizMailReceiverDTO(clientsEntity.getEmail(), clientsEntity.getName()));
            mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
            mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setSubject(MailJetConstants.NEW_CLIENT_EMAIL_SUBJECT);
            mailjetSenderDTO.setTemplateId(MailJetConstants.NEW_CLIENT_EMAIL_TEMPLATE_ID);
            JSONObject variables = new JSONObject()
                    .set("entity_name", clientsEntity.getName())
                    .set("name", clientsEntity.getName())
                    .set("email", clientsEntity.getEmail())
                    ;
            mailjetSenderDTO.setVariables(variables);
            MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
            mailjetUtil.sendMailWithTemplate(mailjetUtil);
        } catch (MailjetException e) {
            log.error("new client mail error, {}", JSONUtil.toJsonStr(mailjetSenderDTO), e);
        }
        return CommonResponse.success(clientsEntity.getId());
    }


    @Override
    public CommonResponse<ClientEditDetailResponse> queryClientDetailByIdWhenEdit(ClientAndEntityDetailQueryRequest request) {
        ClientsEntity clientsEntity = clientsMapper.selectOne(
            Wrappers.<ClientsEntity>query().lambda().eq(ClientsEntity::getId, request.getId()).eq(
                ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(clientsEntity)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        return CommonResponse.success(new ClientEditDetailResponse(clientsEntity));
    }

    @Override
    public CommonResponse<List<InvestmentEntityEditResponse>> queryInvestmentEntityByIdWhenEdit(ClientAndEntityDetailQueryRequest request) {
        List<InvestmentEntities> investmentEntitiesList = queryInvestmentEntitiesByClientId(request);
        List<InvestmentEntityEditResponse> responses =
            investmentEntitiesList.stream().map((InvestmentEntities i)-> {
                InvestmentEntityEditResponse response = BeanUtil.copyProperties(i, InvestmentEntityEditResponse.class);
                response.setEntity(i);
                return response;
            }).collect(
                Collectors.toList());
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<List<UpperClientsResponse>> queryUpperClients() {
        return CommonResponse.success(clientsMapper.queryUpperClients());
    }

    @Override
    public void exportClientsCsv(ClientsQueryRequest request, HttpServletResponse response) throws IOException {
        List<ClientsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_CLIENTS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, ClientsExportDTO.class);
    }

    @Override
    public CommonResponse<List<ClientsResponse>> queryDownwardClients(ClientsDownwardQueryRequest request) {
        ClientsEntity upperClientsEntity = clientsMapper.selectById(request.getUpperClientId());
        List<ClientsEntity> clientsEntityList = null;
        if (ObjectUtil.isNull(upperClientsEntity.getUpperClientId()) || upperClientsEntity.getId().equals(upperClientsEntity.getUpperClientId())) {
            clientsEntityList = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda().eq(ObjectUtil.isNotNull(request.getUpperClientId()),
                                                                                                                         ClientsEntity::getUpperClientId, request.getUpperClientId()
                                                                                                                        ).eq(ClientsEntity::getDelFlag, Boolean.FALSE).orderByDesc(
                ClientsEntity::getId));
        } else {
            clientsEntityList = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda().eq(ObjectUtil.isNotNull(request.getUpperClientId()),
                                                                                                     ClientsEntity::getLevel2UpperClientId, request.getUpperClientId()
                                                                                                    ).eq(ClientsEntity::getDelFlag, Boolean.FALSE).orderByDesc(
                ClientsEntity::getId));
        }
        List<ClientsResponse> clientsResponses = buildClientsResponseList(clientsEntityList);
        return CommonResponse.success(clientsResponses);
    }

    @Override
    public List<ClientsExportDTO> exportClientsXml(ClientsQueryRequest request) {
        List<ClientsExportDTO> response = queryExportData(request);
        return response;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editClient(ClientEditRequest request) {
        ClientsEntity oldClient = clientsMapper.selectById(request.getId());
        ClientsEntity clientsEntity = new ClientsEntity();
        Audit audit = new Audit();
        clientsEntity.setId(request.getId());
        buildClientEntity(request, clientsEntity);
        clientsEntity.setCreatedAt(null);
        if (checkEmailExist(request.getId(), request.getEmail())){
            ClientsErrorEnum.EMAIL_EXIST.throwException(new Object[]{request.getEmail()});
        }
        if (LoginUserUtil.getLoginAdmin() == null) {
            Map<String, Pair<Object, Object>> editMap = OperationLogUtil.operationLog(clientsEntity, oldClient);
            if (CollUtil.isNotEmpty(editMap)) {
                if (oldClient.getStatus().equals(EntityStatusEnum.LOCKED.getMessage())) {
                    audit = auditMapper.selectOne(new LambdaQueryWrapper<Audit>()
                            .eq(Audit::getEntityId, oldClient.getId())
                            .eq(Audit::getStatus, AuditStatusEnum.PENDING_APPROVAL.getMessage())
                            .eq(Audit::getAuditType, AuditTypeEnum.CLIENT.getMessage())
                            .orderByDesc(Audit::getId).last("limit 1")
                    );

                    if (audit != null) {
                        audit.setCreator(LoginUserUtil.getLoginUserId());
                        audit.setCreatorName(LoginUserUtil.getLoginUserName());
                        audit.setEntityContent(JSONUtil.toJsonStr(editMap));
                        audit.setNewEntity(JSONUtil.toJsonStr(clientsEntity));
                    }
                    auditMapper.updateById(audit);
                } else {
                    audit.setAuditType(AuditTypeEnum.CLIENT.getMessage());
                    audit.setEntityContent(JSONUtil.toJsonStr(editMap));
                    audit.setNewEntity(JSONUtil.toJsonStr(clientsEntity));
                    audit.setEntityId(clientsEntity.getId());
                    audit.setEntityName(oldClient.getName());
                    audit.setStatus(AuditStatusEnum.PENDING_APPROVAL.getMessage());
                    audit.setCreator(LoginUserUtil.getLoginUserId());
                    audit.setCreatorName(LoginUserUtil.getLoginUserName());
                    auditMapper.insert(audit);
                }
            }
        } else {
            clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                    .set(ClientsEntity::getUpperClientId, clientsEntity.getUpperClientId())
                    .set(ClientsEntity::getLevel2UpperClientId, clientsEntity.getLevel2UpperClientId())
                    .set(ClientsEntity::getBeaverId, clientsEntity.getBeaverId())
                    .set(ClientsEntity::getName, clientsEntity.getName())
                    .set(ClientsEntity::getClientType, clientsEntity.getClientType())
                    .set(ClientsEntity::getCountryCode, clientsEntity.getCountryCode())
                    .set(ClientsEntity::getMobile, clientsEntity.getMobile())
                    .set(ClientsEntity::getBirth, clientsEntity.getBirth())
                    .set(ClientsEntity::getUpdatedAt, clientsEntity.getUpdatedAt())
                    .set(ClientsEntity::getBsb, clientsEntity.getBsb())
                    .set(ClientsEntity::getAccountName, clientsEntity.getAccountName())
                    .set(ClientsEntity::getAccountNumber, clientsEntity.getAccountNumber())
                    .set(ClientsEntity::getStartDate, clientsEntity.getStartDate())
                    .set(ClientsEntity::getEndDate, clientsEntity.getEndDate())
                    .set(ClientsEntity::getInterestedFund, clientsEntity.getInterestedFund())
                    .set(ClientsEntity::getInvestEntity, clientsEntity.getInvestEntity())
                    .set(ClientsEntity::getInvestStatus, clientsEntity.getInvestStatus())
                    .set(ClientsEntity::getLinkToValueup, clientsEntity.getLinkToValueup())
                    .set(ClientsEntity::getTargetAmount, clientsEntity.getTargetAmount())
                    .set(ClientsEntity::getWithheldTax, clientsEntity.getWithheldTax())
                    .set(ClientsEntity::getTfNum, clientsEntity.getTfNum())
                    .eq(ClientsEntity::getId, clientsEntity.getId()));
            logService.saveUpdateLog(OperateEntityTypeEnum.CLIENT.getMessage(), clientsEntity.getId(), clientsEntity, oldClient, clientsEntity.getName());
        }
        return CommonResponse.success(clientsEntity.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<String> delClient(ClientDelRequest request) {
        int update = clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
            .set(ClientsEntity::getDelFlag, Boolean.TRUE)
            .set(ClientsEntity::getUpdatedAt, new Date())
            .eq(ClientsEntity::getId, request.getId())
            .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        ClientsEntity clientsEntity = clientsMapper.selectById(request.getId());
        if (update!=1){
            if (ObjectUtil.isNull(clientsEntity)){
                ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
            }
            ClientsErrorEnum.CLIENT_DEL_FAIL.throwException();
        }
        investmentEntitiesMapper.update(null, Wrappers.<InvestmentEntities>update().lambda()
                                       .set(InvestmentEntities::getDelFlag, Boolean.TRUE)
                                       .set(InvestmentEntities::getUpdatedAt, new Date())
                                       .eq(InvestmentEntities::getClientId, request.getId()));
        logService.saveLog(OperateEntityTypeEnum.CLIENT.getMessage(), request.getId(), OperateTypeEnum.DELETE.getMessage(), clientsEntity.getName());
        return CommonResponse.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<String> resetClientPwd(ClientDelRequest request) {
        String encodePwd = passwordEncoder.encode(staticProperties.getClientDefaultPassword());
        int update = clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
            .set(ClientsEntity::getEncryptedPassword, encodePwd)
            .set(ClientsEntity::getUpdatedAt, new Date())
            .eq(ClientsEntity::getId, request.getId()));
        if (update!=1){
            if (ObjectUtil.isNull(clientsMapper.selectById(request.getId()))){
                ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
            }
        }
        return CommonResponse.success(String.valueOf(update));
    }





    //    -----------------------------------------------------------------------------------------------
    private List<ClientsEntity> getClientsEntities(ClientsQueryRequest request) {
        return clientsMapper.queryClientList(request);
    }

    private List<ClientsResponse> buildClientsResponseList(List<ClientsEntity> clientsEntityList) {
        List<ClientsResponse> responses = clientsEntityList.stream().map((ClientsEntity t) ->{
            List<ClientsEntity> level1Client = clientsEntityList.stream().filter(
                c -> c.getId().equals(t.getUpperClientId())).collect(Collectors.toList());
            //get Upper client entity from clientsEntityList, not exist? Or from DB
            ClientsEntity level1ClientEntity = CollectionUtil.isEmpty(level1Client) ? clientsMapper.selectById(t.getUpperClientId()) : level1Client.get(0);

            //get Level 2 Upper client entity from clientsEntityList, not exist? Or from DB
            List<ClientsEntity> level2Client = clientsEntityList.stream().filter(
                c -> c.getId().equals(t.getLevel2UpperClientId())).collect(Collectors.toList());
            ClientsEntity level2ClientEntity = CollectionUtil.isEmpty(level2Client) ? clientsMapper.selectById(t.getLevel2UpperClientId()) : level2Client.get(0);
            // set upper client name to constructor
            return new ClientsResponse(t, ObjectUtil.isNull(level1ClientEntity) ? null : level1ClientEntity.getName()
                , ObjectUtil.isNull(level2ClientEntity) ? null : level2ClientEntity.getName());
        }).collect(Collectors.toList());
        return responses;
    }
    private ClientsEntity buildClientEntity(ClientCreateRequest request, ClientsEntity clientsEntity) {
        clientsEntity.setEmail(request.getEmail());
        // null代表新增
        if (ObjectUtil.isNull(clientsEntity.getId())) {
            if (!StringUtils.hasText(request.getPassword())){
                ClientsErrorEnum.CLIENT_PASSWORD_CANNOT_BLANK.throwException();
            }
            clientsEntity.setEncryptedPassword(passwordEncoder.encode(request.getPassword()));
        }
        clientsEntity.setSignInCount(0);
        clientsEntity.setUpperClientId(request.getUpperClient());
        clientsEntity.setLevel2UpperClientId(request.getLevel2UpperClientId());
        clientsEntity.setBeaverId(request.getBeaverId());
        clientsEntity.setName(request.getName());
        clientsEntity.setClientType(request.getClientType());
        clientsEntity.setCountryCode(request.getCountryCode());
        clientsEntity.setMobile(request.getMobile());
        clientsEntity.setBirth(request.getBirth());
        Date nowTime = new Date();
        clientsEntity.setCreatedAt(nowTime);
        clientsEntity.setUpdatedAt(nowTime);
        clientsEntity.setBsb(request.getBsb());
        clientsEntity.setAccountName(request.getAccountName());
        clientsEntity.setAccountNumber(request.getAccountNumber());
        clientsEntity.setStartDate(request.getStartDate());
        clientsEntity.setEndDate(request.getEndDate());
        clientsEntity.setTargetAmount(request.getTargetAmount());
        clientsEntity.setLinkToValueup(request.getLinkToValueup());
        clientsEntity.setWithheldTax(request.getWithheldTax());
        clientsEntity.setTfNum(request.getTfNum());
        return clientsEntity;
    }

    private List<InvestmentEntities> buildInvestmentEntities(List<InvestmentCreateRequest> request, ClientsEntity clientsEntity) {
        List<InvestmentEntities> investmentEntitiesList = new ArrayList<>();
        for (InvestmentCreateRequest invest : request){
            InvestmentEntities entity = new InvestmentEntities();
            entity.setClientId(clientsEntity.getId());
            entity.setEntityType(invest.getEntityType());
            entity.setEntityName(invest.getEntityName());
            entity.setKycResult(invest.getKycResult());
            Date now = new Date();
            entity.setCreatedAt(now);
            entity.setUpdatedAt(now);
            entity.setBsb(clientsEntity.getBsb());
            entity.setAccountNumber(clientsEntity.getAccountNumber());
            entity.setAccountName(clientsEntity.getAccountName());
            investmentEntitiesList.add(entity);
        }
        return investmentEntitiesList;
    }
    private List<InvestmentEntities> buildEditInvestmentEntities(List<InvestmentCreateRequest> request, ClientsEntity clientsEntity) {
        List<InvestmentEntities> investmentEntitiesList = new ArrayList<>();
        for (InvestmentCreateRequest invest : request){
            InvestmentEntities entity = new InvestmentEntities();
            entity.setId(invest.getId());
            entity.setClientId(clientsEntity.getId());
            entity.setEntityType(invest.getEntityType());
            entity.setEntityName(invest.getEntityName());
            entity.setKycResult(invest.getKycResult());
            Date now = new Date();
            entity.setUpdatedAt(now);
            entity.setBsb(clientsEntity.getBsb());
            entity.setAccountNumber(clientsEntity.getAccountNumber());
            entity.setAccountName(clientsEntity.getAccountName());
            investmentEntitiesList.add(entity);
        }
        return investmentEntitiesList;
    }

    /**
     * true: Exist
     * false: Not Exist
     * @param
     * @return
     */
    @Override
    public Boolean checkEmailExist(Long id, String email){
        ClientsEntity clientsEntity = clientsMapper.selectOne(
            Wrappers.<ClientsEntity>query().lambda()
                .eq(ClientsEntity::getEmail, email)
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE).last( " limit 1"));
        if (ObjectUtil.isNull(id)){
            return ObjectUtil.isNull(clientsEntity) ? Boolean.FALSE : Boolean.TRUE;
        } else {
            return ObjectUtil.isNull(clientsEntity) || clientsEntity.getId().equals(id) ? Boolean.FALSE : Boolean.TRUE;
        }
    }

    private List<ClientsExportDTO> queryExportData(ClientsQueryRequest request) {
        List<ClientsEntity> clientsEntities = getClientsEntities(request);
        List<ClientsExportDTO> exportDTOS = clientsEntities.stream().map((ClientsEntity c)->new ClientsExportDTO(c)).collect(
            Collectors.toList());
        return exportDTOS;
    }

    private List<InvestmentEntities> queryInvestmentEntitiesByClientId(ClientAndEntityDetailQueryRequest request) {
        List<InvestmentEntities> investmentEntitiesList = investmentEntitiesMapper.selectList(Wrappers.<InvestmentEntities>query().lambda()
                                                                                                  .eq(request.getId() != null, InvestmentEntities::getClientId, request.getId())
                                                                                                  .eq(request.getEntityId() != null, InvestmentEntities::getId, request.getEntityId())
                                                                                                  .eq(InvestmentEntities::getDelFlag, Boolean.FALSE)
                                                                                                  .orderByDesc(InvestmentEntities::getId));
        return investmentEntitiesList;
    }

    @Override
    public String getInvestmentFileFullPath(String fileType, Long investmentId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(INVESTMENT_ENTITY, fileType, investmentId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }

    @Override
    public CommonResponse<Long> createEntity(InvestmentCreateRequest request, MultipartFile applicationFormSigned,
                                             MultipartFile applicationFormSignedTwo,
                                             MultipartFile applicationFormSignedThree,
                                             MultipartFile applicationFormSignedFour) {
        InvestmentEntities oldEntity = investmentEntitiesMapper.selectOne(new LambdaQueryWrapper<InvestmentEntities>()
                .eq(InvestmentEntities::getClientId, request.getClientId())
                .eq(InvestmentEntities::getDelFlag, Boolean.FALSE)
                .eq(InvestmentEntities::getEntityName, request.getEntityName())
                .last(" limit 1")
        );
        if (oldEntity != null) {
            return CommonResponse.error(oldEntity.getEntityName() + " EXCISE");
        }
        InvestmentEntities entity = BeanUtil.copyProperties(request, InvestmentEntities.class);
        if (ObjectUtils.isNotNull(applicationFormSigned)){
            entity.setApplicationFormSigned(storageProcessor.generateUploadFileName(applicationFormSigned.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedTwo)){
            entity.setApplicationFormSignedTwo(storageProcessor.generateUploadFileName(applicationFormSignedTwo.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedThree)){
            entity.setApplicationFormSignedThree(storageProcessor.generateUploadFileName(applicationFormSignedThree.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedFour)){
            entity.setApplicationFormSignedFour(storageProcessor.generateUploadFileName(applicationFormSignedFour.getOriginalFilename()));
        }
        investmentEntitiesMapper.insert(entity);
        logService.saveLog(OperateEntityTypeEnum.ENTITY.getMessage(), entity.getId(), OperateTypeEnum.CREATE.getMessage(), entity.getEntityName());
        if (ObjectUtils.isNotNull(applicationFormSigned)){
            saveApplicationFormInOss(applicationFormSigned, entity, entity.getApplicationFormSigned());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedTwo)){
            saveApplicationFormInOss(applicationFormSignedTwo, entity, entity.getApplicationFormSignedTwo());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedThree)){
            saveApplicationFormInOss(applicationFormSignedThree, entity, entity.getApplicationFormSignedThree());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedFour)){
            saveApplicationFormInOss(applicationFormSignedFour, entity, entity.getApplicationFormSignedFour());
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<Long> editEntity(InvestmentCreateRequest request, MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour) {
        InvestmentEntities oldEntity = investmentEntitiesMapper.selectById(request.getId());
        InvestmentEntities entity = BeanUtil.copyProperties(request, InvestmentEntities.class);
        for (int i = 0; i < GET_LIST.size(); i++) {
            String str = GET_LIST.get(i).apply(entity);
            if (CharSequenceUtil.isNotBlank(str)) {
                SET_LIST.get(i).accept(entity, str.substring(str.lastIndexOf("/") + 1));
            }
        }
        if (ObjectUtils.isNotNull(applicationFormSigned)){
            entity.setApplicationFormSigned(storageProcessor.generateUploadFileName(applicationFormSigned.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedTwo)){
            entity.setApplicationFormSignedTwo(storageProcessor.generateUploadFileName(applicationFormSignedTwo.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedThree)){
            entity.setApplicationFormSignedThree(storageProcessor.generateUploadFileName(applicationFormSignedThree.getOriginalFilename()));
        }
        if (ObjectUtils.isNotNull(applicationFormSignedFour)){
            entity.setApplicationFormSignedFour(storageProcessor.generateUploadFileName(applicationFormSignedFour.getOriginalFilename()));
        }
        Map<String, Pair<Object, Object>> editMap = OperationLogUtil.operationLog(entity, oldEntity);
        if (LoginUserUtil.getLoginAdmin() == null) {
            Audit audit = new Audit();
            if (CollUtil.isNotEmpty(editMap)) {
                if (oldEntity.getStatus().equals(EntityStatusEnum.LOCKED.getMessage())) {
                    audit = auditMapper.selectOne(new LambdaQueryWrapper<Audit>()
                            .eq(Audit::getEntityId, oldEntity.getId())
                            .eq(Audit::getStatus, AuditStatusEnum.PENDING_APPROVAL.getMessage())
                            .eq(Audit::getAuditType, AuditTypeEnum.ENTITY.getMessage())
                            .orderByDesc(Audit::getId).last("limit 1")
                    );

                    if (audit != null) {
                        audit.setCreator(LoginUserUtil.getLoginUserId());
                        audit.setCreatorName(LoginUserUtil.getLoginUserName());
                        audit.setEntityContent(JSONUtil.toJsonStr(editMap));
                        audit.setNewEntity(JSONUtil.toJsonStr(entity));
                    }
                    auditMapper.updateById(audit);
                } else {
                    audit.setAuditType(AuditTypeEnum.ENTITY.getMessage());
                    audit.setEntityContent(JSONUtil.toJsonStr(editMap));
                    audit.setNewEntity(JSONUtil.toJsonStr(entity));
                    audit.setEntityId(oldEntity.getId());
                    audit.setEntityName(oldEntity.getAccountName());
                    audit.setStatus(AuditStatusEnum.PENDING_APPROVAL.getMessage());
                    audit.setCreator(LoginUserUtil.getLoginUserId());
                    audit.setCreatorName(LoginUserUtil.getLoginUserName());
                    auditMapper.insert(audit);
                }
            }
        }else{
            investmentEntitiesMapper.updateById(entity);
            logService.saveUpdateLog(OperateEntityTypeEnum.ENTITY.getMessage(), oldEntity.getId(), entity, oldEntity, entity.getEntityName());
        }
        if (ObjectUtils.isNotNull(applicationFormSigned)){
            saveApplicationFormInOss(applicationFormSigned, entity, entity.getApplicationFormSigned());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedTwo)){
            saveApplicationFormInOss(applicationFormSignedTwo, entity, entity.getApplicationFormSignedTwo());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedThree)){
            saveApplicationFormInOss(applicationFormSignedThree, entity, entity.getApplicationFormSignedThree());
        }
        if (ObjectUtils.isNotNull(applicationFormSignedFour)){
            saveApplicationFormInOss(applicationFormSignedFour, entity, entity.getApplicationFormSignedFour());
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<List<InvestmentEntityResponse>> queryEntity(EntityQueryRequest request) {
        if (request == null) {
            request = new EntityQueryRequest();
        }
        Map<Long, List<BizPurchasedFundsDTO>> entityPfMap;
        if (request.getClientId() != null) {
            PurchasedFundsQueryRequest pfRequest = new PurchasedFundsQueryRequest();
            pfRequest.setClientId(request.getClientId());
            List<BizPurchasedFundsDTO> pfList = pfMapper.queryPurchasedFunds(pfRequest);
            entityPfMap = pfList.stream().filter(p -> p.getInvestmentEntityId() != null)
                    .collect(Collectors.groupingBy(BizPurchasedFundsDTO::getInvestmentEntityId));
        } else {
            entityPfMap = Maps.newHashMap();
        }
        List<InvestmentEntities> list = investmentEntitiesMapper.selectList(new LambdaQueryWrapper<InvestmentEntities>()
                .eq(request.getClientId() != null, InvestmentEntities::getClientId, request.getClientId())
                .eq(request.getId() != null, InvestmentEntities::getId, request.getId())
                .eq(InvestmentEntities::getDelFlag, Boolean.FALSE)
        );
        //https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/test/uploads/investment_entities/application_form_signed/325/1820070611402706947.png
        //https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/test/uploads/investment_entity/application_form_signed/325/1820070611402706944.webp
        Date date = new Date();
        if (CollUtil.isNotEmpty(list)) {
            List<InvestmentEntityResponse> collect = list.stream().map(i -> {
                InvestmentEntityResponse temp = BeanUtil.copyProperties(i, InvestmentEntityResponse.class);
                if (StringUtils.hasText(i.getApplicationFormSigned())) {
                    temp.setApplicationFormSigned(getInvestmentFileFullPath(APPLICATION_FORM, i.getId(), i.getApplicationFormSigned()));
                }
                if (StringUtils.hasText(i.getApplicationFormSignedTwo())) {
                    temp.setApplicationFormSignedTwo(getInvestmentFileFullPath(APPLICATION_FORM, i.getId(), i.getApplicationFormSignedTwo()));
                }
                if (StringUtils.hasText(i.getApplicationFormSignedThree())) {
                    temp.setApplicationFormSignedThree(getInvestmentFileFullPath(APPLICATION_FORM, i.getId(), i.getApplicationFormSignedThree()));
                }
                if (StringUtils.hasText(i.getApplicationFormSignedFour())) {
                    temp.setApplicationFormSignedFour(getInvestmentFileFullPath(APPLICATION_FORM, i.getId(), i.getApplicationFormSignedFour()));
                }
                temp.setEntity(i);
                List<BizPurchasedFundsDTO> tempList = entityPfMap.get(i.getId());
                if (CollUtil.isNotEmpty(tempList)) {
                    for (BizPurchasedFundsDTO dto : tempList) {
                        Date startReturnDay = pfService.getStartReturnDay(dto);
                        Date endDay = pfService.getEndDay(dto, EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory()));
                        if (startReturnDay != null && !startReturnDay.after(date) && (endDay == null || !endDay.before(date))) {
                            temp.setActive(Boolean.TRUE);
                            break;
                        }
                    }
                }
                return temp;
            }).collect(Collectors.toList());
            return CommonResponse.success(collect);
        } else {
            return CommonResponse.success();
        }

    }

    @Override
    public CommonResponse<Long> approvedClientKyc(ClientEditRequest request) {
        if (request != null && request.getId() != null) {
            List<InvestmentEntitiesKyc> kycList = investmentEntitiesKycMapper.selectList(new LambdaQueryWrapper<InvestmentEntitiesKyc>()
                    .eq(InvestmentEntitiesKyc::getClientId, request.getId()));
            if (CollUtil.isNotEmpty(kycList)) {
                investmentEntitiesKycMapper.update(null, new LambdaUpdateWrapper<InvestmentEntitiesKyc>()
                        .set(InvestmentEntitiesKyc::getKycStatus, KycStatusEnum.APPROVED.getCode())
                        .eq(InvestmentEntitiesKyc::getClientId, request.getId()));
            } else {
                InvestmentEntitiesKyc entity = new InvestmentEntitiesKyc();
                entity.setClientId(request.getId());
                entity.setKycResult(Boolean.FALSE);
                entity.setKycStatus(KycStatusEnum.APPROVED.getCode());
                Date now = new Date();
                entity.setCreatedAt(now);
                entity.setUpdatedAt(now);
                investmentEntitiesKycMapper.insert(entity);
            }
            return CommonResponse.success(request.getId());
        }
        return CommonResponse.error("id missing");
    }

    @Override
    public CommonResponse<Long> refuseClientKyc(ClientEditRequest request) {
        if (request != null && request.getId() != null) {
            investmentEntitiesKycMapper.update(null, new LambdaUpdateWrapper<InvestmentEntitiesKyc>()
                    .set(InvestmentEntitiesKyc::getKycStatus, KycStatusEnum.NOT_VERIFIED.getCode())
                    .eq(InvestmentEntitiesKyc::getClientId, request.getId()));
            return CommonResponse.success(request.getId());
        }
        return CommonResponse.error("id missing");
    }

    private void saveApplicationFormInOss(MultipartFile file, InvestmentEntities entity, String fileName) {
        try {
            storageProcessor.store(file.getInputStream(), INVESTMENT_ENTITY, APPLICATION_FORM,
                    entity.getId().toString(), fileName);
        } catch (IOException e) {
            e.printStackTrace();
            ClientsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {APPLICATION_FORM});
        }
    }

    private void batchInsertNewInvestments(List<InvestmentEntities> investmentEntities) {
        List<InvestmentEntities> investmentEntitiesList = investmentEntities;
        investmentEntitiesList.forEach(i -> {
            investmentEntitiesMapper.insert(i);
        });
    }

    private void batchEditInvestments(List<InvestmentEntities> investmentEntities) {
        List<InvestmentEntities> investmentEntitiesList = investmentEntities;
        investmentEntitiesList.forEach(i -> {
            investmentEntitiesMapper.updateById(i);
        });
    }

    private int batchDelInvestments(List<Long> investmentIds) {
        return investmentEntitiesMapper.update(null, Wrappers.<InvestmentEntities>update().lambda()
            .set(InvestmentEntities::getDelFlag, Boolean.TRUE)
            .set(InvestmentEntities::getUpdatedAt, new Date())
            .in(InvestmentEntities::getId, investmentIds)
            .eq(InvestmentEntities::getDelFlag, Boolean.FALSE));
    }
}
