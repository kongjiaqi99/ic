package com.ic.icadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.*;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.text.StrBuilder;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.aspose.words.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.api.dto.request.ApplicationFormRequest;
import com.ic.icadmin.api.dto.request.ReInvestmentRequest;
import com.ic.icadmin.api.service.IApiClientService;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizMailReceiverDTO;
import com.ic.icadmin.dto.biz.BizMailjetSenderDTO;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.investment.InvestmentRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundCreateRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundEditRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.ic.icadmin.dto.response.client.InvestmentEntityResponse;
import com.ic.icadmin.dto.response.investment.InvestmentGlobalResponse;
import com.ic.icadmin.dto.response.investment.InvestmentRecord;
import com.ic.icadmin.dto.response.investment.InvestmentResponse;
import com.ic.icadmin.dto.response.purchasedFunds.*;
import com.ic.icadmin.entity.*;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.mapper.FundsMapper;
import com.ic.icadmin.mapper.InvestmentEntitiesMapper;
import com.ic.icadmin.mapper.PurchasedFundsMapper;
import com.ic.icadmin.properties.DynamicProperties;
import com.ic.icadmin.properties.StaticProperties;
import com.ic.icadmin.service.*;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.constants.MailJetConstants;
import com.ic.icadmin.share.constants.RedisConstants;
import com.ic.icadmin.share.enums.*;
import com.ic.icadmin.share.error.ClientsErrorEnum;
import com.ic.icadmin.share.error.CommonErrorEnum;
import com.ic.icadmin.share.error.FundsErrorEnum;
import com.ic.icadmin.share.error.PurchasedFundsErrorEnum;
import com.ic.icadmin.share.utils.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.mailjet.client.errors.MailjetException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.function.BiConsumer;
import java.util.function.Function;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.ic.icadmin.share.constants.FileConstant.APPLICATION_PDF;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-17 15:49
 **/
@Slf4j
@Service
@RefreshScope
public class PurchasedFundsServiceImpl implements IPurchasedFundsService {

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    private final static String PURCHASED_FUND = "purchased_fund";
    private final static String RE_INVESTMENT = "re_investment";

    private final static String UNIT_CERTI = "unit_certi";

    private final static String APPLICATION_FORM = "application_form(signed)";
    private final static String FILE = "file";

//    about generating pdf start
    private final static String BC_DEBT_TEMPLATE = "bc_debt.html";
    private final static String FIRST_CAPITAL_TRUST_2_TEMPLATE = "first_capital_trust_2.html";
    private final static String UNIT_CERTIFICATE_ORIGINAL_CLASS = "unit_certificate_original_class.html";
    private final static String UNIT_CERTIFICATE_SUBCLASS_A = "unit_certificate_subclass_A.html";
    private final static String UNIT_CERTIFICATE_SUBCLASS_V = "unit_certificate_subclass_V.html";
    private final static String UNIT_CERTIFICATE_SUBCLASS_X = "unit_certificate_subclass_X.html";
    private final static String UNIT_CERTIFICATE_SUBCLASS_Y = "unit_certificate_subclass_Y.html";
    private final static String PDF_TEMP_PATH = "files/unitCertificate";
    private final static Integer LIMIT = 500;

    private final static List<Long> SUBCLASS_ID_LIST  = Arrays.asList(2L, 5L, 37L, 38L, 39L, 40L, 102L);

    @Value("${template.path:/root/files/unitCertificate}")
    private String templatePath;
    @Value("${dynamic-properties.pushUrl:https://fc-mp-d9db3028-a54f-4a9d-9553-b68006a8a687.next.bspapp.com/push}")
    private String pushUrl;
    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private PurchasedFundsMapper purchasedFundsMapper;

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private FundsMapper fundsMapper;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private ExportService exportService;

    @Autowired
    private StaticProperties staticProperties;

    @Autowired
    private DynamicProperties dynamicProperties;

    @Autowired
    private RedisCache redisCache;

    @Resource
    private InvestmentEntitiesMapper investmentEntitiesMapper;

    @Resource
    private AuditService auditService;

    @Resource
    private IApiClientService apiClientService;

    @Resource
    private AnnualApproveService annualApproveService;

    @Resource
    OperateLogService logService;
    private static final Pattern PATTERN = Pattern.compile("^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/\\d{4}$");
    private static final String NOTE_TEMPLATE = "%s start date: %s, end date: %s, days: %s.";
    private static final String NOTE_DEFAULT_TEMPLATE = "%s start date: %s, end date: %s, days: %s, rate: %s.";
    private static final List<Function<PurchasedFundsEntity, String>> GET_LIST = Lists.newArrayList(
        PurchasedFundsEntity::getApplicationFormSigned,
        PurchasedFundsEntity::getApplicationFormSignedTwo,
        PurchasedFundsEntity::getApplicationFormSignedThree,
        PurchasedFundsEntity::getApplicationFormSignedFour
    );
    private static final List<BiConsumer<PurchasedFundsEntity, String>> SET_LIST = Lists.newArrayList(
        PurchasedFundsEntity::setApplicationFormSigned,
        PurchasedFundsEntity::setApplicationFormSignedTwo,
        PurchasedFundsEntity::setApplicationFormSignedThree,
        PurchasedFundsEntity::setApplicationFormSignedFour
    );
    @Override
    public PageInfo<PurchasedFundsResponse> queryPurchasedFunds(PurchasedFundsQueryRequest request,
                                                                      int pageNum,
                                                                      int pageSize) {
        PageInfo<PurchasedFundsResponse> responsePageInfo = new PageInfo<>();
        // query entity page info
        PageInfo<BizPurchasedFundsDTO> entityPageInfo = PageHelper.startPage(pageNum, pageSize)
            .doSelectPageInfo(() -> purchasedFundsMapper.queryPurchasedFunds(request));
        // convert to response, ignoreProperties: list
        BeanUtils.copyProperties(entityPageInfo, responsePageInfo, "list");
        List<PurchasedFundsResponse> responseList = new ArrayList<>(entityPageInfo.getList().size());
        Date date = new Date();
        for (BizPurchasedFundsDTO dto : entityPageInfo.getList()){

            PurchasedFundsResponse response = new PurchasedFundsResponse();
            response.setId(dto.getId());
            response.setClientId(dto.getClientId());
            response.setClientName(dto.getClientName());
            response.setFundId(dto.getFundId());
            response.setFundName(dto.getFundName());
            if (ObjectUtils.isNotNull(dto.getUnitCertificateDate())) {
                response.setUnitCertificateDate(DateFormatUtil.getMMMddyyyy(dto.getUnitCertificateDate()));
            }
            if (ObjectUtils.isNotNull(dto.getPurchaseEndDate())){
                response.setPurchaseEndDate(DateFormatUtil.getMMMddyyyy(dto.getPurchaseEndDate()));
            }
            if (ObjectUtil.isNotNull(dto.getPurchaseAmount())) {
                response.setPurchasedAmount(dto.getPurchaseAmount().setScale(1, RoundingMode.HALF_UP));
            }
            try {
                response.setCurrentMonthReturn(getCurrentMonthReturn(dto));
            } catch (Exception e){
                log.error("======queryPurchasedFunds CurrentMonthReturn Calculating Wrong! purchased funds id:{}====", dto.getId());
                response.setCurrentMonthReturn(null);
            }
            try {
                response.setCurrentTotalReturn(getCurrentTotalReturn(dto));
            } catch (Exception e){
                log.error("======queryPurchasedFunds CurrentTotalReturn Calculating Wrong! purchased funds id:{}====", dto.getId());
                response.setCurrentTotalReturn(null);
            }
            response.setPurchaseStartDate(DateFormatUtil.getMMMddyyyy(getStartReturnDay(dto)));
            response.setTransactionDate(DateFormatUtil.getMMMddyyyy(dto.getTransactionDate()));
            response.setCreateAt(DateFormatUtil.getMHHmm(dto.getCreatedAt()));
            Date endDay = getEndDay(dto, EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory()));
            String status = "normal";
            if (endDay.before(date)) {
                status = "completed";
            }else if (dto.getDefaultStartDate() != null && !dto.getDefaultStartDate().after(date) ) {
                status = "default";
            } else if (dto.getExtendStartDate() != null && !dto.getExtendStartDate().after(date)) {
                status = "extend";
            }
            response.setStatus(status);
            responseList.add(response);
        }
        responsePageInfo.setList(responseList);
        return responsePageInfo;
    }

    @Override
    public CommonResponse<PurchasedFundsDetailResponse> queryPurchasedFundById(Long id) {
        BizPurchasedFundsDTO dto = queryPurchasedFundsDTO(id);
        // assemble PurchasedFundsDetail response
        PurchasedFundsDetailResponse response = buildPurchasedFundDetailResponse(dto);
        List<DividendHistoryResponse> dividendHistory = null;
        // calculate dividend history
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        Date endDay = getEndDay(dto, fundCategory);
        Calendar instance = Calendar.getInstance();
        instance.add(Calendar.DATE, 1);
        LocalDate offsetWeekend = offsetWeekendDays(DateUtil.date(instance)).toLocalDateTime().toLocalDate();
        switch (fundCategory) {
            case POOL:
                dividendHistory = dividendDates(dto, dto.getUnitCertificateDate(), endDay).stream().filter(di -> !di.getDividendDate().isAfter(offsetWeekend)).collect(Collectors.toList());
                break;
            case DIRECT:
                if (ObjectUtils.isNotNull(dto.getTransactionDate())) {
                    dividendHistory = dividendDates(dto, getStartReturnDay(dto), endDay).stream().filter(di -> !di.getDividendDate().isAfter(offsetWeekend)).collect(Collectors.toList());
                }
                break;
        }
        ClientsEntity clientsEntity = clientsMapper.selectById(dto.getClientId());
        InvestmentEntities investmentEntities = investmentEntitiesMapper.selectById(dto.getInvestmentEntityId());
        if (CollUtil.isNotEmpty(dividendHistory)) {
            dividendHistory = dividendHistory.stream().map(d -> {
                if (Boolean.TRUE.equals(investmentEntities.getWithheldTax()) && d.getDividendAmount().compareTo(dto.getPurchaseAmount()) < 0) {
                    d.setDividendAmount(d.getDividendAmount().multiply(BigDecimal.valueOf(0.9)));
                } else if (Boolean.TRUE.equals(investmentEntities.getWithheldTax()) && d.getDividendAmount().compareTo(dto.getPurchaseAmount()) > 0) {
                    BigDecimal add = d.getDividendAmount().subtract(dto.getPurchaseAmount()).multiply(BigDecimal.valueOf(0.9)).add(dto.getPurchaseAmount());
                    d.setDividendAmount(add);
                }
                return d;
            }).collect(Collectors.toList());
        }
        response.setDividendHistory(dividendHistory);
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createPurchasedFund(MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour, PurchasedFundCreateRequest request) {
        PurchasedFundsEntity entity = buildPurchasedFundEntity(applicationFormSigned, applicationFormSignedTwo,
                applicationFormSignedThree,
                applicationFormSignedFour,request);
        int insert = purchasedFundsMapper.insert(entity);
        if (insert != 1){
            PurchasedFundsErrorEnum.PURCHASED_CREATE_FAIL.throwException();
        }
        // query clientsEntity
        ClientsEntity clientsEntity = getClientsEntity(entity);
        // query fundsEntity
        FundsEntity fundsEntity = getFundsEntity(entity);
        entity.setClientName(clientsEntity.getName());
        entity.setFundName(fundsEntity.getName());
        InvestmentEntities investmentEntity = null;
        if (request.getInvestmentEntityId() != null) {
            investmentEntity = investmentEntitiesMapper.selectById(request.getInvestmentEntityId());
            entity.setInvestmentEntityName(investmentEntity.getEntityName());
        }
        Map<String, Pair<Object, Object>> stringPairMap = OperationLogUtil.operationLog(entity, null);
        // generate certificate
        String pdfTemp = generateUnitCertificate(entity, clientsEntity, fundsEntity, investmentEntity);
        // upload to oss
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fundsEntity.getBFundCategory());
        if (StrUtil.isNotBlank(pdfTemp)) {
            saveCertificateToOss(entity, pdfTemp);
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
        PurchasedFundsEntity temp = new PurchasedFundsEntity();
        temp.setFundName(entity.getFundName());
        temp.setClientName(entity.getClientName());
        temp.setInvestmentEntityName(entity.getInvestmentEntityName());
        logService.saveLog(OperateEntityTypeEnum.INVESTMENT.getMessage(), entity.getId(), OperateTypeEnum.CREATE.getMessage(), "", JSONUtil.toJsonStr(temp));
        apiClientService.pushPurchasedMsg(clientsEntity, entity.getId(), entity.getFundId());
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<PurchasedFundEditDetailResponse> queryPurchasedFundByIdWhenEdit(QueryByIdRequest request) {
        BizPurchasedFundsDTO dto = queryPurchasedFundsDTO(request.getId());
        PurchasedFundEditDetailResponse response = new PurchasedFundEditDetailResponse();
        response.setId(dto.getId());
        response.setClientId(dto.getClientId());
        response.setClient(dto.getClientName());
        response.setFundId(dto.getFundId());
        response.setFund(dto.getFundName());
        if (ObjectUtils.isNotNull(dto.getUnitCertificateDate())) {
            response.setUnitCertificateDate(DateUtil.toLocalDateTime(dto.getUnitCertificateDate()).toLocalDate());
        }
        if (ObjectUtils.isNotNull(dto.getTransactionDate())) {
            response.setTransactionDate(DateUtil.toLocalDateTime(dto.getTransactionDate()).toLocalDate());
        }
        if (ObjectUtils.isNotNull(dto.getPurchaseEndDate())) {
            response.setPurchaseEndDate(DateUtil.toLocalDateTime(dto.getPurchaseEndDate()).toLocalDate());
        }
        response.setPurchasedAmount(dto.getPurchaseAmount());
        response.setEntityName(dto.getEntityName());
        response.setUcNo(dto.getUcNo());
        response.setAddressLine(dto.getAddressLine());
        response.setSuburb(dto.getSuburb());
        response.setState(dto.getState());
        response.setPostCode(dto.getPostcode());
        if (StringUtils.hasText(dto.getApplicationFormSigned())){
            response.setApplicationFormSigned(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSigned()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedTwo())){
            response.setApplicationFormSignedTwo(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedTwo()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedThree())){
            response.setApplicationFormSignedThree(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedThree()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedFour())){
            response.setApplicationFormSignedFour(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedFour()));
        }
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editPurchasedFund(MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour, PurchasedFundEditRequest request) {
        PurchasedFundsEntity entityFromDB = queryPurchasedFundsEntity(request.getId());
        PurchasedFundsEntity entity = buildPurchasedFundEntity(applicationFormSigned, applicationFormSignedTwo, applicationFormSignedThree, applicationFormSignedFour, request);
        entity.setId(request.getId());
        entity.setUpdatedAt(new Date());
        int update = purchasedFundsMapper.update(null, Wrappers.<PurchasedFundsEntity>update().lambda()
                                                .set(entity.getClientId() != null, PurchasedFundsEntity::getClientId, entity.getClientId())
                                                .set(entity.getFundId() != null,PurchasedFundsEntity::getFundId, entity.getFundId())
                                                .set(PurchasedFundsEntity::getUnitCertificateDate, entity.getUnitCertificateDate())
                                                .set(PurchasedFundsEntity::getPurchaseAmount, entity.getPurchaseAmount())
                                                .set(PurchasedFundsEntity::getCurrentReturn, entity.getCurrentReturn())
                                                .set(PurchasedFundsEntity::getDividendAmount, entity.getDividendAmount())
                                                .set(PurchasedFundsEntity::getDividendCycle, entity.getDividendCycle())
                                                .set(PurchasedFundsEntity::getUpdatedAt, entity.getUpdatedAt())
                                                .set(PurchasedFundsEntity::getUnitCerti, entity.getUnitCerti())
                                                .set(PurchasedFundsEntity::getEntityName, entity.getEntityName())
                                                .set(PurchasedFundsEntity::getAddressLine, entity.getAddressLine())
                                                .set(PurchasedFundsEntity::getSuburb, entity.getSuburb())
                                                .set(PurchasedFundsEntity::getState, entity.getState())
                                                .set(PurchasedFundsEntity::getPostcode, entity.getPostcode())
                                                .set(PurchasedFundsEntity::getCountry, entity.getCountry())
                                                .set(entity.getInvestmentEntityId() != null, PurchasedFundsEntity::getInvestmentEntityId, entity.getInvestmentEntityId())
                                                .set(PurchasedFundsEntity::getUcNo, entity.getUcNo())
                                                .set(PurchasedFundsEntity::getPurchaseEndDate, entity.getPurchaseEndDate())
                                                .set(PurchasedFundsEntity::getTransactionDate, entity.getTransactionDate())
                                                .set( PurchasedFundsEntity::getApplicationFormSigned, entity.getApplicationFormSigned())
                                                .set( PurchasedFundsEntity::getApplicationFormSignedTwo, entity.getApplicationFormSignedTwo())
                                                .set( PurchasedFundsEntity::getApplicationFormSignedThree, entity.getApplicationFormSignedThree())
                                                .set( PurchasedFundsEntity::getApplicationFormSignedFour, entity.getApplicationFormSignedFour())
                                                .eq(PurchasedFundsEntity::getId, entity.getId()));
        if (update != 1){
            PurchasedFundsErrorEnum.PURCHASED_UPDATE_FAIL.throwException();
        }
        // query clientsEntity
        ClientsEntity clientsEntity = getClientsEntity(entity);
        // query fundsEntity
        FundsEntity fundsEntity = getFundsEntity(entity);
        // generate certificate
        InvestmentEntities investmentEntity = null;
        if (request.getInvestmentEntityId() != null) {
            investmentEntity = investmentEntitiesMapper.selectById(request.getInvestmentEntityId());
            entity.setInvestmentEntityName(investmentEntity.getEntityName());
        }

        // query clientsEntity
        getClientsEntity(entityFromDB);
        // query fundsEntity
        getFundsEntity(entityFromDB);
        // generate certificate
        InvestmentEntities oldEntity = null;
        if (request.getInvestmentEntityId() != null) {
            oldEntity = investmentEntitiesMapper.selectById(request.getInvestmentEntityId());
            entityFromDB.setInvestmentEntityName(oldEntity.getEntityName());
        }
        String pdfTemp = generateUnitCertificate(entity, clientsEntity, fundsEntity, investmentEntity);
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fundsEntity.getBFundCategory());
        // delete previous pdf in oss
        if (StringUtils.hasText(pdfTemp)){
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        // save new certificate pdf to Oss
        if (CharSequenceUtil.isNotBlank(pdfTemp)) {
            saveCertificateToOss(entity, pdfTemp);
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
        logService.saveUpdateLog(OperateEntityTypeEnum.INVESTMENT.getMessage(), entityFromDB.getId(), entity, entityFromDB, entity.getFundName());
        return CommonResponse.success(entityFromDB.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delPurchasedFund(QueryByIdRequest request) {
        if (request.getId() != null || CollUtil.isNotEmpty(request.getIdList())) {
            List<PurchasedFundsEntity> list = queryPurchasedFundsList(request);
            int update = purchasedFundsMapper.update(null, Wrappers.<PurchasedFundsEntity>update().lambda()
                    .set(PurchasedFundsEntity::getDelFlag, Boolean.TRUE)
                    .set(PurchasedFundsEntity::getUpdatedAt, new Date())
                    .eq(request.getId() != null, PurchasedFundsEntity::getId, request.getId())
                    .in(CollUtil.isNotEmpty(request.getIdList()), PurchasedFundsEntity::getId, request.getIdList())
                    .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
            if (update < 1){
                PurchasedFundsErrorEnum.PURCHASED_DELETE_FAIL.throwException();
            }
            if (CollUtil.isNotEmpty(list)) {
                // delete certificate in oss
                List<PurchasedFundsEntity> finalList = list.stream().filter(e -> CharSequenceUtil.isNotBlank(e.getUnitCerti())).collect(Collectors.toList());
                if (CollUtil.isNotEmpty(finalList)){
                    // del pre file in oss
                    CompletableFuture.runAsync(() -> finalList.forEach(this::delFileInOss), executor);
                }
            }
            logService.saveLog(OperateEntityTypeEnum.INVESTMENT.getMessage(), request.getId(), OperateTypeEnum.DELETE.getMessage(), "");
            return CommonResponse.success((long)update);
        }
        PurchasedFundsErrorEnum.PURCHASED_DELETE_FAIL.throwException();
        return null;
    }

    private List<PurchasedFundsEntity> queryPurchasedFundsList(QueryByIdRequest request) {
        return purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                .eq(request.getId() != null, PurchasedFundsEntity::getId, request.getId())
                .in(CollUtil.isNotEmpty(request.getIdList()), PurchasedFundsEntity::getId, request.getIdList())
                .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
    }

    @Override
    public void exportCsv(PurchasedFundsQueryRequest request, HttpServletResponse response) throws IOException {
        List<PurchasedFundsExportDTO> exportDTOS = queryExportData(request);


        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_PURCHASED_FUNDS+today+"1"+ ".csv";
        exportService.exportList(exportDTOS, fileName, response,PurchasedFundsExportDTO.class);
    }

    @Override
    public List<PurchasedFundsExportDTO> exportXml(PurchasedFundsQueryRequest request) {
        return queryExportData(request);
    }

    @Override
    public BigDecimal getCurrentMonthReturn(BizPurchasedFundsDTO dto) {
        BigDecimal currentMonthReturn = null;
        try {
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            Date endDay = getEndDay(dto, fundCategory);
            if (endDay == null) {
                endDay = new Date();
            }
            int days;
            Date now = new Date();
            DateTime beginOfMonth = DateUtil.beginOfMonth(now);
            int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
            Date end = now;
            Date start = null;
            switch (fundCategory){
                case POOL:
                    // not this month bought
                    // self.purchase_date < Date.today.beginning_of_month
                    if (dto.getUnitCertificateDate().before(beginOfMonth)){
                        days = (int) DateUtil.betweenDay(now, beginOfMonth, Boolean.TRUE) + 1;
                        start = beginOfMonth;
                    } else {
                        // bought this month
                        days = (int) DateUtil.betweenDay(now, dto.getUnitCertificateDate(), Boolean.TRUE) + 1;
                        start = dto.getUnitCertificateDate();
                    }
                    // Date.today > self.end_day.end_of_month ? 0 : ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
                    currentMonthReturn = now.after(DateUtil.endOfMonth(endDay)) ? BigDecimal.ZERO
                        : 
                        calculateMonthInterest(dto, start, end);
                        // (dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                        //     .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                        // .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
                        
                    break;
                case DIRECT:
                    // haven't receive deposit from client || found not started || found ended before this month -->
                    // current return 0
                    if (ObjectUtils.isNull(dto.getTransactionDate()) || getStartReturnDay(dto).after(now) || endDay.before(beginOfMonth)){
                        currentMonthReturn = BigDecimal.ZERO;
                    } else {
                        // days = DateUtil.compare(endDay, now) < 0 ?
                        //     DateUtil.dayOfMonth(endDay) :
                        //     DateUtil.isSameMonth(now, dto.getTransactionDate()) ? (int) DateUtil.betweenDay(now, getStartReturnDay(dto), Boolean.TRUE) + 1 :
                        //         DateUtil.dayOfMonth(now);
                        if(DateUtil.compare(endDay, now) < 0) {
                            Calendar calendar = Calendar.getInstance();
                            calendar.setTime(endDay);
                            calendar.set(calendar.DAY_OF_MONTH, 1);
                            start = calendar.getTime();
                            end = endDay;
                        } else if(DateUtil.isSameMonth(now, dto.getTransactionDate())) {
                            start = now;
                            end = getStartReturnDay(dto);
                        } else {
                            start = beginOfMonth;
                        }
                        currentMonthReturn = calculateMonthInterest(dto, start, end);
                        // currentMonthReturn = ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                        //     .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                        //     .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
                    }
                    break;
                default:
                    currentMonthReturn = BigDecimal.ZERO;
                    break;
            }
        } catch (Exception e) {
            log.error("getCurrentMonthReturn error", e);
            currentMonthReturn = BigDecimal.ZERO;
        }
        return currentMonthReturn;
    }

    @Override
    public BigDecimal getMonthReturnByDate(BizPurchasedFundsDTO dto, LocalDate nowLocalDate) {
        BigDecimal currentMonthReturn = BigDecimal.ZERO;
        try {
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            int days;
            String nowStr = nowLocalDate.format(DatePattern.NORM_DATE_FORMATTER);
            Date now = DateUtil.parseDate(nowStr);
            Date beginOfMonth = DateUtil.beginOfMonth(now);
            int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
            Date startReturnDay = getStartReturnDay(dto);
            Date endDay = getEndDay(dto, fundCategory);
            if (DateFormatUtil.checkTimesHasOverlap(startReturnDay, endDay, beginOfMonth, now) && fundCategory != null) {
                if (startReturnDay.after(beginOfMonth)) {
                    beginOfMonth = startReturnDay;
                }
                if (endDay.before(now)) {
                    now = endDay;
                }
                // if the local date time is before the default start day
                // calculate the interest of range between now and default start day.
                currentMonthReturn = calculateMonthInterest(dto, beginOfMonth, now);
                days = (int)DateFormatUtil.betweenDay(beginOfMonth, now, Boolean.FALSE) + 1;
                
                // currentMonthReturn = ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                //         .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                //         .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
                
                dto.setMonthStart(beginOfMonth);
                dto.setMonthEnd(now);
                dto.setDays(days);
            }
            return currentMonthReturn;
        } catch (Exception e) {
            log.info("transaction date error");
        }
        return currentMonthReturn;
    }
    
    public BigDecimal calculateMonthInterest(BizPurchasedFundsDTO dto, Date start, Date end) {
        Date defaultStartDate = dto.getDefaultStartDate();
        Calendar calendar = Calendar.getInstance();
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        Date fundEndDay = getEndDay(dto, fundCategory);
        if(end == null) {
            calendar.setTime(start);
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            end = calendar.getTime();
        }
        if(!start.before(fundEndDay) || end.after(fundEndDay)) {
            end = fundEndDay;
        }
        if(start.before(dto.getUnitCertificateDate())) {
            start = dto.getUnitCertificateDate();
        }
        BigDecimal rate = dto.getBYearlyReturnRate();
        BigDecimal interest = BigDecimal.ZERO;
        int days = start.after(end) ? 0 : (int)DateFormatUtil.betweenDay(start, end, Boolean.FALSE) + 1;
        
        // The reason of comment out the following:
        // We add the default interest to the last month
        // Don't need to distribute evenly for each month
        // because if the investor withdrew early then won't have default interest.
        // if(defaultStartDate != null) {
            // if(defaultStartDate.after(end)) {
            //     interest = calculateInterest(dto, days, rate);
            // } else if(defaultStartDate.before(start)) {
            //     rate = dto.getBDelayedGrowthRate();
            //     interest = calculateInterest(dto, days, rate);
            // } else {
            //     days = (int)DateFormatUtil.betweenDay(start, defaultStartDate, Boolean.FALSE);
            //     interest = interest.add(calculateInterest(dto, days, rate));
            //     days = (int)DateFormatUtil.betweenDay(defaultStartDate, end, Boolean.FALSE) + 1;
            //     rate = dto.getBDelayedGrowthRate();
            //     interest = interest.add(calculateInterest(dto, days, rate));
            // }
        // } else {
        //     interest = calculateInterest(dto, days, rate);
        // }
        interest = calculateInterest(dto, days, rate);
        if (defaultStartDate != null && !isExitEarly(dto) && DateUtil.isSameDay(end, fundEndDay) && !start.after(end) && end.after(defaultStartDate)) {
            // interest = interest.add(calculateInterest(dto, days, rate));
            days = dto.getUnitCertificateDate().before(defaultStartDate) ? (int)DateFormatUtil.betweenDay(defaultStartDate, end, Boolean.FALSE) + 1
                                                                         : (int)DateFormatUtil.betweenDay(dto.getUnitCertificateDate(), end, Boolean.FALSE) + 1;
            BigDecimal defaultRate = dto.getBDelayedGrowthRate();
            BigDecimal rateDiff = defaultRate.subtract(rate);
            interest = interest.add(calculateInterest(dto, days, rateDiff));
        }
        // System.out.println("ic id is " + dto.getIcId());
        // System.out.println("amount is " + dto.getPurchaseAmount());
        // System.out.println("The start day is " + start + ". End day is " + end + " total days is " + days + ". default start day is " + defaultStartDate + " the interest is " + interest);
        // System.out.println("Current rate is " + rate.toString() + ". Default rate is " + dto.getBDelayedGrowthRate() + ". Yearly rate is " + dto.getBYearlyReturnRate());
        // System.out.println("current interest is " + interest);
        return interest;
    }
    
    public boolean isExitEarly(BizPurchasedFundsDTO dto) {
        // FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        // Date fundEndDay = getEndDay(dto, fundCategory);
        Date fundEndDay = dto.getEndDate();
        Date interestEndDay = dto.getPurchaseEndDate();
        
        if (ObjectUtils.isNotNull(interestEndDay)) {
            if(ObjectUtils.isNull(fundEndDay)) {
                return true;
            } else if (interestEndDay.before(fundEndDay)) {
                return true;
            }
        }
    
        return false;
    }
    
    public BigDecimal calculateRangeInterest(Date startDate, Date endDate, BizPurchasedFundsDTO dto) {
        BigDecimal total = BigDecimal.ZERO;
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(startDate);
        // calendar.add(Calendar.MONTH, 1);
        // Date nextMonth = calendar.getTime();
        calendar.setTime(startDate);
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        Date end = calendar.getTime().after(endDate) ? endDate : calendar.getTime();
        while (!startDate.after(endDate)) {
            total = total.add(calculateMonthInterest(dto, startDate, end));
            calendar.setTime(startDate);
            calendar.add(Calendar.MONTH, 1);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            startDate = calendar.getTime();
            
            calendar.setTime(startDate);
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            end = calendar.getTime();
            if(end.after(endDate)) {
                end = endDate;
            }
        }
        return total;
    }
    
    public BigDecimal calculateInterest(BizPurchasedFundsDTO dto, int days, BigDecimal rate) {
        return ((dto.getPurchaseAmount().multiply(rate))
        .divide(BigDecimal.valueOf(getLengthOfThisYear(dto.getUnitCertificateDate())), 1000, RoundingMode.HALF_UP))
        .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
    }

    @Override
    public BigDecimal getReturnByDate(BizPurchasedFundsDTO dto, Date beginOfMonth, Date now) {
        BigDecimal currentMonthReturn = BigDecimal.ZERO;
        try {
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            int days;
            int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
            Date startReturnDay = getStartReturnDay(dto);
            Date endDay = getEndDay(dto, fundCategory);
            if (DateFormatUtil.checkTimesHasOverlap(startReturnDay, endDay, beginOfMonth, now) && fundCategory != null) {
                if (startReturnDay.after(beginOfMonth)) {
                    beginOfMonth = startReturnDay;
                }
                if (endDay.before(now)) {
                    now = endDay;
                }
                currentMonthReturn = calculateMonthInterest(dto, beginOfMonth, now);
                days = (int)DateFormatUtil.betweenDay(beginOfMonth, now, Boolean.FALSE) + 1;
                // currentMonthReturn = ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                //         .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                //         .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
                dto.setMonthStart(beginOfMonth);
                dto.setMonthEnd(now);
                dto.setDays(days);
            }
            return currentMonthReturn;
        } catch (Exception e) {
            log.info("transaction date error");
        }
        return currentMonthReturn;
    }

    public int getDayByDate(BizPurchasedFundsDTO dto, LocalDate nowLocalDate) {
        BigDecimal currentMonthReturn = BigDecimal.ZERO;
        int days = 0;
        try {
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            String nowStr = nowLocalDate.format(DatePattern.NORM_DATE_FORMATTER);
            Date now = DateUtil.parseDate(nowStr);
            Date beginOfMonth = DateUtil.beginOfMonth(now);
            int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
            Date startReturnDay = getStartReturnDay(dto);
            Date endDay = getEndDay(dto, fundCategory);
            if (DateFormatUtil.checkTimesHasOverlap(startReturnDay, endDay, beginOfMonth, now) && fundCategory != null) {
                if (startReturnDay.after(beginOfMonth)) {
                    beginOfMonth = startReturnDay;
                }
                if (endDay.before(now)) {
                    now = endDay;
                }
                days = (int)DateUtil.betweenDay(beginOfMonth, now, Boolean.TRUE) + 1;
            }
            return days;
        } catch (Exception e) {
            log.info("transaction date error");
        }
        return days;
    }
    /**
     * calculate current total return in Purchased Fund
     * @param dto
     * @return
     */
    @Override
    public BigDecimal getCurrentTotalReturn(BizPurchasedFundsDTO dto) {
        BigDecimal currentTotalReturn = BigDecimal.ZERO;
        try {
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            int days;
            Date now = new Date();
            int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
            switch (fundCategory){
                case POOL:
                    days = (int) (DateUtil.betweenDay(now, dto.getUnitCertificateDate(), Boolean.TRUE) + 1);
                    currentTotalReturn = DateUtil.compare(now, getEndDay(dto, fundCategory)) > 0 ?
                        getTargetReturn(dto, fundCategory, lengthOfYear) :
                        // ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
                        calculateRangeInterest(dto.getUnitCertificateDate(), now, dto);
                        // ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                        //     .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                        //     .multiply(BigDecimal.valueOf(days)).setScale(2, RoundingMode.HALF_UP);
                    break;
                case DIRECT:
                    if (ObjectUtils.isNotNull(dto.getTransactionDate())) {
                        days = (int) (DateUtil.betweenDay(now, getStartReturnDay(dto), Boolean.TRUE) + 1);
                        currentTotalReturn = DateUtil.compare(now, getEndDay(dto, fundCategory)) > 0 ? getTargetReturn(dto, fundCategory, lengthOfYear) :
                            // ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
                            calculateRangeInterest(getStartReturnDay(dto), now, dto);
                            // ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate())).divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP)).multiply(
                            //     BigDecimal.valueOf(days)).setScale(2, RoundingMode.HALF_UP);
                    }
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            log.info("transaction date error");
        }
        return currentTotalReturn;
    }

    @Override
    public BigDecimal getTargetReturn(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory, int lengthOfYear){
        int days;
        Date endDate = getEndDay(dto, fundCategory);
        Date startDate = dto.getUnitCertificateDate();
        switch (fundCategory){
            case POOL:
                days = (int) DateUtil.betweenDay(getEndDay(dto, fundCategory), dto.getUnitCertificateDate(), Boolean.TRUE) + 1;
                startDate = dto.getUnitCertificateDate();
                break;
            case DIRECT:
                if (ObjectUtils.isNotNull(dto.getTransactionDate())) {
                    days = (int) DateUtil.betweenDay(getEndDay(dto, fundCategory), getStartReturnDay(dto), Boolean.TRUE) + 1;
                    startDate = getStartReturnDay(dto);
                } else {
                    days = 0;
                }
                break;
            default:
                days = 0;
                break;
        }
        BigDecimal total = calculateRangeInterest(startDate, endDate, dto);
        // BigDecimal total = BigDecimal.ZERO;
        // Calendar calendar = Calendar.getInstance();
        // // calendar.setTime(startDate);
        // // calendar.add(Calendar.MONTH, 1);
        // // Date nextMonth = calendar.getTime();
        
        // calendar.setTime(startDate);
        // calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        // Date end = calendar.getTime();
        // while (startDate.before(endDate)) {
        //     total = total.add(calculateMonthInterest(dto, startDate, end));
            
        //     calendar.setTime(startDate);
        //     calendar.add(Calendar.MONTH, 1);
        //     calendar.set(Calendar.DAY_OF_MONTH, 1);
        //     startDate = calendar.getTime();
            
        //     calendar.setTime(startDate);
        //     calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        //     end = calendar.getTime();
        //     if(end.after(endDate)) {
        //         end = endDate;
        //     }
        // }
        
        //        ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
        // return (dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
        //     .divide(BigDecimal.valueOf(lengthOfYear), 30, RoundingMode.HALF_UP)
        //     .multiply(BigDecimal.valueOf(days)).setScale(2,RoundingMode.HALF_UP);
        
        return total;
    }

    @Override
    public void sendUnitCertificate(QueryByIdRequest request) throws MailjetException {
        if (request == null || (request.getId() == null && CollUtil.isEmpty(request.getIdList()))) {
            CommonErrorEnum.MAIL_FAIL_TO_SENT.throwException();
        }
        PurchasedFundsQueryRequest pfRequest = new PurchasedFundsQueryRequest();
        List<Long> idList = Lists.newArrayList();
        if(CollUtil.isNotEmpty(request.getIdList()))
            idList.addAll(request.getIdList());
        if(request.getId() != null)
            idList.add(request.getId());
        pfRequest.setIdList(idList);
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(pfRequest);
        for (BizPurchasedFundsDTO dto : list) {
            // generate Email
            BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
            mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
            mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
            List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
                    new BizMailReceiverDTO(dto.getClientEmail(), dto.getClientName()));
            if (CollUtil.isNotEmpty(dto.getEmailList())) {
                bizMailReceiverDTOS = dto.getEmailList().stream().map(s -> new BizMailReceiverDTO(s, dto.getEntityName()))
                        .collect(Collectors.toList());
            }
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setCcReceivers(
                    dynamicProperties.getSendUCEmailReceivers().getCc().stream().filter(Objects::nonNull)
                            .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                    receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
            );
            mailjetSenderDTO.setBccReceivers(
                    dynamicProperties.getSendUCEmailReceivers().getBcc().stream().filter(Objects::nonNull)
                            .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                    receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
            );
            mailjetSenderDTO.setSubject(StrBuilder.create(dto.getFundName()).append(MailJetConstants.UNIT_CERTIFICATE_SEND_EMAIL_SUBJECT_SUFFIX).toString());
            mailjetSenderDTO.setTemplateId(MailJetConstants.UNIT_CERTIFICATE_SEND_EMAIL_TEMPLATE_ID);
            JSONObject variables = new JSONObject()
                    .set("investor_name",dto.getClientName())
                    .set("entity_name", dto.getEntityName())
                    .set("amount", AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()))
                    .set("fund_name", dto.getFundName())
                    .set("date", DateFormatUtil.getDdMMMyyyy(dto.getUnitCertificateDate()));
            mailjetSenderDTO.setVariables(variables);
            JSONArray attachements = new JSONArray();
            Base64ImgReplacedElementFactory base64ImgReplacedElementFactory = new Base64ImgReplacedElementFactory();
            if (StringUtils.hasText(dto.getUnitCerti())) {
                attachements.put(new JSONObject()
                        .set("ContentType", APPLICATION_PDF)
                        .set("Filename", StrBuilder.create(dto.getFundName()).append(MailJetConstants.UNIT_CERTIFICATE_SEND_EMAIL_FILENAME_SUFFIX).toString())
                        .set("Base64Content", base64ImgReplacedElementFactory.getBase64(getPurchasedFundFileFullPath(UNIT_CERTI, dto.getId(), dto.getUnitCerti()))));
            }
            mailjetSenderDTO.setAttachements(attachements);
            MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
            mailjetUtil.sendMailWithTemplate(mailjetUtil);
        }
    }

    //    --------------------------------------------------------------------------------------------------------

    @Override
    public String getPurchasedFundFileFullPath(String fileType, Long id, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(PURCHASED_FUND, fileType, id.toString()))
            .append(fileName).toString();
        return fundFileAllPath;
    }

    @Override
    public Date getStartReturnDay(BizPurchasedFundsDTO dto){
        FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        Date startDate = null;
        try {
            switch (fundEnum){
                case POOL:
                    startDate = dto.getUnitCertificateDate();
                    break;
                case DIRECT:
                    if (ObjectUtil.isNull(dto.getTransactionDate())){
                        PurchasedFundsErrorEnum.NO_TRANSACTION_DATE.throwException();
                    }
                    if (ObjectUtil.isNull(dto.getInterestStartDate())){
                        PurchasedFundsErrorEnum.NO_INTEREST_START_DATE.throwException();
                    }
                    startDate = dto.getTransactionDate().before(dto.getInterestStartDate()) ? dto.getInterestStartDate()
                        : dto.getTransactionDate();
                    break;
            }
        } catch (Exception e) {
            log.info("getStartReturnDay:{}", e.getMessage());
        }

        return startDate;
    }

    //1. 无论是新的还是旧的，只要purchase end date有输入值，就按照purchase end date来
    //2. 没有purchase end date的，就看fund的end date
    //     2.1 今天之前的基金，如果有输入fund end date就按照fund end date来；没有输入fund end date的使用保留的duration逻辑作为fund end date
    //     2.2 今天之后的基金，不需要duration逻辑，我们会手动输入fund end date，所以今天之后的基金都按照fund end date来
    //2024-07-05
    @Override
    public Date getEndDay(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory){
        if (ObjectUtils.isNotNull(dto.getPurchaseEndDate())){
            return dto.getPurchaseEndDate();
        }
        DateTime dateTime = DateUtil.parseDate("2024-07-05");
        if (dto.getFundCreateAt().before(dateTime)) {
            Date result = null;
            if (dto.getEndDate() != null) {
                return dto.getEndDate();
            }else if (dto.getBProjectDurationMonth() != null) {
                switch (fundCategory){
                    case POOL:
                        if (DateUtil.dayOfMonth(dto.getUnitCertificateDate()) == 1){
                            result = DateUtil.offsetMonth(dto.getUnitCertificateDate(), dto.getBProjectDurationMonth());
                        } else {
                            result = DateUtil.offsetMonth(DateUtil.endOfMonth(dto.getUnitCertificateDate()!=null ?
                                    dto.getUnitCertificateDate() : new Date()), dto.getBProjectDurationMonth());
                        }
                        break;
                    case DIRECT:
                        result = DateUtil.offsetMonth(dto.getSettlementDate(), dto.getBProjectDurationMonth());
                        break;
                    default:
                        break;
                }
            }
            return result;
        }
        if (dto.getEndDate() == null) {
            return DateUtil.endOfMonth(new Date());
        }
        return dto.getEndDate();
    }

    //1. 无论是新的还是旧的，只要purchase end date有输入值，就按照purchase end date来
    //2. 没有purchase end date的，就看fund的end date
    //     2.1 今天之前的基金，如果有输入fund end date就按照fund end date来；没有输入fund end date的使用保留的duration逻辑作为fund end date
    //     2.2 今天之后的基金，不需要duration逻辑，我们会手动输入fund end date，所以今天之后的基金都按照fund end date来
    //2024-07-05
    @Override
    public Date getEndDayReal(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory){
        if (ObjectUtils.isNotNull(dto.getPurchaseEndDate())){
            return dto.getPurchaseEndDate();
        }
        DateTime dateTime = DateUtil.parseDate("2024-07-05");
        if (dto.getFundCreateAt().before(dateTime)) {
            Date result = null;
            if (dto.getEndDate() != null) {
                return dto.getEndDate();
            }else if (dto.getBProjectDurationMonth() != null) {
                switch (fundCategory){
                    case POOL:
                        if (DateUtil.dayOfMonth(dto.getUnitCertificateDate()) == 1){
                            result = DateUtil.offsetMonth(dto.getUnitCertificateDate(), dto.getBProjectDurationMonth());
                        } else {
                            result = DateUtil.offsetMonth(DateUtil.endOfMonth(dto.getUnitCertificateDate()!=null ?
                                    dto.getUnitCertificateDate() : new Date()), dto.getBProjectDurationMonth());
                        }
                        break;
                    case DIRECT:
                        result = DateUtil.offsetMonth(dto.getSettlementDate(), dto.getBProjectDurationMonth());
                        break;
                    default:
                        break;
                }
            }
            return result;
        }
        return dto.getEndDate();
    }


    /**
     * query dividend history
     * @param dto
     * @param startDividendDate
     * @return
     */
    @Override
    public List<DividendHistoryResponse> dividendDates(BizPurchasedFundsDTO dto, Date startDividendDate, Date endDay) {
        // Date defaultStartDate = dto.getDefaultStartDate();
        FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        // if (endDay != null && (defaultStartDate == null || dto.getBDelayedGrowthRate() == null)) {
        //     return dividendDatesHistory(dto, startDividendDate, endDay);
        // }
        // Date endDate = dto.getEndDate();
        Date endDate = getEndDay(dto, fundEnum);
        if (endDate == null) {
            endDate = DateUtil.endOfMonth(new Date());
        }
        // if (defaultStartDate != null && dto.getBDelayedGrowthRate() != null) {
        //     defaultStartDate = defaultStartDate.before(startDividendDate) ? startDividendDate : defaultStartDate;
        //     // Date interestEndDate = getEndDay(dto, fundEnum);
        //     // List<DividendHistoryResponse> list = dividendDatesHistory(dto, startDividendDate, DateUtil.offsetDay(defaultStartDate, -1));
        //     List<DividendHistoryResponse> list = dividendDatesHistory(dto, startDividendDate, endDate);
        //     if (defaultStartDate.before(endDate)) {
        //         // dto.setBYearlyReturnRate(dto.getBDelayedGrowthRate());
        //         List<DividendHistoryResponse> defaultList = dividendDatesHistory(dto, defaultStartDate, endDate);
        //         list.addAll(defaultList);
        //         list = new ArrayList<>(list.stream().collect(Collectors.toMap(DividendHistoryResponse::getDividendDate,
        //                 Function.identity(), (v1, v2) -> {
        //                     v1.setDividendAmount(v1.getDividendAmount().add(v2.getDividendAmount()));
        //                     return v1;
        //                 })).values());
        //     }
        //     return list;
        // }
        if (startDividendDate.before(endDate)) {
            return dividendDatesHistory(dto, startDividendDate, endDate);
        }
        return Lists.newArrayList();
    }

    private List<DividendHistoryResponse> dividendDatesHistory(BizPurchasedFundsDTO dto, Date startDividendDate, Date endDay) {
        List<DividendHistoryResponse> dividendHistory;
        if (startDividendDate == null || endDay == null || startDividendDate.after(endDay)) {
            return Lists.newArrayList();
        }
        // beginDate is the begin day of next month of unitCertificateDate
        DateTime beginDate = DateUtil.offsetMonth(DateUtil.beginOfMonth(startDividendDate), 1);
        // month gap between first dividendDateList and endDate
        List<LocalDate> dividendDateList = new ArrayList<>();
        List<LocalDate> beginDateList = new ArrayList<>();
        beginDateList.add(beginDate.toLocalDateTime().toLocalDate());
        // if dividendDate is weekend, then offset the weekend
        dividendDateList.add(offsetWeekendDays(beginDate).toLocalDateTime().toLocalDate());
        // calculate the circulating time, about add dividendDate into list
        long betweenMonthOfBeginAndEndDate = DateUtil.betweenMonth(beginDate, endDay, Boolean.FALSE);
        for (int index = 1; index <= betweenMonthOfBeginAndEndDate; index++){
            // if dividendDate is weekend, then offset the weekend
            dividendDateList.add(offsetWeekendDays(DateUtil.offsetMonth((beginDate), index)).toLocalDateTime().toLocalDate());
            beginDateList.add(DateUtil.offsetMonth((beginDate), index).toLocalDateTime().toLocalDate());
        }
        // add actual first dividend and begin into first position
        
        dividendDateList.add(0, startDividendDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        beginDateList.add(0, startDividendDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        int i = 1;
        List<DividendHistoryResponse> result = new ArrayList<>(dividendDateList.size());
        // 用于处理当月开始当月结束的购买，无dividend history
//        if (DateUtil.isSameMonth(startDividendDate, endDay)){
//            return result;
//        }
        // first_month_r = (self.purchase_amount*self.fund.b_yearly_return_rate/365*((beginning_date[1]-beginning_date[0]).to_i)).round(2)
        // Date.from(startDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date start = Date.from(beginDateList.get(0).atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date end = Date.from(beginDateList.get(1).plusDays(-1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        if(end.after(endDay)) {
            end = endDay;
        }
        BigDecimal firstMonthReturn = calculateMonthInterest(dto, start, end);
        
                // dto.getPurchaseAmount().multiply(
                //         dto.getBYearlyReturnRate()).divide(BigDecimal.valueOf(getLengthOfThisYear(dto.getUnitCertificateDate())), 1000,
                //         RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(beginDateList.get(1).toEpochDay()-beginDateList.get(0).toEpochDay())).setScale(2, RoundingMode.HALF_UP);
        result.add(new DividendHistoryResponse(dividendDateList.get(1), firstMonthReturn));
//        dividendDateList.size() = 5
//        2 3 4
        while (i+1 <= dividendDateList.size()-1) {
            start = Date.from(beginDateList.get(i).atStartOfDay(ZoneId.systemDefault()).toInstant());
            end = Date.from(beginDateList.get(i+1).plusDays(-1).atStartOfDay(ZoneId.systemDefault()).toInstant());

            BigDecimal r = calculateMonthInterest(dto, start, end);
            // dto.getPurchaseAmount().multiply(
                //         dto.getBYearlyReturnRate()).divide(BigDecimal.valueOf(getLengthOfThisYear(dto.getUnitCertificateDate())), 30,
                //         RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(beginDateList.get(i+1).toEpochDay()-beginDateList.get(i).toEpochDay())).setScale(2, RoundingMode.HALF_UP);
            result.add(new DividendHistoryResponse(dividendDateList.get(i + 1), r));
            i++;
        }
        
        // if(dividendDateList.size() > 2) {
        start = Date.from(beginDateList.get(beginDateList.size()-1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        LocalDate endDayLocalDate = offsetWeekendDays(DateUtil.offsetMonth(DateUtil.beginOfMonth(endDay), 1)).toLocalDateTime().toLocalDate();
        BigDecimal lastMonthInterest = calculateMonthInterest(dto, start, endDay);
        
        if(lastMonthInterest.compareTo(BigDecimal.ZERO) == 1) {
            DividendHistoryResponse lastDividend = new DividendHistoryResponse(endDayLocalDate, lastMonthInterest);
            result.add(lastDividend);
        }
        // }
        // if (DateUtil.dayOfMonth(endDay) == 1){
        //     DividendHistoryResponse lastDividend = result.get(result.size() - 1);
        //     lastDividend.setDividendAmount(lastDividend.getDividendAmount().add(dto.getPurchaseAmount()).setScale(2, RoundingMode.HALF_UP));
        //     result.set(result.size() -1, lastDividend);
        // } else {
            // LocalDate endDayLocalDate = offsetWeekendDays(DateUtil.offsetMonth(DateUtil.beginOfMonth(endDay), 1)).toLocalDateTime().toLocalDate();
            // start = Date.from(beginDateList.get(beginDateList.size() - 1).atStartOfDay(ZoneId.systemDefault()).toInstant());
            // BigDecimal lastDividend = calculateMonthInterest(dto, start, endDay);
            //         // dto.getPurchaseAmount().multiply(
            //         //         dto.getBYearlyReturnRate()).divide(BigDecimal.valueOf(getLengthOfThisYear(dto.getUnitCertificateDate())), 30, RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(
            //         //         endDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().toEpochDay()-beginDateList.get(beginDateList.size() - 1).toEpochDay()+1)).add(dto.getPurchaseAmount()).setScale(2, RoundingMode.HALF_UP);
            // // 用于处理只有一个月计息周期的情况
            // if (endDayLocalDate.isEqual(dividendDateList.get(1))){
            //     DividendHistoryResponse firstDividend = result.get(0);
            //     firstDividend.setDividendAmount(lastDividend.add(firstDividend.getDividendAmount()));
            //     result.set(0, firstDividend);
            // } else {
            //     result.add(new DividendHistoryResponse(endDayLocalDate, lastDividend));
            // }
        // }
        return result;
    }

    @Override
    @Async
    public CommonResponse<Boolean> sendMail(PurchasedFundsQueryRequest request) throws MailjetException {
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(request);
        Map<String, List<BizPurchasedFundsDTO>> investmentMap = list.stream().collect(Collectors.groupingBy(d -> d.getFundId() + "_" + d.getInvestmentEntityId()));
        for (String key : investmentMap.keySet()) {
            List<BizPurchasedFundsDTO> dtoList = investmentMap.get(key);

            try {
                if (ObjectUtil.equals(request.getTemplateType(), TemplateTypeEnum.MONTHLY.getCode())) {
                    sendMonthlyMail(dtoList, request);
                }else{
                    sendAnnualMail(dtoList, request);
                }
            } catch (MailjetException e) {
                log.error("===purchased funds send mail error ,request:{}, purchased funds :{}",
                        JSONUtil.toJsonStr(request), JSONUtil.toJsonStr(dtoList), e);
            }
        }
        return CommonResponse.success(Boolean.TRUE);
    }

    @Override
    public void exportMonthly(String date, String amount, List<Long> idList, HttpServletResponse response, String note) throws Exception {
        PurchasedFundsQueryRequest request = new PurchasedFundsQueryRequest();
        // request.setStartDate(date);
        LocalDate beginOfMonth = LocalDate.parse(date).withDayOfMonth(1);
        request.setStartDate(beginOfMonth.toString());
        request.setIdList(idList);
        request.setNote(note);
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(request);
        Document document = getMonthlyDoc(list, request);
        if (document != null) {
            AsposeWordsUtils.doc2pdf(document,date+MailJetConstants.MONTHLY_INTEREST_STATEMENT_SUBJECT_FILENAME_SUFFIX, response);
        }
    }

    @Override
    public void exportAnnual(LocalDate searchLast, List<Long> id, HttpServletResponse response) {
        LocalDate reqStartDay = null;
        LocalDate reqEndDay = null;
        try {
            reqStartDay = DateFormatUtil.getLocalDateByYearAndMonthAndDay(searchLast.getYear() - 1, 7, 1);
            reqEndDay = DateFormatUtil.getLocalDateByYearAndMonthAndDay(searchLast.getYear(), 6, 30);
        } catch (Exception e) {
            log.error("date parse error", e);
        }
        PurchasedFundsQueryRequest request = new PurchasedFundsQueryRequest();
        request.setIdList(id);
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(request);
        if (CollUtil.isEmpty(list)) {
            return;
        }
        BizPurchasedFundsDTO dto = list.get(0);
        ClientsEntity client = clientsMapper.selectById(dto.getClientId());
        InvestmentEntities entity = investmentEntitiesMapper.selectById(dto.getInvestmentEntityId());
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient != null) {
            LambdaQueryWrapper<AnnualApprove> eq = new LambdaQueryWrapper<AnnualApprove>()
                    .eq(dto.getClientId() != null, AnnualApprove::getClientId, dto.getClientId())
                    .eq(dto.getInvestmentEntityId() != null, AnnualApprove::getEntityId, dto.getInvestmentEntityId())
                    .eq(dto.getFundId() != null, AnnualApprove::getFundId, dto.getFundId());
            List<AnnualApprove> approveList = annualApproveService.list(eq);
            if (CollUtil.isEmpty(approveList) || reqEndDay == null || CollUtil.isEmpty(approveList.get(0).getYearList())
                    || !approveList.get(0).getYearList().contains(reqEndDay.getYear())) {
//                throw new RuntimeException("no permission");
            }
        }
        BigDecimal total = BigDecimal.ZERO;
        for (BizPurchasedFundsDTO bizPurchasedFundsDTO : list) {
            total = total.add(getTotal(bizPurchasedFundsDTO, reqStartDay, reqEndDay));
        }
        Document document = getAnnualDoc(dto.getEntityName(), client, total, reqStartDay, reqEndDay, entity, dto.getFundName());
        if (document != null) {
            AsposeWordsUtils.doc2pdf(document,searchLast.getYear()+MailJetConstants.ANNUAL_TAX_STATEMENT_SUBJECT_FILENAME_SUFFIX, response);
        }
    }

    @Override
    public CommonResponse<PageInfo<InvestmentResponse>> queryInvestmentPage(InvestmentRequest request, int pageNum, int pageSize) {
        DateTime now = new DateTime();
//        now = offsetWeekendDays(now);
        PageInfo<InvestmentResponse> page =
                PageHelper.startPage(pageNum, pageSize)
                        .doSelectPageInfo(() ->
                                purchasedFundsMapper.selectInvestmentList(request)
                        );
        List<InvestmentResponse> list = page.getList();
        if (CollUtil.isEmpty(list)) {
            return CommonResponse.success(page);
        }
        Set<Long> fundIdList = Sets.newHashSet();
        Set<Long> purchasedFundsIdList = Sets.newHashSet();
        list.forEach(i -> {
            fundIdList.add(i.getFundId());
            purchasedFundsIdList.addAll(Arrays.stream((Long[]) i.getPfId()).collect(Collectors.toList()));
        });

        Map<Long, FundsEntity> fundMap = fundsMapper.selectList(new LambdaQueryWrapper<FundsEntity>()
                .in(FundsEntity::getId, fundIdList)).stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));

        Map<Long, PurchasedFundsEntity> pfMap = purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                .in(PurchasedFundsEntity::getId, purchasedFundsIdList)).stream().collect(Collectors.toMap(PurchasedFundsEntity::getId, Function.identity()));
        LocalDate localDate = LocalDate.now();
        Calendar calendar = CalendarUtil.calendar();
        calendar.add(Calendar.MONTH, -1);
        DateTime dateTime = DateUtil.endOfMonth(calendar.getTime());
        LocalDate localDateLastMonth = dateTime.toLocalDateTime().toLocalDate();
        for (InvestmentResponse invest : list) {
            boolean isRunning = Boolean.FALSE;
            FundsEntity fund = fundMap.get(invest.getFundId());
            List<PurchasedFundsEntity> tempPfList = Arrays.stream((Long[]) invest.getPfId()).map(pfMap::get).collect(Collectors.toList());
            for (PurchasedFundsEntity pf : tempPfList) {
                BizPurchasedFundsDTO bizPf = getBizPf(pf, fund);
                FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fund.getBFundCategory());
                if (fundCategory == null) {
                    continue;
                }
                Date endDay = getEndDay(bizPf, fundCategory);
                boolean after = Boolean.TRUE;
                if (endDay != null) {
                    after = !endDay.before(now);
                }
                if (!isRunning) {
                    isRunning = after;
                }
                if (after) {
                    invest.setPurchasedAmount(invest.getPurchasedAmount().add(pf.getPurchaseAmount()));
                }
                try {
                    BigDecimal monthReturn = getMonthReturnByDate(bizPf, localDate);
                    BigDecimal prevMonthReturn = getMonthReturnByDate(bizPf, localDateLastMonth);
                    BigDecimal targetReturn = getTargetReturn(bizPf, fundCategory, getLengthOfThisYear(bizPf.getUnitCertificateDate()));

                    invest.setMonthReturn(invest.getMonthReturn().add(monthReturn));
                    invest.setPrevMonthReturn(invest.getPrevMonthReturn().add(prevMonthReturn));
                    invest.setTotalReturn(invest.getTotalReturn().add(targetReturn));
                    if (after) {
                        invest.setCurrentReturn(invest.getCurrentReturn().add(getCurrentTotalReturn(bizPf)));
                    } else {
                        invest.setCurrentReturn(invest.getCurrentReturn().add(targetReturn));
                    }
                } catch (Exception e) {
                    log.info("investment page error, pfId:{}", pf.getId());
                }
            }
            invest.setStatus(isRunning ? "On-Going":"Completed");
        }
        return CommonResponse.success(page);
    }

    @Override
    public BizPurchasedFundsDTO getBizPf(PurchasedFundsEntity pf, FundsEntity fund) {
        BizPurchasedFundsDTO dto = BeanUtil.copyProperties(pf, BizPurchasedFundsDTO.class);
        BeanUtil.copyProperties(fund, dto);
        dto.setInterestStartDate(fund.getInterestStartsDate());
        dto.setFundCreateAt(fund.getCreatedAt());
        return dto;
    }

    @Override
    public CommonResponse<InvestmentGlobalResponse> queryInvestmentGlobal() {
//        InvestmentGlobalResponse response = redisCache.getCacheObject(RedisConstants.DAILY_INVESTMENT_GLOBAL);
        InvestmentGlobalResponse response = null;
        if (response == null) {
            DateTime now = offsetWeekendDays(new DateTime());
            response = new InvestmentGlobalResponse();
            response.setInvestmentCount(purchasedFundsMapper.selectInvestCount());
            int i = 0;
            int flag = 500;
            List<FundsEntity> fundList = fundsMapper.selectList(new LambdaQueryWrapper<>());
            List<InvestmentEntities> entityList = investmentEntitiesMapper.selectList(new LambdaQueryWrapper<>());
            Map<Long, FundsEntity> fundMap = fundList.stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));
            Map<Long, InvestmentEntities> entityMap = entityList.stream().collect(Collectors.toMap(InvestmentEntities::getId, Function.identity()));
            while (flag == 500) {
                List<PurchasedFundsEntity> list = purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                        .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE).isNotNull(PurchasedFundsEntity::getPurchaseAmount)
                        .isNotNull(PurchasedFundsEntity::getUnitCertificateDate)
                        .last(" limit 500 offset " + i * 500));
                for (PurchasedFundsEntity pf : list) {
                    FundsEntity fund = fundMap.get(pf.getFundId());
                    if (fund == null) {
                        continue;
                    }
                    InvestmentEntities investmentEntities = entityMap.get(pf.getInvestmentEntityId());
                    if (investmentEntities == null) {
                        continue;
                    }
                    FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fund.getBFundCategory());
                    if (fundCategory == null) {
                        continue;
                    }
                    BizPurchasedFundsDTO bizPf = getBizPf(pf, fund);
                    Date endDay = getEndDay(bizPf, fundCategory);
                    if (!endDay.before(now)) {
                        response.setCurrentReturn(response.getCurrentReturn().add(getCurrentTotalReturn(bizPf)));
                    } else {
                        response.setPreviousInvestment(response.getPreviousInvestment().add(getTargetReturn(bizPf, fundCategory,
                                getLengthOfThisYear(bizPf.getUnitCertificateDate()))));
                    }
                    response.setTotalInvestment(response.getTotalInvestment().add(pf.getPurchaseAmount()));
                }
                flag = list.size();
                i++;
            }
            // 设置 0点过期
//            redisCache.setCacheObject(RedisConstants.DAILY_INVESTMENT_GLOBAL, response,
//                    getRemainSecondsOneDay(new Date()), TimeUnit.SECONDS);
        }
        return CommonResponse.success(response);
    }

    @Override
    public String exportUnitCertificate(QueryByIdRequest request) {
        List<Long> idList = Lists.newArrayList();
        if(request.getId() != null)
            idList.add(request.getId());
        PurchasedFundsQueryRequest pfRequest = new PurchasedFundsQueryRequest();
        pfRequest.setIdList(idList);
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(pfRequest);
        if (CollUtil.isNotEmpty(list)) {
            return getPurchasedFundFileFullPath(UNIT_CERTI, list.get(0).getId(), list.get(0).getUnitCerti());
        }
        return null;
    }

    @Override
    public List<InvestmentEntityResponse> getInvestmentCount(List<Long> entityIdList) {
        return purchasedFundsMapper.getInvestmentCount(entityIdList);
    }

    @Override
    public CommonResponse<Long> reInvestment(ReInvestmentRequest request) {
        FundsEntity funds = fundsMapper.selectById(request.getFundId());
        if (request.getClientId() != null) {
            ClientsEntity clientsEntity = clientsMapper.selectById(request.getClientId());
            request.setClientName(clientsEntity.getName());
        }
        request.setFundName(funds.getName());
        request.setEntityName(LoginUserUtil.getLoginUserName());
        Audit audit = new Audit();
        audit.setAuditType(AuditTypeEnum.INVESTMENT.getMessage());
        audit.setEntityContent(JSONUtil.toJsonStr(request));
        audit.setNewEntity(JSONUtil.toJsonStr(request));
        audit.setEntityId(LoginUserUtil.getLoginUserId());
        audit.setEntityName(LoginUserUtil.getLoginUserName());
        audit.setStatus(AuditStatusEnum.PENDING_APPROVAL.getMessage());
        audit.setCreator(LoginUserUtil.getLoginUserId());
        audit.setCreatorName(LoginUserUtil.getLoginUserName());
        auditService.save(audit);
        return CommonResponse.success(1L);
    }



    @Override
    public BigDecimal getCurrentTotalReturnByDate(BizPurchasedFundsDTO dto, LocalDate targetDate) {
        BigDecimal currentTotalReturn = null;
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        int days;
        Date now = DateUtil.parseDate(targetDate.format(DatePattern.NORM_DATE_FORMATTER));
        int lengthOfYear = getLengthOfThisYear(dto.getUnitCertificateDate());
        switch (fundCategory){
            case POOL:
                if (!dto.getUnitCertificateDate().after(now)) {
                    days = (int) (DateUtil.betweenDay(now, dto.getUnitCertificateDate(), Boolean.TRUE) + 1);
                    currentTotalReturn = DateUtil.compare(now, getEndDay(dto, fundCategory)) > 0 ?
                            getTargetReturn(dto, fundCategory, lengthOfYear) :
                            // ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
                            calculateRangeInterest(dto.getUnitCertificateDate(), now, dto);
                            // ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate()))
                            //         .divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP))
                            //         .multiply(BigDecimal.valueOf(days)).setScale(2, RoundingMode.HALF_UP);
                } else {
                    currentTotalReturn = BigDecimal.ZERO;
                }
                break;
            case DIRECT:
                if (ObjectUtils.isNotNull(dto.getTransactionDate()) && !dto.getTransactionDate().after(now)) {
                    days = (int) (DateUtil.betweenDay(now, getStartReturnDay(dto), Boolean.TRUE) + 1);
                    currentTotalReturn = DateUtil.compare(now, getEndDay(dto, fundCategory)) > 0 ? getTargetReturn(dto, fundCategory, lengthOfYear) :
                            // ((self.purchase_amount * self.fund.b_yearly_return_rate)/365 * days).round(2)
                            calculateRangeInterest(getStartReturnDay(dto), now, dto);
                            // ((dto.getPurchaseAmount().multiply(dto.getBYearlyReturnRate())).divide(BigDecimal.valueOf(lengthOfYear), 60, RoundingMode.HALF_UP)).multiply(
                            //         BigDecimal.valueOf(days)).setScale(2, RoundingMode.HALF_UP);
                } else {
                    currentTotalReturn = BigDecimal.ZERO;
                }
                break;
            default:
                currentTotalReturn = BigDecimal.ZERO;
                break;
        }
        return currentTotalReturn;
    }
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
    public CommonResponse<String> upload(ReInvestmentRequest request, MultipartFile file, HttpServletRequest httpRequest) {
        if (request.getFundId() != null && request.getEntityId() != null) {
            // 获取请求IP
            String ipAddress = getIpAddress(httpRequest);
//            if (CharSequenceUtil.isNotBlank(ipAddress)) {
//                Long count = redisCache.increment(RedisConstants.MSG_FROM_IP_LIMIT + ipAddress, 1L);
//                redisCache.expire(RedisConstants.MSG_FROM_IP_LIMIT+ipAddress, DateFormatUtil.getRemainSecondsOneDay(new Date()),  TimeUnit.SECONDS);
//                if (count > 50) {
//                    log.info("ip:{},limit", ipAddress);
//                    return CommonResponse.success();
//                }
//            }
            String str = saveReInvestmentFileInOss(file,
                    request.getFundId() + "_" + request.getEntityId(),
                    storageProcessor.generateUploadFileName(file.getOriginalFilename()));
            if (CharSequenceUtil.isNotBlank(str)) {
                return CommonResponse.success(new StringBuffer(CommonConstants.HTTPS_PREFIX)
                        .append(ossClientConfig.getBucketName())
                        .append(FileUtil.POINT_STR)
                        .append(ossClientConfig.getEndpoint())
                        .append(FileUtil.SLASH).append(str).toString());
            }
        }
        return CommonResponse.error("missing id");
    }

    @Override
    public void pushInvestmentMsg() {
        Calendar calendar = CalendarUtil.calendar();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        DateTime dateTime = offsetWeekendDays(DateTime.of(calendar.getTime()));
        Calendar calendar2 = CalendarUtil.calendar();
        calendar2.set(Calendar.DAY_OF_MONTH, 1);
        calendar2.add(Calendar.MONTH, -1);
        Date lastMonth = calendar2.getTime();
        if (DateUtil.isSameDay(dateTime, new Date())) {
            int size = 500;
            int i = 0;
            Map<Long, Integer> map = Maps.newHashMap();
            List<FundsEntity> fundsEntities = fundsMapper.selectList(new LambdaQueryWrapper<>());
            Map<Long, FundsEntity> fundMap = fundsEntities.stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));
            while (size == 500) {
                List<PurchasedFundsEntity> list = purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                        .orderByAsc(PurchasedFundsEntity::getClientId)
                        .last(" limit 500 offset " + i * 500));
                size = list.size();
                i++;
                for (PurchasedFundsEntity pf : list) {
                    FundsEntity fund = fundMap.get(pf.getFundId());
                    if (fund != null) {
                        BizPurchasedFundsDTO bizPf = getBizPf(pf, fund);
                        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, bizPf.getBFundCategory());
                        try {
                            Date endDay = getEndDay(bizPf, fundCategory);
                            if (!endDay.before(lastMonth)) {
                                Integer count = map.getOrDefault(pf.getClientId(), 0);
                                count++;
                                map.put(pf.getClientId(), count);
                            }
                        } catch (Exception e) {
                            log.info("transaction date error");
                        }
                    }
                }
            }
            if (CollUtil.isNotEmpty(map)) {
                List<ClientsEntity> clientsEntities = clientsMapper.selectList(new LambdaQueryWrapper<ClientsEntity>().in(ClientsEntity::getId, map.keySet()));
                Map<Long, ClientsEntity> clientMap = clientsEntities.stream().collect(Collectors.toMap(ClientsEntity::getId, Function.identity()));
                for (Long clientId : map.keySet()) {
                    ClientsEntity clientsEntity = clientMap.get(clientId);
                    if (clientsEntity != null && CharSequenceUtil.isNotBlank(clientsEntity.getPushClientId())) {
                        Map<String, Object> param = Maps.newHashMap();
                        try {
                            param.put("pushType", 1);
                            param.put("title", ObjectUtil.equals(LanguageEnum.CN.getCode(), clientsEntity.getLanguage()) ?
                                    String.format("您收到%s新的投资回报", map.get(clientId)) :
                                    String.format("Please review your %s new investment income statement", map.get(clientId)));
                            param.put("pushClientId", clientsEntity.getPushClientId());
                            HttpUtil.post(pushUrl, param);
                        } catch (Exception e) {
                            log.info("push investment error, param:{}, clientName:{}, {}", JSONUtil.toJsonStr(param), clientsEntity.getName(), e.getMessage());
                        }
                    }
                }
            }
        }
    }

    @Override
    public void initPoolUnitCertificate(List<Long> pfId) {
        List<FundsEntity> fundsEntities = fundsMapper.selectList(new LambdaQueryWrapper<FundsEntity>()
                .eq(FundsEntity::getDelFlag, Boolean.FALSE));
        List<PurchasedFundsEntity> purchasedFundsEntities = purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                .in(PurchasedFundsEntity::getFundId, fundsEntities.stream().map(FundsEntity::getId).collect(Collectors.toList()))
                .in(CollUtil.isNotEmpty(pfId), PurchasedFundsEntity::getId, pfId)
                .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
        List<InvestmentEntities> investmentEntities = investmentEntitiesMapper.selectList(new LambdaQueryWrapper<InvestmentEntities>()
                .in(InvestmentEntities::getId, purchasedFundsEntities.stream().map(PurchasedFundsEntity::getInvestmentEntityId).collect(Collectors.toList())));
        Map<Long, FundsEntity> fundMap = fundsEntities.stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));
        Map<Long, InvestmentEntities> entityMap = investmentEntities.stream().collect(Collectors.toMap(InvestmentEntities::getId, Function.identity()));
        for (PurchasedFundsEntity entity : purchasedFundsEntities) {
            try {
                FundsEntity fundsEntity = fundMap.get(entity.getFundId());
                Date startReturnDay = getStartReturnDay(getBizPf(entity, fundsEntity));
                if (startReturnDay.before(DateUtil.parseDate("2024-06-10"))) {
                    continue;
                }
                String unitCerti = entity.getUnitCerti();
                if (CharSequenceUtil.isNotBlank(unitCerti)) {
                    CompletableFuture.runAsync(() -> delFileInOss(entity), executor);
                }
                InvestmentEntities investmentEntity = entityMap.get(entity.getInvestmentEntityId());
                if (!SUBCLASS_ID_LIST.contains(entity.getFundId())) {
                    entity.setUnitCerti(StrBuilder.create("BCDIOF-Unit_Certificate-")
                            .append("(").append(fundsEntity!= null ? fundsEntity.getName().substring(fundsEntity.getName().lastIndexOf(" ")+1):"").append(")-")
                            .append(investmentEntity!= null ? investmentEntity.getIcId():"")
                            .append("[").append(investmentEntity!= null ? investmentEntity.getEntityName():"").append("]")
                            .append(DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN)).append(".pdf").toString().replace(" ","_"));
                }else {
                    //BCFC- Unit Certificate (Trust No.） V2408 - 146XXX [Entity Name] YYMMDD.docx
                    entity.setUnitCerti(StrBuilder.create("BCDIOF-Unit_Certificate-")
                            .append(investmentEntity!= null ? investmentEntity.getIcId():"")
                            .append("[").append(investmentEntity!= null ? investmentEntity.getEntityName():"").append("]")
                            .append(DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN)).append(".pdf").toString().replace(" ","_"));
                }
                generateUnitCertificate(entity, null, fundsEntity, investmentEntity);
                purchasedFundsMapper.update(null, new LambdaUpdateWrapper<PurchasedFundsEntity>()
                        .set(PurchasedFundsEntity::getUnitCerti, entity.getUnitCerti())
                        .eq(PurchasedFundsEntity::getId, entity.getId()));
            } catch (Exception e) {
                log.error("init pool unit error :{}", entity.getId(), e);
            }
        }

    }
    @Override
    public void exportInvestmentPdf(Long fundId, Long entityId, String note, HttpServletResponse response) {
        PurchasedFundsQueryRequest request = new PurchasedFundsQueryRequest();
        request.setFundId(fundId);
        request.setEntityId(entityId);
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(request);
        Date date = new Date();
        DateTime endTime = offsetWeekendDays(DateUtil.beginOfMonth(date));
        LocalDate endLocalDate = endTime.toLocalDateTime().toLocalDate();
        DateTime endOfMonth = DateUtil.endOfMonth(date);
        boolean isAdmin = LoginUserUtil.getLoginAdmin() != null;
        if (isAdmin && DateUtil.isSameDay(endOfMonth, date)) {
            LocalDate nextDay = LocalDate.now().plusDays(1);
            if(nextDay.getDayOfWeek().equals(DayOfWeek.SATURDAY)) {
                nextDay = nextDay.plusDays(2);
            } else if (nextDay.getDayOfWeek().equals(DayOfWeek.SUNDAY)) {
                nextDay = nextDay.plusDays(1);
            }
            endLocalDate = nextDay;
        }
        Map<String, InvestmentRecord> resultMap = Maps.newHashMap();
        ClientsEntity client = clientsMapper.selectById(list.get(0).getClientId());
        InvestmentEntities investmentEntities = investmentEntitiesMapper.selectById(list.get(0).getInvestmentEntityId());
        LocalDate finalEndLocalDate = endLocalDate;
        FundsEntity fundsEntity = fundsMapper.selectById(fundId);
        Map<String, Map<String, Object>> ucMap = Maps.newHashMap();
        list.sort(Comparator.comparing(this::getStartReturnDay));
        String startDate = "";
        String endDate = "";
        boolean taxFlag = Boolean.TRUE.equals(investmentEntities.getWithheldTax());
        BigDecimal totalReturn = BigDecimal.ZERO;
        String fundName = "";
        Date totalEndDate = null;
        for (int i = 0; i < list.size(); i++) {
            BizPurchasedFundsDTO dto = list.get(i);
            fundName = dto.getFundName();
            FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            Date startReturnDay = getStartReturnDay(dto);
            // Date startReturnDay = normaliseStartDay(list, getStartReturnDay(dto), dto, i+1);
            Date endDay = getEndDay(dto, fundEnum);
            List<BizPurchasedFundsDTO> effectiveList = list.stream().filter(d -> {
                Date tempStart = getStartReturnDay(d);
                Date tempEnd = getEndDay(d, fundEnum);
                return !tempStart.after(startReturnDay) && !tempEnd.before(startReturnDay);
            }).collect(Collectors.toList());
            Map<String, Object> tempMap = Maps.newHashMap();
            ucMap.put(DateUtil.formatDate(startReturnDay), tempMap);
            tempMap.put("investmentAmount", dto.getPurchaseAmount());
            tempMap.put("unitChange", dto.getPurchaseAmount());
            tempMap.put("investmentClosingBalance", effectiveList.stream().map(d -> d.getPurchaseAmount().doubleValue()).mapToDouble(x -> x).sum());
            LocalDate localDate = startReturnDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            BigDecimal before = BigDecimal.ZERO;
            for (int j = 0; j <= i; j++) {
                before = before.add(getCurrentTotalReturnByDate(list.get(j), localDate));
            }
            totalReturn = totalReturn.add(getTargetReturn(dto, fundEnum, getLengthOfThisYear(new Date())));
            tempMap.put("before", before);
            tempMap.put("tax", taxFlag ? before.multiply(BigDecimal.valueOf(0.1)) : BigDecimal.ZERO);
            tempMap.put("after", taxFlag ? before.multiply(BigDecimal.valueOf(0.9)) : before);
            List<DividendHistoryResponse> histotyList = dividendDates(dto, startReturnDay, endDay).stream()
                    .filter(d -> isAdmin || !d.getDividendDate().isAfter(finalEndLocalDate)).collect(Collectors.toList());
            for (DividendHistoryResponse historyResponse : histotyList) {
                String format = historyResponse.getDividendDate().format(DatePattern.NORM_DATE_FORMATTER);
                InvestmentRecord record = resultMap.get(format);
                if (record == null) {
                    record = new InvestmentRecord();
                    resultMap.put(format, record);
                    record.setPaymentDate(historyResponse.getDividendDate());
                    LocalDate month = historyResponse.getDividendDate().with(TemporalAdjusters.firstDayOfMonth()).minusDays(1);
                    record.setMonth(month);
                }
                addInvestmentRecord(record, historyResponse, dto, client, investmentEntities);
            }
            if (i == 0) {
                startDate = DateUtil.format(startReturnDay, "dd/MM/yyyy");
            }
            if (i == list.size() - 1) {
                endDate = DateUtil.format(endDay, "dd/MM/yyyy");
                totalEndDate = endDay;
            }
        }
        List<String> dateSet = Lists.newArrayList(ucMap.keySet());
        dateSet.addAll(resultMap.keySet());
        List<String> dateList = dateSet.stream().distinct().sorted(Comparator.comparing(Function.identity())).collect(Collectors.toList());
        List<String[]> tableList = Lists.newArrayList();
        
        for (String dateStr : dateList) {
            InvestmentRecord record = resultMap.get(dateStr);
            if (record != null) {
                DateTime parse = DateUtil.parse(dateStr);
                String formatDate = DateUtil.format(DateUtil.endOfMonth(DateUtil.offsetMonth(parse, -1)), DatePattern.NORM_DATE_FORMATTER);
                tableList.add(new String[]{formatDate, "Closing Balance", "", "", "", "",
                        AmountFormatUtil.formatThousandsSeparator(record.getClosingBalance()),
                        "$" + AmountFormatUtil.formatThousandsSeparator(record.getClosingBalance()),
                        "$" + AmountFormatUtil.formatThousandsSeparator(record.getBeforeDivide()),
                        record.getTax() != null ? "$" + AmountFormatUtil.formatThousandsSeparator(record.getTax()) : "$0",
                        "$" + AmountFormatUtil.formatThousandsSeparator(taxFlag ? record.getCurrentReturn().subtract(record.getTax()) : record.getCurrentReturn())
                });
            }
            Map<String, Object> uc = ucMap.get(dateStr);
            if (uc != null) {
                BigDecimal investmentAmount = MapUtil.get(uc, "investmentAmount", BigDecimal.class);
                BigDecimal unitChange = MapUtil.get(uc, "unitChange", BigDecimal.class);
                BigDecimal investmentClosingBalance = MapUtil.get(uc, "investmentClosingBalance", BigDecimal.class);
                tableList.add(new String[]{dateStr, "Opening Balance",
                        investmentAmount != null ? "$" + AmountFormatUtil.formatThousandsSeparator(investmentAmount) : "", "", "$1.00",
                        unitChange != null ? AmountFormatUtil.formatThousandsSeparator(unitChange) : "0",
                        unitChange != null ? AmountFormatUtil.formatThousandsSeparator(unitChange) : "0",
                        investmentClosingBalance != null ? "$"+ AmountFormatUtil.formatThousandsSeparator(investmentClosingBalance) : "0"
                        // "$" + AmountFormatUtil.formatThousandsSeparator(MapUtil.get(uc, "before", BigDecimal.class)),
                        // Optional.ofNullable(MapUtil.get(uc, "tax", BigDecimal.class)).map(s->"$" + AmountFormatUtil.formatThousandsSeparator(s)).orElse("$0"),
                        // "$" + AmountFormatUtil.formatThousandsSeparator(MapUtil.get(uc, "after", BigDecimal.class))
                });
            }
        }//☑ //□
        tableList.get(tableList.size() - 1)[0] = DateUtil.formatDate(totalEndDate);
        List<String> keySet = resultMap.keySet().stream().sorted().collect(Collectors.toList());
        InvestmentRecord investmentRecord = resultMap.get(keySet.get(keySet.size() - 1));
        tableList.add(new String[]{"Total", "", "", "", "", "",
                AmountFormatUtil.formatThousandsSeparator(investmentRecord.getClosingBalance()),
                "$" + AmountFormatUtil.formatThousandsSeparator(investmentRecord.getClosingBalance()),
                "$" + AmountFormatUtil.formatThousandsSeparator(totalReturn),
                "$" + AmountFormatUtil.formatThousandsSeparator(taxFlag ? totalReturn.multiply(BigDecimal.valueOf(0.1)) : BigDecimal.ZERO),
                "$" + AmountFormatUtil.formatThousandsSeparator(taxFlag ? totalReturn.subtract(totalReturn.multiply(BigDecimal.valueOf(0.1))) : totalReturn)
        });

        try {
            Document document = new Document(templatePath+"/investment_summary_template.docx");
            TableCollection tables = document.getFirstSection().getBody().getTables();
            for (Table table : tables) {
                Row firstRow = table.getFirstRow();
                String text = null;
                try {
                    text = firstRow.getFirstCell().getFirstParagraph().getRuns().get(0).getText();
                } catch (Exception e) {
                    log.info("查询表头报错");
                }
                log.info("第一个表头内容：{}", text);
                if (CharSequenceUtil.equals("Date", text)) {
                    Row lastRow = table.getLastRow();
                    table.removeChild(lastRow);
                    for (String[] strings : tableList) {
                        Row row = (Row)lastRow.deepClone(true);
                        for (int i = 0; i < strings.length; i++) {
                            row.getCells().get(i).getFirstParagraph().getRuns().get(0).setText(strings[i]);
                        }
                        table.getRows().add(row);
                    }
                    break;
                }
            }
            String status = "normal";
            if (fundsEntity.getDefaultStartDate() != null && !fundsEntity.getDefaultStartDate().after(date) ) {
                status = "default";
            } else if (fundsEntity.getExtendStartDate() != null && !fundsEntity.getExtendStartDate().after(date)) {
                status = "extend";
            }
            Range range = document.getRange();
            range.replace("${reportDate}", DateUtil.format(new Date(), "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${startDate}", startDate, new FindReplaceOptions());
            range.replace("${endDate}", endDate, new FindReplaceOptions());
            range.replace("${clientName}", investmentEntities.getEntityName(), new FindReplaceOptions());
            range.replace("${clientNum}", investmentEntities.getIcId(), new FindReplaceOptions());
            range.replace("${term}", fundsEntity.getBProjectDurationMonth() != null ? fundsEntity.getBProjectDurationMonth().toString() : "", new FindReplaceOptions());
            range.replace("${status}", status, new FindReplaceOptions());
            range.replace("${rate}", fundsEntity.getBYearlyReturnRate() != null ?
                    (fundsEntity.getBYearlyReturnRate().multiply(BigDecimal.valueOf(100))).setScale(2) + "%" : "", new FindReplaceOptions());
            range.replace("${delayRate}", fundsEntity.getBDelayedGrowthRate() != null ?
                    (fundsEntity.getBDelayedGrowthRate().multiply(BigDecimal.valueOf(100))) + "%" : "", new FindReplaceOptions());
            range.replace("${note}", note != null ? note : "", new FindReplaceOptions());
            range.replace("${fundsName}", fundName, new FindReplaceOptions());
            DocumentBuilder builder = new DocumentBuilder(document);
//            //插入图片的方法
//            NodeCollection runs = document.getChildNodes(NodeType.PARAGRAPH, true);
//            for (int i = 0; i < runs.getCount(); i++) {
//                Node r = runs.get(i);
//                String text = r.getText();
//                //获取键
//                for (String key : maps.keySet()) {
//                    //如果包含键
//                    if (text.contains(key) && maps.get(key).contains("F:")) {
//                        // 锁定到当前段落即实现页面变换
//                        builder.moveTo(r);
//                        // insertImage中参数含义自行查询
//                        builder.insertImage(maps.get(key), RelativeHorizontalPosition.PAGE, 0,
//                                RelativeVerticalPosition.PAGE, 0, 500, 280, WrapType.INLINE);
//                    }
//                }
//            }
            if (document != null) {
                AsposeWordsUtils.doc2pdf(document, DateUtil.format(new Date(), "dd/MM/yyyy") + MailJetConstants.INVESTMENT_SUMMARY_FILENAME_SUFFIX, response);
            }
        } catch (Exception e) {
            log.error("investment ptf error ", e);
        }
    }

    @Override
    public CommonResponse<Long> sendApplicationForm(MultipartFile iSign,
                                                    MultipartFile iSignTwo,
                                                    MultipartFile iSignThree,
                                                    MultipartFile cSign,
                                                    MultipartFile cSignTwo,
                                                    MultipartFile tSign,
                                                    MultipartFile tSignTwo,
                                                    MultipartFile tSignThree,
                                                    MultipartFile tSignFour,
                                                    MultipartFile aSign,
                                                    MultipartFile aSignTwo,
                                                    ApplicationFormRequest request) {
        try {
            Document document = new Document(templatePath+"/bcfc_application_form_template.docx");
            Map<String, Object> requestMap = BeanUtil.beanToMap(request, false, false);
            Range range = document.getRange();
            for (String key : requestMap.keySet()) {
                Object obj = requestMap.get(key);
                if (obj != null) {
                    if (obj instanceof String) {
                        range.replace(String.format("${%s}", key), obj.toString(), new FindReplaceOptions());
                    } else if (obj instanceof Boolean){
                        //☑ //□
                        range.replace(String.format("${%s}", key), (Boolean) obj ? "☑" : "□", new FindReplaceOptions());
                    }
                } else {
                    range.replace(String.format("${%s}", key), "", new FindReplaceOptions());
                }
            }

            DocumentBuilder builder = new DocumentBuilder(document);
            //插入图片的方法
            NodeCollection runs = document.getChildNodes(NodeType.PARAGRAPH, true);
            Map<String, MultipartFile> map = Maps.newHashMap();
            map.put("${iSign}",iSign);
            map.put("${iSignTwo}",iSignTwo);
            map.put("${iSignThree}",iSignThree);
            map.put("${cSign}",cSign);
            map.put("${cSignTwo}",cSignTwo);
            map.put("${tSign}",tSign);
            map.put("${tSignTwo}",tSignTwo);
            map.put("${tSignThree}",tSignThree);
            map.put("${tSignFour}",tSignFour);
            map.put("${aSign}",aSign);
            map.put("${aSignTwo}",aSignTwo);
            Set<String> signName = map.keySet();
            for (int i = 0; i < runs.getCount(); i++) {
                Node r = runs.get(i);
                String text = r.getText().replace("\r", "");
                if (signName.contains(text)) {
                    if (map.containsKey(text) && map.get(text) != null) {
                        // 锁定到当前段落即实现页面变换
                        builder.moveTo(r);
                        // insertImage中参数含义自行查询
                        builder.insertImage(map.get(text).getInputStream(), RelativeHorizontalPosition.PAGE, 0,
                                RelativeVerticalPosition.PAGE, 0, 150, 50, WrapType.INLINE);
                        range.replace(text, "", new FindReplaceOptions());
                        range.replace(text.replace("Sign", "Date"), DateUtil.now(), new FindReplaceOptions());
                    } else {
                        range.replace(text, "", new FindReplaceOptions());
                        range.replace(text.replace("Sign", "Date"), "", new FindReplaceOptions());
                    }
                }
            }
            ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
            try {
                document.save(arrayOutputStream, SaveFormat.PDF);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
//            List<BizMailReceiverDTO> bizMailReceiverDTOS = Lists.newArrayList(new BizMailReceiverDTO("operations@icglobal.com.au", "operations"));
            List<BizMailReceiverDTO> bizMailReceiverDTOS = Lists.newArrayList(new BizMailReceiverDTO("471262959@qq.com", "测试邮件")
                    ,new BizMailReceiverDTO("operations@icglobal.com.au", "operations")
            );
            if (request.getEntityId() != null) {
                InvestmentEntities investmentEntities = investmentEntitiesMapper.selectById(request.getEntityId());
                if (investmentEntities != null && CollUtil.isNotEmpty(investmentEntities.getEmailList())) {
                    investmentEntities.getEmailList().stream().filter(CharSequenceUtil::isNotBlank)
                            .forEach(e->bizMailReceiverDTOS.add(new BizMailReceiverDTO(e, investmentEntities.getEntityName())));
                }
//        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
//                new BizMailReceiverDTO("471262959@qq.com", "测试邮件"));
            }
            mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
            mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setSubject(MailJetConstants.APPLICATION_SUBJECT);
            mailjetSenderDTO.setTemplateId(MailJetConstants.MONTHLY_INTEREST_STATEMENT_EMAIL_TEMPLATE_ID);
            JSONObject variables = new JSONObject()
                    ;
            mailjetSenderDTO.setVariables(variables);
            if (arrayOutputStream.size() > 0) {
                JSONArray attachements = new JSONArray();
                attachements.put(new JSONObject()
                        .set("ContentType", APPLICATION_PDF)
                        .set("Filename", MailJetConstants.APPLICATION_FILENAME_SUFFIX)
                        .set("Base64Content", Base64.getEncoder().encodeToString(arrayOutputStream.toByteArray())));
                mailjetSenderDTO.setAttachements(attachements);
            }
            MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
            mailjetUtil.sendMailWithTemplate(mailjetUtil);
        } catch (Exception e) {
            log.error("investment ptf error ", e);
        }
        return CommonResponse.success();
    }

    private String getFundLastName(String name) {
        if (CharSequenceUtil.isNotBlank(name)) {
            if (name.contains("Original")) {
                return "Original Class";
            } else {
                return name.substring(name.length() - 1);
            }

        }
        return "Subclass";
    }

    private String getReInvestmentFileFullPath(String id, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
                .append(ossClientConfig.getBucketName())
                .append(FileUtil.POINT_STR)
                .append(ossClientConfig.getEndpoint())
                .append(FileUtil.SLASH)
                .append(storageProcessor.getFilePathWithoutFileName(RE_INVESTMENT, FILE, id))
                .append(fileName).toString();
        return fundFileAllPath;
    }
    private String saveReInvestmentFileInOss(MultipartFile file, String id, String name) {
        try {
            return storageProcessor.store(file.getInputStream(), RE_INVESTMENT, FILE,
                    id, name);
        } catch (IOException e) {
            e.printStackTrace();
            PurchasedFundsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {RE_INVESTMENT});
        }
        return null;
    }

    public Date normaliseStartDay(List<BizPurchasedFundsDTO> list, Date startReturnDay, BizPurchasedFundsDTO currentDto, int index) {
        Date beginOfMonth = DateUtil.beginOfMonth(startReturnDay);
        Date endOfMonth = DateUtil.endOfMonth(startReturnDay);
        Date startDate = startReturnDay;
        int i = 0;
        for (BizPurchasedFundsDTO dto : list) {
            if(i < index) {
                i++;
                continue;
            }
            FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            if(!getEndDay(dto, fundEnum).before(beginOfMonth) && !getEndDay(dto, fundEnum).after(endOfMonth)) {
                startDate = beginOfMonth;
                break;
            }
        }
        return startDate;
    }

    @Override
    public CommonResponse<List<InvestmentRecord>> investmentRecord(PurchasedFundsQueryRequest request) {
        List<BizPurchasedFundsDTO> list = purchasedFundsMapper.queryPurchasedFunds(request);
        Date date = new Date();
        DateTime endTime = offsetWeekendDays(DateUtil.beginOfMonth(date));
        LocalDate endLocalDate = endTime.toLocalDateTime().toLocalDate();
        DateTime endOfMonth = DateUtil.endOfMonth(date);
        boolean isAdmin = LoginUserUtil.getLoginAdmin() != null;
        if (isAdmin && DateUtil.isSameDay(endOfMonth, date)) {
            LocalDate nextDay = LocalDate.now().plusDays(1);
            if(nextDay.getDayOfWeek().equals(DayOfWeek.SATURDAY)) {
                nextDay = nextDay.plusDays(2);
            } else if (nextDay.getDayOfWeek().equals(DayOfWeek.SUNDAY)) {
                nextDay = nextDay.plusDays(1);
            }
            endLocalDate = nextDay;
        }
        Map<String, InvestmentRecord> resultMap = Maps.newHashMap();
        ClientsEntity client = clientsMapper.selectById(list.get(0).getClientId());
        InvestmentEntities investmentEntities = investmentEntitiesMapper.selectById(list.get(0).getInvestmentEntityId());
        LocalDate finalEndLocalDate = endLocalDate;
        // check if is there any overlay between the end date of one of dto and UC date of another dto
        int i = 0;
        for (BizPurchasedFundsDTO dto : list) {
            i++;
            // check here getStartReturnDay(dto),
            // Date realStartDay = normaliseStartDay(list, getStartReturnDay(dto), dto, i);
            FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            List<DividendHistoryResponse> histotyList = dividendDates(dto, getStartReturnDay(dto), getEndDay(dto, fundEnum)).stream()
                    .filter(d -> isAdmin || !d.getDividendDate().isAfter(finalEndLocalDate)).collect(Collectors.toList());
            for (DividendHistoryResponse historyResponse : histotyList) {
                String format = historyResponse.getDividendDate().format(DatePattern.NORM_DATE_FORMATTER);
                InvestmentRecord record = resultMap.get(format);
                if (record == null) {
                    record = new InvestmentRecord();
                    resultMap.put(format, record);
                    record.setPaymentDate(historyResponse.getDividendDate());
                    LocalDate month = historyResponse.getDividendDate().with(TemporalAdjusters.firstDayOfMonth()).minusDays(1);
                    record.setMonth(month);
                }
                addInvestmentRecord(record, historyResponse, dto, client, investmentEntities);
            }
        }
        return CommonResponse.success(resultMap.values().stream()
                .sorted(Comparator.comparing(InvestmentRecord::getPaymentDate)).collect(Collectors.toList()));
    }

    private void addInvestmentRecord(InvestmentRecord record, DividendHistoryResponse d, BizPurchasedFundsDTO dto, ClientsEntity client, InvestmentEntities investmentEntities) {
        record.addInvestmentAmount(dto.getPurchaseAmount());
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        Date endDay = getEndDay(dto, fundCategory);
        LocalDate endLocalDate = endDay.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
        
        if (!endLocalDate.isBefore(record.getMonth())) {
            record.addClosingBalance(dto.getPurchaseAmount());
        }
        
        if (Boolean.TRUE.equals(investmentEntities.getWithheldTax())) {
            d.setDividendAmount(d.getDividendAmount().multiply(BigDecimal.valueOf(0.9)));
            record.addTax(d.getDividendAmount().multiply(BigDecimal.valueOf(0.1)));
        } 
        
        // if (Boolean.TRUE.equals(investmentEntities.getWithheldTax()) && d.getDividendAmount().compareTo(dto.getPurchaseAmount()) < 0) {
        //     d.setDividendAmount(d.getDividendAmount().multiply(BigDecimal.valueOf(0.9)));
        //     record.addTax(d.getDividendAmount().multiply(BigDecimal.valueOf(0.1)));
        // } 
        // else if (Boolean.TRUE.equals(investmentEntities.getWithheldTax()) && d.getDividendAmount().compareTo(dto.getPurchaseAmount()) > 0) {
        //     BigDecimal add = d.getDividendAmount().subtract(dto.getPurchaseAmount()).multiply(BigDecimal.valueOf(0.9)).add(dto.getPurchaseAmount());
        //     d.setDividendAmount(add);
        //     record.addTax(d.getDividendAmount().subtract(dto.getPurchaseAmount()).multiply(BigDecimal.valueOf(0.1)));
        // }
        BigDecimal dividendAmount = d.getDividendAmount();
        // if (dividendAmount.compareTo(dto.getPurchaseAmount()) > 0) {
        //     dividendAmount = dividendAmount.subtract(dto.getPurchaseAmount());
        //     record.addBeforeDivide(d.getDividendAmount().subtract(dto.getPurchaseAmount()));
        // } else {
        //     record.addBeforeDivide(d.getDividendAmount());
        // }
        
        record.addBeforeDivide(d.getDividendAmount());
        record.addCurrentReturn(dividendAmount);
        record.addId(dto.getId());
    }

    private Document getMonthlyDoc(String date, String amount, Long id) {
        BizPurchasedFundsDTO purchasedFunds = queryPurchasedFundsDTO(id);
        FundsEntity funds = fundsMapper.selectById(purchasedFunds.getFundId());
        ClientsEntity client = clientsMapper.selectById(purchasedFunds.getClientId());
        InvestmentEntities entity = investmentEntitiesMapper.selectById(purchasedFunds.getInvestmentEntityId());
        DateTime dateTime = DateUtil.parse(date);
        BigDecimal amountNum;
        if (CharSequenceUtil.isBlank(amount)) {
            amountNum = getMonthReturnByDate(purchasedFunds, dateTime.toLocalDateTime().toLocalDate());
        } else {
            amountNum = new BigDecimal(amount);
        }
//        Calendar calendar = dateTime.toCalendar();
//        calendar.add(Calendar.MONTH, -1);
//        Date time = calendar.getTime();
        DateTime startDate = DateUtil.beginOfMonth(dateTime);
        DateTime endDate = DateUtil.endOfMonth(dateTime);
        Calendar calendar = startDate.toCalendar();
        calendar.add(Calendar.MONTH, 1);
        DateTime issueDate = offsetWeekendDays(DateTime.of(calendar));
        BigDecimal tax = BigDecimal.ZERO;
        if (ObjectUtil.equals(entity.getWithheldTax(), Boolean.TRUE)){
            amountNum = amountNum.divide(BigDecimal.valueOf(0.9), 2, RoundingMode.HALF_UP);
            tax = amountNum.divide(BigDecimal.TEN, 2, RoundingMode.HALF_UP);
        }
        BigDecimal total = amountNum.subtract(tax);
        try {
            Document document = new Document(templatePath+"/monthly_interest_statement_template_old1.docx");
            Range range = document.getRange();
            if (funds != null) {
                range.replace("${fundsName}", funds.getName(), new FindReplaceOptions());
                range.replace("${investmentCycle}", funds.getInvestmentCycle() != null ?
                        funds.getInvestmentCycle() : "0", new FindReplaceOptions());
                range.replace("${targetReturn}", funds.getBYearlyReturnRate() != null ?
                        funds.getBYearlyReturnRate().multiply(BigDecimal.valueOf(100L)).setScale(2, RoundingMode.HALF_UP)+"%": "0%", new FindReplaceOptions());
            }else{
                range.replace("${fundsName}", "", new FindReplaceOptions());
                range.replace("${investmentCycle}", "", new FindReplaceOptions());
                range.replace("${targetReturn}", "", new FindReplaceOptions());
            }
            range.replace("${clientName}", purchasedFunds.getInvestmentEntityName() , new FindReplaceOptions());
            range.replace("${clientNum}", entity != null && entity.getIcId() != null ?
                    entity.getIcId() : client.getBeaverId(), new FindReplaceOptions());
            range.replace("${issueDate}", DateUtil.format(issueDate, "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${startDate}", DateUtil.format(startDate, "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${endDate}", DateUtil.format(endDate, "dd/MM/yyyy"), new FindReplaceOptions());

            range.replace("${unitCertificateDate}", DateUtil.format(purchasedFunds.getUnitCertificateDate(), "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${purchaseAmount}", purchasedFunds.getPurchaseAmount() != null ?
                    "$"+String.format("%.0f",purchasedFunds.getPurchaseAmount()): "0%", new FindReplaceOptions());
            range.replace("${dividendAmount}", "$"+AmountFormatUtil.formatThousandsSeparator(amountNum), new FindReplaceOptions());
            range.replace("${tax}", "$"+AmountFormatUtil.formatThousandsSeparator(tax), new FindReplaceOptions());
            range.replace("${total}", "$"+AmountFormatUtil.formatThousandsSeparator(total), new FindReplaceOptions());

            range.replace("${bsb}", client.getBsb(), new FindReplaceOptions());
            range.replace("${clientAccount}", entity.getAccountNumber(), new FindReplaceOptions());
            return document;
        } catch (Exception e) {
            log.error("getMonthlyDoc error", e);
        }
        return null;
    }

    private void sendAnnualMail(List<BizPurchasedFundsDTO> dtoList, PurchasedFundsQueryRequest request) throws MailjetException {

        DateTimeFormatter sdf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate reqStartDay = null;
        LocalDate reqEndDay = LocalDate.now();
        BizPurchasedFundsDTO purchasedFundsDTO = dtoList.get(0);
        try {
            LocalDate startDate = LocalDate.parse(request.getStartDate(), sdf);
            reqStartDay = DateFormatUtil.getLocalDateByYearAndMonthAndDay(startDate.getYear() - 1, 7, 1);
            reqEndDay = DateFormatUtil.getLocalDateByYearAndMonthAndDay(startDate.getYear(), 6, 30);
        } catch (Exception e) {
            log.error("date parse error", e);
        }
        BigDecimal total = BigDecimal.ZERO;
        ClientsEntity client = clientsMapper.selectById(purchasedFundsDTO.getClientId());
        InvestmentEntities entity = investmentEntitiesMapper.selectById(purchasedFundsDTO.getInvestmentEntityId());
        for (BizPurchasedFundsDTO dto : dtoList) {
            total = total.add(getTotal(dto, reqStartDay, reqEndDay));
        }

//        if (Boolean.TRUE.equals(client.getWithheldTax())) {
//            total = (total.multiply(BigDecimal.valueOf(0.9)));
//        }
        LocalDate date = LocalDate.parse(request.getStartDate(), sdf);
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
        mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
                new BizMailReceiverDTO(purchasedFundsDTO.getClientEmail(), purchasedFundsDTO.getClientName()));
        if (CollUtil.isNotEmpty(entity.getEmailList())) {
            bizMailReceiverDTOS = entity.getEmailList().stream()
                    .map(e -> new BizMailReceiverDTO(e, purchasedFundsDTO.getEntityName())).collect(Collectors.toList());
        }
//        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
//                new BizMailReceiverDTO("471262959@qq.com", "测试邮箱"));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject(StrBuilder.create(purchasedFundsDTO.getFundName()).append(MailJetConstants.ANNUAL_TAX_STATEMENT_SUBJECT).toString());
        mailjetSenderDTO.setTemplateId(MailJetConstants.ANNUAL_TAX_STATEMENT_EMAIL_TEMPLATE_ID);
        JSONObject variables = new JSONObject()
                .set("clientName",purchasedFundsDTO.getClientName())
                .set("entity_name", purchasedFundsDTO.getEntityName())
                .set("fundname", purchasedFundsDTO.getFundName())
                .set("subclass", purchasedFundsDTO.getFundName())
                .set("year", date.getYear())
                .set("month", date.getMonth().toString())
                ;
        mailjetSenderDTO.setVariables(variables);
        Document document = getAnnualDoc(purchasedFundsDTO.getEntityName(), client, total, reqStartDay, reqEndDay, entity, purchasedFundsDTO.getFundName());
        ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
        try {
            document.save(arrayOutputStream, SaveFormat.PDF);
            if (arrayOutputStream.size() > 0) {
                JSONArray attachements = new JSONArray();
                attachements.put(new JSONObject()
                        .set("ContentType", APPLICATION_PDF)
                        .set("Filename", reqEndDay.getYear()+MailJetConstants.ANNUAL_TAX_STATEMENT_SUBJECT_FILENAME_SUFFIX)
                        .set("Base64Content", Base64.getEncoder().encodeToString(arrayOutputStream.toByteArray())));
                mailjetSenderDTO.setAttachements(attachements);
            }
        } catch (Exception e) {
            log.error("getAnnualDoc error", e);
        }
        mailjetSenderDTO.setCcReceivers(
                dynamicProperties.getSendPFAnnualEmailReceivers().getCc().stream().filter(Objects::nonNull)
                        .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
        );
        if (dynamicProperties.getSendPFAnnualEmailReceivers() != null && dynamicProperties.getSendPFAnnualEmailReceivers().getBcc() != null) {
            mailjetSenderDTO.setBccReceivers(
                    dynamicProperties.getSendPFAnnualEmailReceivers().getBcc().stream().filter(Objects::nonNull)
                            .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                    receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
            );
        }
        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        Boolean success = mailjetUtil.sendMailWithTemplate(mailjetUtil);
        if (!success){
            CommonErrorEnum.MAIL_FAIL_TO_SENT.throwException();
        }
    }

    private BigDecimal getTotal(BizPurchasedFundsDTO dto, LocalDate reqStartDay, LocalDate reqEndDay) {
        BigDecimal total = BigDecimal.ZERO;
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
        LocalDate startDay = getStartReturnDay(dto).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate endDay = getEndDay(dto, fundCategory).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        
        
        
        if (startDay.isBefore(reqStartDay)) {
            startDay = reqStartDay;
        }
        if (endDay.isAfter(reqEndDay)) {
            endDay = reqEndDay;
        }
        if (!startDay.isAfter(endDay)) {
            
            // Calendar calendar = Calendar.getInstance();
            // calendar.setTime(startDate);
            // calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            // Date end = calendar.getTime();
            Date startDate = Date.from(startDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date endDate = Date.from(endDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
            // calendar.setTime(startDate);
            // calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            // Date end = calendar.getTime();
            total = calculateRangeInterest(startDate, endDate, dto);
            // while (startDate.before(endDate)) {
            //     total = total.add(calculateMonthInterest(dto, startDate, end));
            //     calendar.setTime(startDate);
            //     calendar.add(Calendar.MONTH, 1);
            //     calendar.set(Calendar.DAY_OF_MONTH, 1);
            //     startDate = calendar.getTime();
                
            //     calendar.setTime(startDate);
            //     calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            //     end = calendar.getTime();
            //     if(end.after(endDate)) {
            //         end = endDate;
            //     }
            // }
        
            // total = total.add(dto.getPurchaseAmount().multiply(
            //                 dto.getBYearlyReturnRate()).divide(BigDecimal.valueOf(getLengthOfThisYear(dto.getUnitCertificateDate())), 1000,
            //                 RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(endDay.toEpochDay() - startDay.toEpochDay() + 1))
            //         .setScale(2, RoundingMode.HALF_UP));
        }
        return total;
    }

    private Document getAnnualDoc(String entityName, ClientsEntity client, BigDecimal total, LocalDate reqStartDay, LocalDate reqEndDay, InvestmentEntities entity, String fundName) {

        try {
            Document document = new Document(templatePath +"/annual_tax_statement_template.docx");
            String entityType = "";
            if (entity != null && entity.getEntityType() != null) {
                entityType = EnumUtil.getEnumMessageByCode(InvestEntityTypeEnum.class, entity.getEntityType());
            }
            Range range = document.getRange();
            range.replace("${endDate}", LocalDate.now().format(DatePattern.NORM_DATE_FORMATTER), new FindReplaceOptions());
            range.replace("${dateRange}", reqStartDay.format(DatePattern.NORM_DATE_FORMATTER)+" - "+reqEndDay.format(DatePattern.NORM_DATE_FORMATTER), new FindReplaceOptions());
            range.replace("${accountName}", entityName, new FindReplaceOptions());
            range.replace("${clientId}", entity != null && entity.getIcId() != null ? entity.getIcId() : "", new FindReplaceOptions());
            range.replace("${investorType}", entityType, new FindReplaceOptions());
            range.replace("${tfNum}", entity != null && entity.getTfNum() != null ? entity.getTfNum():"", new FindReplaceOptions());
            range.replace("${total}", total.compareTo(BigDecimal.ZERO)>0?("$" + AmountFormatUtil.formatThousandsSeparator(total)):"$0", new FindReplaceOptions());
            range.replace("${tax}", entity != null && entity.getWithheldTax() != null
                    && total.compareTo(BigDecimal.ZERO) > 0 && ObjectUtil.equals(Boolean.TRUE, entity.getWithheldTax())
                    ? ("$" + AmountFormatUtil.formatThousandsSeparator(total.divide(BigDecimal.TEN, 30, RoundingMode.HALF_UP))) : "$0", new FindReplaceOptions());
            range.replace("${fundName}", fundName, new FindReplaceOptions());
            return document;
        } catch (Exception e) {
            log.error("getAnnualDoc error", e);
        }
        return null;
    }


    private void sendMonthlyMail(List<BizPurchasedFundsDTO> dtoList, PurchasedFundsQueryRequest request) throws MailjetException {
        DateTime dateTime = DateUtil.parseDate(request.getStartDate());
        Calendar calendar = dateTime.toCalendar();
        calendar.add(Calendar.MONTH, 1);
        DateTime reqStartDay = DateUtil.beginOfMonth(calendar.getTime());
        LocalDate startDate = DateUtil.endOfMonth(reqStartDay).toLocalDateTime().toLocalDate();
        BizPurchasedFundsDTO bizPurchasedFundsDTO = dtoList.get(0);
        DateTimeFormatter sdf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        ClientsEntity client = clientsMapper.selectById(bizPurchasedFundsDTO.getClientId());
        ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
        Document document = getMonthlyDoc(dtoList, request);
        try {
            document.save(arrayOutputStream, SaveFormat.PDF);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        String format = startDate.plusDays(1).format(DatePattern.NORM_DATE_FORMATTER);
        Month month = offsetWeekendDays(DateUtil.parseDate(format)).toLocalDateTime().toLocalDate().getMonth();
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
        mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
        List<BizMailReceiverDTO> bizMailReceiverDTOS;
        if (CollUtil.isNotEmpty(bizPurchasedFundsDTO.getEmailList())) {
            bizMailReceiverDTOS = bizPurchasedFundsDTO.getEmailList().stream()
                    .map(e -> new BizMailReceiverDTO(e, bizPurchasedFundsDTO.getEntityName())).collect(Collectors.toList());
        } else {
            bizMailReceiverDTOS = Lists.newArrayList(new BizMailReceiverDTO(client.getEmail(), bizPurchasedFundsDTO.getEntityName()));
        }
//        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
//                new BizMailReceiverDTO("471262959@qq.com", "测试邮件"));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject(StrBuilder.create(bizPurchasedFundsDTO.getFundName()).append(MailJetConstants.MONTHLY_INTEREST_STATEMENT_SUBJECT).toString());
        mailjetSenderDTO.setTemplateId(MailJetConstants.MONTHLY_INTEREST_STATEMENT_EMAIL_TEMPLATE_ID);
        JSONObject variables = new JSONObject()
                .set("clientName",bizPurchasedFundsDTO.getClientName())
                .set("entityName", bizPurchasedFundsDTO.getEntityName())
                .set("fund_name", bizPurchasedFundsDTO.getFundName())
                .set("timePeriod", startDate.getDayOfMonth())
                .set("year", startDate.getYear())
                .set("month", startDate.getMonth())
                .set("businessMonth", month != null ? month.toString():"")
                ;
        mailjetSenderDTO.setVariables(variables);
        if (arrayOutputStream.size() > 0) {
            JSONArray attachements = new JSONArray();
            attachements.put(new JSONObject()
                    .set("ContentType", APPLICATION_PDF)
                    .set("Filename", startDate.format(sdf)+MailJetConstants.MONTHLY_INTEREST_STATEMENT_SUBJECT_FILENAME_SUFFIX)
                    .set("Base64Content", Base64.getEncoder().encodeToString(arrayOutputStream.toByteArray())));
            mailjetSenderDTO.setAttachements(attachements);
        }
        mailjetSenderDTO.setCcReceivers(
                dynamicProperties.getSendPFMonthlyEmailReceivers().getCc().stream().filter(Objects::nonNull)
                        .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
        );
        if (dynamicProperties.getSendPFMonthlyEmailReceivers() != null && dynamicProperties.getSendPFMonthlyEmailReceivers().getBcc() != null) {
            mailjetSenderDTO.setBccReceivers(
                    dynamicProperties.getSendPFMonthlyEmailReceivers().getBcc().stream().filter(Objects::nonNull)
                            .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                    receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
            );
        }
        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        mailjetUtil.sendMailWithTemplate(mailjetUtil);
    }

    private Document getMonthlyDoc(List<BizPurchasedFundsDTO> dtoList, PurchasedFundsQueryRequest request) {
        DateTime dateTime = DateUtil.parseDate(request.getStartDate());//8
        Calendar calendar = dateTime.toCalendar();
//        calendar.add(Calendar.MONTH, 1);
        DateTime reqStartDay = DateUtil.beginOfMonth(calendar.getTime());//0801
        DateTime endOfMonth = DateUtil.endOfMonth(calendar.getTime());//0831
        DateTime reqEndDay = DateUtil.offsetMonth(reqStartDay, 1);//0901
        LocalDate startDate = DateUtil.endOfMonth(reqStartDay).toLocalDateTime().toLocalDate();//0801
        LocalDate endDate = DateUtil.endOfMonth(reqEndDay).toLocalDateTime().toLocalDate();//0901
        BigDecimal total = BigDecimal.ZERO;
        BigDecimal totalDividend = BigDecimal.ZERO;
        BigDecimal totalTax = BigDecimal.ZERO;
        List<String[]> tableList = Lists.newArrayList();
        BizPurchasedFundsDTO bizPurchasedFundsDTO = dtoList.get(0);
        ClientsEntity client = clientsMapper.selectById(bizPurchasedFundsDTO.getClientId());
        FundsEntity funds = fundsMapper.selectById(bizPurchasedFundsDTO.getFundId());
        InvestmentEntities entity = investmentEntitiesMapper.selectById(bizPurchasedFundsDTO.getInvestmentEntityId());
        if (CollUtil.isEmpty(bizPurchasedFundsDTO.getEmailList())) {
            bizPurchasedFundsDTO.setEmailList(Lists.newArrayList(client.getEmail()));
        }
        int starCount = 1;
        List<String> noteList = Lists.newArrayList();
        int j = 0;
        for (BizPurchasedFundsDTO dto : dtoList) {
            j++;
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            Date endDay = getEndDay(dto, fundCategory);
            Date endDayRel = getEndDayReal(dto, fundCategory);
            Date startDay = getStartReturnDay(dto);
            // Date startDay = normaliseStartDay(dtoList, getStartReturnDay(dto), dto, j);
            // we only add the closing balance in the monthly summary
            if(endDay.before(reqStartDay)) {
                continue;
            }
            // 开始月的月末 到 结束月加周末+1 中间的
            // Date realStartDay = normaliseStartDay(dtoList, startDay, dto, j);
            // FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            List<DividendHistoryResponse> dividendHistory = dividendDates(dto, startDay, endDay).stream()
                    .filter(di->di.getDividendDate().isAfter(startDate) && di.getDividendDate().isBefore(endDate))
                    .collect(Collectors.toList());
            BigDecimal dividend = BigDecimal.ZERO;
            if (CollUtil.isNotEmpty(dividendHistory)) {
                DividendHistoryResponse d = dividendHistory.get(0);
                dividend = d.getDividendAmount();
                if (dividend.compareTo(dto.getPurchaseAmount()) > 0) {
                    dividend = dividend.subtract(dto.getPurchaseAmount());
                }
            }
            BigDecimal tax = BigDecimal.ZERO;
            if (ObjectUtil.equals(entity.getWithheldTax(), Boolean.TRUE)){
                tax = dividend.divide(BigDecimal.TEN, 1000, RoundingMode.HALF_UP);
            }
            BigDecimal tempTotal = dividend.subtract(tax);
            total = total.add(tempTotal);
            totalDividend = totalDividend.add(dividend);
            totalTax = totalTax.add(tax);
            StringBuilder star = new StringBuilder();
            if (dto.getDefaultStartDate() != null && !isExitEarly(dto) && endDayRel != null && !endDayRel.before(dto.getDefaultStartDate()) && DateUtil.isSameMonth(dateTime, endDayRel)) {
                long days = DateFormatUtil.betweenDay(reqStartDay, endDay, Boolean.TRUE) + 1;
                long default_days = DateFormatUtil.betweenDay(dto.getDefaultStartDate(), endDay, Boolean.TRUE) + 1;
                for (int i = 1; i <= starCount; i++) {
                    star.append("*");
                }
                BigDecimal rateDiff = dto.getBDelayedGrowthRate().subtract(dto.getBYearlyReturnRate());
                starCount++;
                // noteList.add(String.format(NOTE_DEFAULT_TEMPLATE, star, DateUtil.formatDate(dto.getUnitCertificateDate()),
                //         DateUtil.formatDate(endDay), days, rateDiff));
                noteList.add(String.format(NOTE_TEMPLATE, star, DateUtil.formatDate(reqStartDay), DateUtil.formatDate(endDay), days));
                noteList.add(String.format(NOTE_DEFAULT_TEMPLATE, star, DateUtil.formatDate(dto.getDefaultStartDate()), DateUtil.formatDate(endDay), default_days, rateDiff));
            } else if (DateUtil.isSameMonth(dateTime, startDay) || (endDayRel != null && DateUtil.isSameMonth(dateTime, endDayRel))
                    /*|| (dto.getDefaultStartDate() != null && DateUtil.isSameMonth(dateTime, dto.getDefaultStartDate()))*/) {
                if(reqStartDay.isAfter(startDay)){
                    startDay = reqStartDay;
                }
                if (endOfMonth.isBefore(endDay)) {
                    endDay = endOfMonth;
                }
                long days = DateFormatUtil.betweenDay(startDay, endDay, Boolean.TRUE) + 1;
                for (int i = 1; i <= starCount; i++) {
                    star.append("*");
                }
                starCount++;
                noteList.add(String.format(NOTE_TEMPLATE, star, DateUtil.formatDate(startDay),
                        DateUtil.formatDate(endDay), days));
            } else if (!endDay.before(reqStartDay)) {
                long days = DateFormatUtil.betweenDay(reqStartDay, endOfMonth, Boolean.TRUE) + 1;
                for (int i = 1; i <= starCount; i++) {
                    star.append("*");
                }
                starCount++;
                noteList.add(String.format(NOTE_TEMPLATE, star, DateUtil.formatDate(reqStartDay),
                        DateUtil.formatDate(endOfMonth), days));
            }
            
            tableList.add(new String[]{
                    dto.getPurchaseAmount() != null ? star +"$" + AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()) : star +"$0",
                    // endDay.before(endOfMonth) ? "$0" : "$" + AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()),
                    dto.getPurchaseAmount() != null ? "$" + AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()) : "$0",
                    
                    dto.getPurchaseAmount() != null ? AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()) : "0",
                    // endDay.before(endOfMonth) ? "0" : AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()),
                    dto.getPurchaseAmount() != null ? AmountFormatUtil.formatThousandsSeparator(dto.getPurchaseAmount()) : "0",
                    "$" + AmountFormatUtil.formatThousandsSeparator(dividend),
                    "$" + AmountFormatUtil.formatThousandsSeparator(tax),
                    "$" + AmountFormatUtil.formatThousandsSeparator(tempTotal)});
        }
        tableList.add(new String[]{"Total", "", "", "",
                "$" + AmountFormatUtil.formatThousandsSeparator(totalDividend),
                "$" + AmountFormatUtil.formatThousandsSeparator(totalTax),
                "$" + AmountFormatUtil.formatThousandsSeparator(total)});
        if (request.getNote() != null) {
            noteList.add(0, request.getNote());
        }
        String note = String.join("\r", noteList);
        Document document = getListMonthlyDoc(reqStartDay, tableList, funds, client, entity, note);
        return document;
    }

    private Document getListMonthlyDoc(DateTime dateTime, List<String[]> tableList, FundsEntity funds, ClientsEntity client, InvestmentEntities entity, String note) {
        DateTime startDate = DateUtil.beginOfMonth(dateTime);//0801
        DateTime endDate = DateUtil.endOfMonth(dateTime);//0831
        Calendar calendar = startDate.toCalendar();
        calendar.add(Calendar.MONTH, 1);
        DateTime issueDate = offsetWeekendDays(DateTime.of(calendar));//0901
        try {
            Document document = new Document(templatePath+"/monthly_interest_statement_template.docx");
            Range range = document.getRange();
            if (funds != null) {
                range.replace("${fundsName}", funds.getName(), new FindReplaceOptions());
                range.replace("${investmentCycle}", funds.getInvestmentCycle() != null ?
                        funds.getInvestmentCycle() : "0", new FindReplaceOptions());
                range.replace("${targetReturn}", funds.getBYearlyReturnRate() != null ?
                        funds.getBYearlyReturnRate().multiply(BigDecimal.valueOf(100L)).setScale(2, RoundingMode.HALF_UP)+"%": "0%", new FindReplaceOptions());
            }else{
                range.replace("${fundsName}", "", new FindReplaceOptions());
                range.replace("${investmentCycle}", "", new FindReplaceOptions());
                range.replace("${targetReturn}", "", new FindReplaceOptions());
            }
            range.replace("${clientName}", entity.getEntityName() != null ?
                    entity.getEntityName():"", new FindReplaceOptions());
            range.replace("${clientNum}", entity.getIcId() != null ? entity.getIcId() : client.getBeaverId(),
                    new FindReplaceOptions());
            range.replace("${issueDate}", DateUtil.format(issueDate, "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${startDate}", DateUtil.format(startDate, "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${endDate}", DateUtil.format(endDate, "dd/MM/yyyy"), new FindReplaceOptions());
            range.replace("${unitCertificateDate}", tableList.get(0)[0], new FindReplaceOptions());
            String bsb = "";
            if (CharSequenceUtil.isNotBlank(entity.getBsb())) {
                if(entity.getBsb().length() > 3){
                    bsb = "*****" + entity.getBsb().substring(entity.getBsb().length() - 3);
                } else {
                    bsb = entity.getBsb();
                }
            }
            String account = "";
            if (CharSequenceUtil.isNotBlank(entity.getAccountNumber())) {
                if(entity.getAccountNumber().length() > 3){
                    account = "*****" + entity.getAccountNumber().substring(entity.getAccountNumber().length() - 3);
                } else {
                    account = entity.getAccountNumber();
                }
            }
            range.replace("${bsb}", bsb , new FindReplaceOptions());
            range.replace("${clientAccount}", account, new FindReplaceOptions());
            range.replace("${note}", note != null ? note : "", new FindReplaceOptions());
            String status = "normal";
            if (funds.getDefaultStartDate() != null && !funds.getDefaultStartDate().after(dateTime) ) {
                status = "default";
            } else if (funds.getExtendStartDate() != null && !funds.getExtendStartDate().after(dateTime)) {
                status = "extend";
            }
            range.replace("${status}", status, new FindReplaceOptions());
            TableCollection tables = document.getFirstSection().getBody().getTables();
            for (Table table : tables) {
                Row firstRow = table.getFirstRow();
                String text = null;
                try {
                    text = firstRow.getFirstCell().getFirstParagraph().getRuns().get(0).getText();
                } catch (Exception e) {
                    log.info("查询表头报错");
                }
                log.info("第一个表头内容：{}", text);
                if (CharSequenceUtil.equals("MONTHLY DISTRIBUTION", text)) {
                    Row lastRow = table.getLastRow();
                    table.removeChild(lastRow);
                    for (String[] strings : tableList) {
                        Row row = (Row)lastRow.deepClone(true);
                        for (int i = 0; i < strings.length; i++) {
                            row.getCells().get(i).getFirstParagraph().getRuns().get(0).setText(strings[i]);
                        }
                        table.getRows().add(row);
                    }
                    break;
                }
            }

            return document;
        } catch (Exception e) {
            log.error("getMonthlyDoc error", e);
        }
        return null;
    }

    private void saveFileInOss(MultipartFile file, PurchasedFundsEntity entity) {
        try {
            storageProcessor.store(file.getInputStream(), PURCHASED_FUND, UNIT_CERTI,
                                   entity.getId().toString(), entity.getUnitCerti());
        } catch (IOException e) {
            e.printStackTrace();
            PurchasedFundsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {UNIT_CERTI});
        }
    }

    private void saveApplicationFormInOss(MultipartFile file, PurchasedFundsEntity entity, String fileName) {
        try {
            storageProcessor.store(file.getInputStream(), PURCHASED_FUND, APPLICATION_FORM,
                                   entity.getId().toString(), fileName);
        } catch (IOException e) {
            e.printStackTrace();
            PurchasedFundsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {APPLICATION_FORM});
        }
    }

    private void delFileInOss(PurchasedFundsEntity entityFromDB) {
        if (StringUtils.hasText(entityFromDB.getUnitCerti())){
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(PURCHASED_FUND, UNIT_CERTI,
                                                                entityFromDB.getId().toString())).append(
                    entityFromDB.getUnitCerti()).toString());
            } catch (IOException delE) {
                log.error("====={}/{}/{}delete Oss failed=====", PURCHASED_FUND, UNIT_CERTI, entityFromDB.getId());
            }
        }
    }


    public static void main(String[] args) {
        long l = DateUtil.betweenDay(DateUtil.parseDate("2024-08-01"), DateUtil.parseDate("2024-08-11"), true);
        long l2 = DateFormatUtil.betweenDay(DateUtil.parseDate("2023-10-01"), DateUtil.parseDate("2023-10-31"), true);
        System.out.println(l);
        System.out.println(l2);
    }

    private PurchasedFundsEntity buildPurchasedFundEntity(MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour, PurchasedFundCreateRequest request) {
        PurchasedFundsEntity entity = BeanUtil.copyProperties(request, PurchasedFundsEntity.class);
        for (int i = 0; i < GET_LIST.size(); i++) {
            String str = GET_LIST.get(i).apply(entity);
            if (CharSequenceUtil.isNotBlank(str)) {
                SET_LIST.get(i).accept(entity, str.substring(str.lastIndexOf("/") + 1));
            }
        }
        entity.setClientId(request.getClientId());
        entity.setFundId(request.getFundId());
        String format = "yyyy-MM-dd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date now = new Date();
        if (StringUtils.hasText(request.getUnitCertificateDate())){
            try {
                Date date = sdf.parse(request.getUnitCertificateDate());
                entity.setUnitCertificateDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Unit Certificate Date"});
            }
        }
        if (StringUtils.hasText(request.getTransactionDate())){
            try {
                Date date = sdf.parse(request.getTransactionDate());
                entity.setTransactionDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Transaction Date"});
            }
            if (entity.getTransactionDate().after(now)){
                log.error("===TransactionDate:{} is after now:{}===", entity.getTransactionDate(), now);
                PurchasedFundsErrorEnum.WRONG_TRANSACTION_TIME.throwException();
            }
        }
        if (StringUtils.hasText(request.getPurchaseEndDate())){
            try {
                Date date = sdf.parse(request.getPurchaseEndDate());
                entity.setPurchaseEndDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Purchase end date"});
            }
        }
        entity.setPurchaseAmount(request.getPurchasedAmount());
        entity.setEntityName(request.getEntityName());
        entity.setUcNo(request.getUcNo());
        InvestmentEntities investmentEntity = null;
        if (request.getInvestmentEntityId() != null) {
            investmentEntity = investmentEntitiesMapper.selectById(request.getInvestmentEntityId());
            if (investmentEntity != null) {
                entity.setAddressLine(investmentEntity.getAddressLine());
                entity.setSuburb(investmentEntity.getSuburb());
                entity.setState(investmentEntity.getState());
                entity.setPostcode(investmentEntity.getPostcode());
            }
        }
        FundsEntity fundsEntity = fundsMapper.selectById(request.getFundId());
        entity.setUnitCerti(StrBuilder.create(UUID.fastUUID().toString()).append(".pdf").toString());
        if (!SUBCLASS_ID_LIST.contains(entity.getFundId())) {
            entity.setUnitCerti(StrBuilder.create("BCDIOF-Unit_Certificate-")
                    .append("(").append(fundsEntity!= null ? fundsEntity.getName().substring(fundsEntity.getName().lastIndexOf(" ")+1):"").append(")-")
                    .append(investmentEntity!= null ? investmentEntity.getIcId():"")
                    .append("[").append(investmentEntity!= null ? investmentEntity.getEntityName():"").append("]")
                    .append(DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN)).append(".pdf").toString().replace(" ","_"));
        }else {
            //BCFC- Unit Certificate (Trust No.） V2408 - 146XXX [Entity Name] YYMMDD.docx
            entity.setUnitCerti(StrBuilder.create("BCDIOF-Unit_Certificate-")
                    .append(investmentEntity!= null ? investmentEntity.getIcId():"")
                    .append("[").append(investmentEntity!= null ? investmentEntity.getEntityName():"").append("]")
                    .append(DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN)).append(".pdf").toString().replace(" ","_"));
        }
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        entity.setInvestmentEntityId(request.getInvestmentEntityId());
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
        return entity;
    }

    private PurchasedFundsDetailResponse buildPurchasedFundDetailResponse(BizPurchasedFundsDTO dto) {
        PurchasedFundsDetailResponse response = new PurchasedFundsDetailResponse();
        response.setId(dto.getId());
        response.setClientId(dto.getClientId());
        response.setClientName(dto.getClientName());
        response.setEntityName(dto.getInvestmentEntityName());
        response.setFundId(dto.getFundId());
        response.setFundName(dto.getFundName());
        response.setUnitCertificateDate(DateFormatUtil.getMMMddyyyy(dto.getUnitCertificateDate()));
        response.setTransactionDate(DateFormatUtil.getMMMddyyyy(dto.getTransactionDate()));
        response.setPurchaseEndDate(DateFormatUtil.getMMMddyyyy(dto.getPurchaseEndDate()));
        if (ObjectUtils.isNotNull(dto.getPurchaseAmount())) {
            response.setPurchasedAmount(dto.getPurchaseAmount().setScale(1, RoundingMode.HALF_UP));
        }
        if (ObjectUtils.isNotNull(dto.getCurrentReturn())) {
            response.setCurrentReturn(dto.getCurrentReturn().setScale(1, RoundingMode.HALF_UP));
        }
        if (ObjectUtils.isNotNull(dto.getDividendAmount())) {
            response.setDividendAmount(dto.getDividendAmount().setScale(1, RoundingMode.HALF_UP));
        }
        response.setDividendCycle(dto.getDividendCycle());
        try {
            response.setCurrentMonthReturn(getCurrentMonthReturn(dto));
        } catch (Exception e){
            log.error("======queryPurchasedFundById CurrentMonthReturn Calculating Wrong! purchased funds id:{}====", dto.getId());
            throw e;
        }
        try {
            response.setCurrentTotalReturn(getCurrentTotalReturn(dto));
        } catch (Exception e){
            log.error("======queryPurchasedFundById CurrentTotalReturn Calculating Wrong! purchased funds id:{}====", dto.getId());
            throw e;
        }
        response.setInvestmentEntityId(dto.getInvestmentEntityId());
        response.setInvestmentEntityName(dto.getInvestmentEntityName());
        if (StringUtils.hasText(dto.getUnitCerti())){
            response.setUnitCertificate(getPurchasedFundFileFullPath(UNIT_CERTI, dto.getId(), dto.getUnitCerti()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSigned())){
            response.setApplicationFormSigned(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSigned()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedTwo())){
            response.setApplicationFormSignedTwo(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedTwo()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedThree())){
            response.setApplicationFormSignedThree(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedThree()));
        }
        if (StringUtils.hasText(dto.getApplicationFormSignedFour())){
            response.setApplicationFormSignedFour(getPurchasedFundFileFullPath(APPLICATION_FORM, dto.getId(), dto.getApplicationFormSignedFour()));
        }
        response.setCreateAt(DateFormatUtil.getMHHmm(dto.getCreatedAt()));
        return response;
    }

    @Override
    public DateTime offsetWeekendDays(DateTime beginDate) {
        if (DateUtil.dayOfWeekEnum(beginDate).equals(Week.SATURDAY)){
            beginDate = DateUtil.offsetDay(beginDate, 2);
        }
        if (DateUtil.dayOfWeekEnum(beginDate).equals(Week.SUNDAY)){
            beginDate = DateUtil.offsetDay(beginDate, 1);
        }
        return beginDate;
    }

    private BizPurchasedFundsDTO queryPurchasedFundsDTO(Long id) {
        BizPurchasedFundsDTO dto = purchasedFundsMapper.queryPurchasedFundById(id);
        if (ObjectUtils.isNull(dto)) {
            PurchasedFundsErrorEnum.PURCHASED_NOT_EXIST.throwException();
        }
        return dto;
    }

    private PurchasedFundsEntity queryPurchasedFundsEntity(Long id) {
        PurchasedFundsEntity entityFromDB = purchasedFundsMapper.selectOne(
            Wrappers.<PurchasedFundsEntity>query().lambda().eq(PurchasedFundsEntity::getId, id).eq(
                PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtils.isNull(entityFromDB)) {
            PurchasedFundsErrorEnum.PURCHASED_NOT_EXIST.throwException();
        }
        return entityFromDB;
    }

    private List<PurchasedFundsExportDTO> queryExportData(PurchasedFundsQueryRequest request) {
        List<BizPurchasedFundsDTO> bizPurchasedFundsDTOS = purchasedFundsMapper.queryPurchasedFunds(request);
        log.info("query_export_data param : {}", JSONUtil.toJsonStr(request));
        List<PurchasedFundsExportDTO> exportDTOS = new ArrayList<>(bizPurchasedFundsDTOS.size());
        bizPurchasedFundsDTOS.forEach(e -> {
            PurchasedFundsExportDTO dto = new PurchasedFundsExportDTO();
            dto.setFundName(e.getFundName());
            dto.setIcId(e.getIcId());
            if(e.getUnitCertificateDate() != null){
                dto.setUnitCertificateDate(DateUtil.toLocalDateTime(e.getUnitCertificateDate()).toLocalDate());
            }
            if(e.getTransactionDate() != null){
                dto.setTransactionDate(DateUtil.toLocalDateTime(e.getTransactionDate()).toLocalDate());
            }
            if(e.getPurchaseEndDate() != null){
                dto.setPurchaseEndDate(DateUtil.toLocalDateTime(e.getPurchaseEndDate()).toLocalDate());
            }
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, e.getBFundCategory());
            Date totalEndDate = getEndDay(e, fundCategory);
            Date startReturnDay = getStartReturnDay(e);
            dto.setPurchasedAmount(e.getPurchaseAmount());
            Date beginDate = DateUtil.beginOfMonth(new Date());
            Date endDate = DateUtil.endOfMonth(new Date());
            if (request.getEndDate() != null) {
                endDate = DateUtil.parseDate(request.getEndDate());
            }
            if(request.getStartDate() != null){
                beginDate = DateUtil.parseDate(request.getStartDate());
            }
            dto.setCurrentReturn(getReturnByDate(e, beginDate, endDate));
            if (ObjectUtil.equals(Boolean.TRUE, e.getWithheldTax())) {
                dto.setWithholdingTax(dto.getCurrentReturn().multiply(BigDecimal.valueOf(0.1)));
                dto.setNetInterest(dto.getCurrentReturn().multiply(BigDecimal.valueOf(0.9)));
            } else {
                dto.setWithholdingTax(BigDecimal.ZERO);
                dto.setNetInterest(dto.getCurrentReturn());
            }
            dto.setCurrentTotalReturn(getCurrentTotalReturn(e));
            if (StringUtils.hasText(e.getUnitCerti())){
                dto.setUnitCerti(getPurchasedFundFileFullPath(UNIT_CERTI, e.getId(), e.getUnitCerti()));
            }
            if (StringUtils.hasText(e.getApplicationFormSigned())){
                dto.setApplicationForm(getPurchasedFundFileFullPath(APPLICATION_FORM, e.getId(), e.getApplicationFormSigned()));
            }
            dto.setEntityName(e.getEntityName());
            dto.setAddressLine(e.getAddressLine());
            dto.setSuburb(e.getSuburb());
            dto.setState(e.getState());
            dto.setPostCode(e.getPostcode());
            dto.setMonthStart(e.getMonthStart());
            dto.setMonthEnd(e.getMonthEnd());
            dto.setDays(e.getDays());
            dto.setBsb(e.getBsb());
            dto.setAccountName(e.getAccountName());
            dto.setAccountNumber(e.getAccountNumber());
            if (StrUtil.isNotBlank(dto.getIcId())
                    && DateFormatUtil.checkTimesHasOverlap(startReturnDay, totalEndDate, beginDate, endDate)) {
                exportDTOS.add(dto);
            }
        });
        return exportDTOS;
    }

    @Override
    public int getLengthOfThisYear(Date unitCertificateDate) {
//        return DateUtil.lengthOfYear(DateUtil.year(unitCertificateDate));
        return 365;
    }

    public List<String> initialExtractor(String str, String category) {
        StringBuilder initials = new StringBuilder();
        String delimiter = category.equalsIgnoreCase("Pool") ? "[ -]+" : " ";
        String[] words = str.split(delimiter);
        List<String> results = new ArrayList<>();
        String subscript = "¹";
        String directFundName = "";
        boolean checkPoint = true;
        for (String word : words) {
            if (!word.isEmpty()) {
                initials.append(Character.toUpperCase(word.charAt(0)));
            }
            if (word.equalsIgnoreCase("fund")) {
                directFundName += word;
                checkPoint = false;
            }
            if (checkPoint) {
                directFundName += (word + " ");
            }
        }
        String abbre = initials.substring(0, initials.length() - 2);
        String subclass = words[words.length - 2] + " " + words[words.length - 1];
        
        if(category.equalsIgnoreCase("Pool")) {
            if(subclass.equalsIgnoreCase("subclass o") || subclass.equalsIgnoreCase("original class")) {
                subclass += subscript;
                subscript = "²";
            }
            
            if (abbre.equals("BDIOF") || abbre.equals("BUF")) {
                abbre += subscript;
            }
            abbre += initials.charAt(initials.length() - 1);
        } else {
            if(abbre.equalsIgnoreCase("BUDMFB") || abbre.equalsIgnoreCase("BDIMFBF")) {
                // subclass += subscript;
                abbre += subscript;
            }
            subclass = abbre + " " + subclass;
            abbre += (initials.charAt(initials.length() - 2) + words[words.length - 1]);
        }
        
        results.add(abbre);
        results.add(subclass);
        results.add(initials.substring(0, initials.length() - 2));
        results.add(words[words.length - 2] + " " + words[words.length - 1]);
        results.add(directFundName);
        
        return results;
    }
    
    // public List<String> initialExtractorDirect(String str) {
    //     StringBuilder initials = new StringBuilder();
    //     String[] words = str.split(" ");
    //     List<String> results = new ArrayList<>();
    //     String subscript = "¹";
    //     for (String word : words) {
    //         if (!word.isEmpty()) {
    //             initials.append(Character.toUpperCase(word.charAt(0)));
    //         }
    //     }
        
    //     String abbre = initials.substring(0, initials.length() - 2);
    //     String subclass = words[words.length - 2] + " " + words[words.length - 1];
        
        
        
    //     return results;
        
    // }
    

    private String generateUnitCertificate(PurchasedFundsEntity entity,
                                           ClientsEntity clientsEntity, FundsEntity fundsEntity, InvestmentEntities investmentEntity) {
        String pdfTemp = null;
        FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fundsEntity.getBFundCategory());
        BizPurchasedFundsDTO bizPf = getBizPf(entity, fundsEntity);
        Date startReturnDay = getStartReturnDay(bizPf);
        StrBuilder addressBuilder = StrBuilder.create();
        String note1 = "";
        String note2 = "";
        if (StringUtils.hasText(entity.getAddressLine())){
            addressBuilder.append(entity.getAddressLine()).append(", ");
        }
        if (StringUtils.hasText(entity.getSuburb())){
            addressBuilder.append(entity.getSuburb()).append(", ");
        }
        if (StringUtils.hasText(entity.getState())){
            addressBuilder.append(entity.getState()).append(", ");
        }
        if (StringUtils.hasText(entity.getPostcode())){
            addressBuilder.append(entity.getPostcode());
        }
        String address = addressBuilder.toString();
        Integer dailyPurchasedCount = dailyPurchasedCount();
        // these fundId has special unit certificate
        if (ObjectUtil.equals(fundCategory, FundCategoryEnum.POOL)) {
            try {
                Document document = new Document(templatePath +"/unit_certificate_pool_template.docx");
                if (startReturnDay.after(DateUtil.parseDate("2024-06-10"))) {
                    document = new Document(templatePath +"/bcdiof_unit_certificate_subclass_template.docx");
                }
                String fundFullName = CharSequenceUtil.isNotBlank(fundsEntity.getName())?fundsEntity.getName():" - ";
                List<String> parts = initialExtractor(fundFullName, "Pool");
                int index = 1;
                if(parts.get(3).equalsIgnoreCase("Subclass O") || parts.get(3).equalsIgnoreCase("original class")) {
                    fundFullName += "¹";
                    note1 += (index + ". \"Subclass O\" refers to \"Original Class\"");
                    index += 1;
                }
                
                if(parts.get(2).equalsIgnoreCase("BDIOF")) {
                    note2 += (index + ". \"BDIOF\" refers to \"BC Debt Income Opportunities Fund\", same as \"BCDIOF\"");
                } else if(parts.get(2).equalsIgnoreCase("BUF")) {
                    note2 += (index + ". \"BUF\" refers to \"ic UCapital Fund\", same as BUCF");
                }
                
                String[] fundNameParts = fundFullName.split("-");
                String fundName = fundNameParts[0].trim();
                // String className = parts[1].trim();
                
                Range range = document.getRange();
                
                // String initials = initialExtractor(fundFullName);
                
                // range.replace("${fundName}", CharSequenceUtil.isNotBlank(fundsEntity.getName())?fundsEntity.getName():"", new FindReplaceOptions());
                // range.replace("${S}", CharSequenceUtil.isNotBlank(fundsEntity.getName()) ?
                //         fundsEntity.getName().substring(fundsEntity.getName().length() - 1) : "", new FindReplaceOptions());
                
                range.replace("${fundName}", fundFullName, new FindReplaceOptions());
                range.replace("${abbre}", parts.get(0), new FindReplaceOptions());
                range.replace("${S}", parts.get(1), new FindReplaceOptions());
                range.replace("${fund}", fundName, new FindReplaceOptions());
                range.replace("${note1}", note1, new FindReplaceOptions());
                range.replace("${note2}", note2, new FindReplaceOptions());
                
                range.replace("${entityName}", investmentEntity != null ? investmentEntity.getEntityName() : "", new FindReplaceOptions());
                range.replace("${icId}", investmentEntity != null && CharSequenceUtil.isNotBlank(investmentEntity.getIcId()) ?
                        investmentEntity.getIcId() : "", new FindReplaceOptions());
                range.replace("${address}", StringUtils.hasText(address) ? address : "empty address", new FindReplaceOptions());
                range.replace("${purchaseAmount}", ObjectUtils.isNotNull(entity.getPurchaseAmount()) ?
                        AmountFormatUtil.formatThousandsSeparator(entity.getPurchaseAmount()) : "", new FindReplaceOptions());
                range.replace("${subImDate}", ObjectUtils.isNotNull(fundsEntity.getSubImDate()) ?
                        DateFormatUtil.getDdMMMyyyy(fundsEntity.getSubImDate()) : "", new FindReplaceOptions());
                range.replace("${deedDate}", ObjectUtils.isNotNull(fundsEntity.getDeedDate()) ?
                        DateFormatUtil.getDdMMMyyyy(fundsEntity.getDeedDate()) : "", new FindReplaceOptions());
                range.replace("${unitCertificateDate}", ObjectUtils.isNotNull(entity.getUnitCertificateDate()) ?
                        DateFormatUtil.getDdMMMyyyy(entity.getUnitCertificateDate()) : "", new FindReplaceOptions());
                range.replace("${purchaseEndDate}", ObjectUtils.isNotNull(entity.getPurchaseEndDate()) ?
                        DateFormatUtil.getDdMMMyyyy(entity.getPurchaseEndDate()) : "", new FindReplaceOptions());
                range.replace("${fundLastName}", CharSequenceUtil.isNotBlank(fundsEntity.getName()) ?
                        "Subclass-" + fundsEntity.getName().substring(fundsEntity.getName().length() - 1) : "Subclass", new FindReplaceOptions());
                Integer poolNum = redisCache.getCacheObject(RedisConstants.DAILY_UNIT_CERTIFICATE_POOL_NUM);
                if (poolNum == null) {
                    poolNum = 1;
                } else {
                    poolNum += 1;
                }
                range.replace("${dailyOrder}", DateUtil.format(entity.getUnitCertificateDate(), "ddMMyyyy")+poolNum+"", new FindReplaceOptions());
                redisCache.setCacheObject(RedisConstants.DAILY_UNIT_CERTIFICATE_POOL_NUM, poolNum, DateFormatUtil.getRemainSecondsOneDay(new Date()),  TimeUnit.SECONDS);
                ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
                document.save(arrayOutputStream, SaveFormat.PDF);
                ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(arrayOutputStream.toByteArray());
                storageProcessor.store(byteArrayInputStream, PURCHASED_FUND, UNIT_CERTI, entity.getId().toString(), entity.getUnitCerti());
            } catch (Exception e) {
                log.error("getPoolDoc error", e);
            }
        } else if (fundCategory.equals(FundCategoryEnum.DIRECT)) {
            Map<String, Object> data = new HashMap();
            if (ObjectUtil.equals(fundsEntity.getLanguage(), LanguageEnum.EN.getCode())) {
                data.put("fundName", StringUtils.hasText(fundsEntity.getName()) ? fundsEntity.getName() : "");
            } else {
                FundsEntity transEntity = fundsMapper.selectOne(Wrappers.<FundsEntity>query().lambda()
                        .eq(FundsEntity::getId, entity.getFundId())
                        .eq(FundsEntity::getDelFlag, Boolean.FALSE));
                data.put("fundName", ObjectUtils.isNotNull(transEntity) && StringUtils.hasText(transEntity.getName()) ? transEntity.getName() : "");
            }
            String fundName = data.get("fundName").toString();
            List<String> parts = initialExtractor(fundName, "DIRECT");
            String note = "";
            
            if(parts.get(2).equalsIgnoreCase("BUDMFB")) {
                note += "1. \"BUDMFB\" refers to \"ic UCapital Debt Master Fund BCUC Series\", same as \"BCUC\"";
            } else if(parts.get(2).equalsIgnoreCase("BDIMFBF")) {
                note += "1. \"BDIMFBF\" refers to \"ic Debt Income Master Fund BC First Series\", same as \"BCFC\"";
            }
            
            try {
                data.put("trustNumber", StringUtils.hasText(fundName) ? fundName.split(" ")[fundName.split(" ").length - 1] : "");
            } catch (IndexOutOfBoundsException e) {
                data.put("trustNumber", "");
            }
            data.put("entityName", StringUtils.hasText(investmentEntity.getEntityName()) ? investmentEntity.getEntityName() : "");
            data.put("icId", StringUtils.hasText(investmentEntity.getIcId()) ? investmentEntity.getIcId() : "");
            data.put("clientBeaverId", StringUtils.hasText(investmentEntity.getIcId()) ? investmentEntity.getIcId() : "");
            
            data.put("abbre", parts.get(0));
            data.put("trustCode", parts.get(1));
            data.put("note", note);
            data.put("fund", parts.get(4));
            
            data.put("address", StringUtils.hasText(address) ? address : "empty address");
            data.put("purchaseAmount",
                    ObjectUtils.isNotNull(entity.getPurchaseAmount()) ? AmountFormatUtil.formatThousandsSeparator(entity.getPurchaseAmount()) : "");
            data.put("unitCertificateDate",
                    ObjectUtils.isNotNull(entity.getUnitCertificateDate()) ? DateFormatUtil.getDdMMMyyyy(entity.getUnitCertificateDate()) : "");
            data.put("pure_unitCertificateDate",
                    ObjectUtils.isNotNull(entity.getUnitCertificateDate()) ? DateUtil.format(entity.getUnitCertificateDate(), "ddMMyyyy") : "");
            data.put("daily_purchased_count", dailyPurchasedCount);
            data.put("purchaseEndDate",
                    ObjectUtils.isNotNull(entity.getPurchaseEndDate()) ?
                            DateFormatUtil.getDdMMMyyyy(entity.getPurchaseEndDate()) : "");
            data.put("subImDate",
                    ObjectUtils.isNotNull(fundsEntity.getSubImDate()) ?
                            DateFormatUtil.getDdMMMyyyy(fundsEntity.getSubImDate()) : "");
            data.put("deedDate",
                    ObjectUtils.isNotNull(fundsEntity.getDeedDate()) ?
                            DateFormatUtil.getDdMMMyyyy(fundsEntity.getDeedDate()) : "");
            data.put("investmentEndDate", ObjectUtils.isNotNull(bizPf.getPurchaseEndDate()) ?
                            DateFormatUtil.getDdMMMyyyy(bizPf.getPurchaseEndDate()) : "");
            if (startReturnDay.before(DateUtil.parseDate("2024-06-10"))) {
                pdfTemp = StrBuilder.create(PDF_TEMP_PATH).append(FileUtil.SLASH).append(entity.getUnitCerti()).toString();
                HtmlToPDFUtils.createPdfFile(data, FIRST_CAPITAL_TRUST_2_TEMPLATE, pdfTemp);
                if (!StringUtils.hasText(pdfTemp)){
                    PurchasedFundsErrorEnum.CERTIFICATE_GENERATE_FAIL.throwException();
                }
            }else{
                try {
                    Document document = new Document(templatePath +"/bcfc_unit_certificate_trust_subclass.docx");
                    Range range = document.getRange();
                    for (String s : data.keySet()) {
                        range.replace(String.format("${%s}", s), MapUtil.getStr(data, s, ""), new FindReplaceOptions());
                    }
                    Integer poolNum = redisCache.getCacheObject(RedisConstants.DAILY_UNIT_CERTIFICATE_POOL_NUM);
                    if (poolNum == null) {
                        poolNum = 1;
                    } else {
                        poolNum += 1;
                    }
                    range.replace("${dailyOrder}", DateUtil.format(entity.getUnitCertificateDate(), "ddMMyyyy")+poolNum+"", new FindReplaceOptions());
                    redisCache.setCacheObject(RedisConstants.DAILY_UNIT_CERTIFICATE_POOL_NUM, poolNum, DateFormatUtil.getRemainSecondsOneDay(new Date()),  TimeUnit.SECONDS);
                    ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
                    document.save(arrayOutputStream, SaveFormat.PDF);
                    ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(arrayOutputStream.toByteArray());
                    storageProcessor.store(byteArrayInputStream, PURCHASED_FUND, UNIT_CERTI, entity.getId().toString(), entity.getUnitCerti());
                } catch (Exception e) {
                    log.error("getDirectDoc error", e);
                }
            }
        }
        return pdfTemp;
    }

    // before generate certificate

    private FundsEntity getFundsEntity(PurchasedFundsEntity entity) {
        FundsEntity fundsEntity = fundsMapper.selectOne(Wrappers.<FundsEntity>query().lambda()
                                                            .eq(FundsEntity::getId, entity.getFundId())
                                                            .eq(FundsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtils.isNull(fundsEntity)){
            FundsErrorEnum.FUND_NOT_EXIST.throwException();
        }
        entity.setFundName(fundsEntity.getName());
        return fundsEntity;
    }
    private void saveCertificateToOss(PurchasedFundsEntity entity, String pdfTemp) {
        File unitCertificatePdf = new File(pdfTemp);
        MockMultipartFile unitCertificatePdfMulti = null;
        if (unitCertificatePdf.exists()){
            try {
                unitCertificatePdfMulti = new MockMultipartFile("unitCertificatePdf", unitCertificatePdf.getName(),
                                                                null, new FileInputStream(unitCertificatePdf)
                );
            } catch (FileNotFoundException fe){
                fe.printStackTrace();
            } catch (IOException ioE){
                ioE.printStackTrace();
            }
            // save pdf in oss
            saveFileInOss(unitCertificatePdfMulti, entity);
            // del pdf in server
            unitCertificatePdf.delete();
        }
    }
    // before generate certificate
    private ClientsEntity getClientsEntity(PurchasedFundsEntity entity) {
        ClientsEntity clientsEntity = clientsMapper.selectOne(Wrappers.<ClientsEntity>query().lambda()
                                                                  .eq(ClientsEntity::getId, entity.getClientId())
                                                                  .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtils.isNull(clientsEntity)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        entity.setClientName(clientsEntity.getName());
        return clientsEntity;
    }

    private Integer dailyPurchasedCount(){
        Integer dailyCount = (Integer) redisCache.getCacheObject(RedisConstants.DAILY_COUNTER_PURCHASED_FUND);
        if (ObjectUtil.isNotNull(dailyCount)){
            dailyCount += 1;
        } else {
            dailyCount = 1;
        }
        // 设置 0点过期
        redisCache.setCacheObject(RedisConstants.DAILY_COUNTER_PURCHASED_FUND, dailyCount,
                getRemainSecondsOneDay(new Date()), TimeUnit.SECONDS);
        return dailyCount;
    }

    public static Integer getRemainSecondsOneDay(Date currentDate) {
        //使用plusDays加传入的时间加1天，将时分秒设置成0
        LocalDateTime midnight = LocalDateTime.ofInstant(currentDate.toInstant(),
                                                         ZoneId.systemDefault()).plusDays(1).withHour(0).withMinute(0)
            .withSecond(0).withNano(0);
        LocalDateTime currentDateTime = LocalDateTime.ofInstant(currentDate.toInstant(),
                                                                ZoneId.systemDefault());
        //使用ChronoUnit.SECONDS.between方法，传入两个LocalDateTime对象即可得到相差的秒数
        long seconds = ChronoUnit.SECONDS.between(currentDateTime, midnight);
        return (int) seconds;
    }



}
