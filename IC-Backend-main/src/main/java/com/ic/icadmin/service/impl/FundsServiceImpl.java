package com.ic.icadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.funds.FundCreateRequest;
import com.ic.icadmin.dto.request.funds.FundEditRequest;
import com.ic.icadmin.dto.request.funds.FundsQueryRequest;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundEditDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsExportDTO;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.ic.icadmin.entity.*;
import com.ic.icadmin.mapper.FundsMapper;
import com.ic.icadmin.mapper.PurchasedFundsMapper;
import com.ic.icadmin.service.IFundsService;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.service.OperateLogService;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.enums.OperateEntityTypeEnum;
import com.ic.icadmin.share.enums.OperateTypeEnum;
import com.ic.icadmin.share.error.CommonErrorEnum;
import com.ic.icadmin.share.error.FundsErrorEnum;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.function.BiConsumer;
import java.util.function.Function;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 13:42
 **/
@Slf4j
@Service
public class FundsServiceImpl implements IFundsService {
    
    private final static String FUND = "fund";
    
    private final static String IM_FILE_PATH = "im_file_path";
    private final static String SUB_IM_FILE_PATH = "sub_im_file_path";
    private final static String INTRODUCE_FILE_PATH = "introduce_file_path";
    private final static String EOI_FILE_PATH = "eoi_file_path";
    private final static String REPORT_FILE_PATH = "report_file_path";
    private final static String ADDITIONAL_INVESTMENT_FILE = "additional_investment_file";
    private final static String CONSTITUTION_FILE = "constitution_file";
    private final static String APPLICATION_FORM = "application_form";
    private final static String COVER = "cover";
    private final static String COVER_CN = "cover_cn";

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";
    private static final Pattern PATTERN = Pattern.compile("^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/\\d{4}$");
    private static final Pattern DATE_PATTERN = Pattern.compile("^\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$");

    @Autowired
    private FundsMapper fundsMapper;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private ExportService exportService;

    @Resource
    private PurchasedFundsMapper pfMapper;

    @Resource
    OperateLogService logService;

    private static final List<Function<FundsEntity, String>> GET_LIST = Lists.newArrayList(
            FundsEntity::getCover,
            FundsEntity::getCoverCn,
            FundsEntity::getCoverTwo,
            FundsEntity::getCoverCnTwo,
            FundsEntity::getCoverThree,
            FundsEntity::getCoverCnThree,
            FundsEntity::getCoverFour,
            FundsEntity::getCoverCnFour
    );
    private static final List<BiConsumer<FundsEntity, String>> SET_LIST = Lists.newArrayList(
            FundsEntity::setCover,
            FundsEntity::setCoverCn,
            FundsEntity::setCoverTwo,
            FundsEntity::setCoverCnTwo,
            FundsEntity::setCoverThree,
            FundsEntity::setCoverCnThree,
            FundsEntity::setCoverFour,
            FundsEntity::setCoverCnFour
    );
    public static void main(String[] args) {
        FundsEntity purchasedFundsEntity = new FundsEntity();
        purchasedFundsEntity.setCover("https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/fund/cover_cn/133/https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/fund/cover_cn/133/https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/fund/cover_cn/133/1807986758692818944.png");
        for (int i = 0; i < GET_LIST.size(); i++) {
            String str = GET_LIST.get(i).apply(purchasedFundsEntity);
            if (CharSequenceUtil.isNotBlank(str)) {
                SET_LIST.get(i).accept(purchasedFundsEntity, str.substring(str.lastIndexOf("/") + 1));
            }
        }
        System.out.println(purchasedFundsEntity.getCover());
        System.out.println(Optional.ofNullable(purchasedFundsEntity.getCover()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
    }
    @Override
    public CommonResponse<PageInfo<FundsResponse>> queryFunds(FundsQueryRequest request, int pageNum, int pageSize) {
        ClientsEntity client = LoginUserUtil.getLoginClientNormal();
        List<Long> idList;
        if (client != null) {
            List<PurchasedFundsEntity> purchasedFundsEntities = pfMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                    .select(PurchasedFundsEntity::getFundId)
                    .eq(PurchasedFundsEntity::getClientId, client.getId())
                    .eq(request.getEntityId() != null, PurchasedFundsEntity::getClientId, request.getEntityId())
                    .groupBy(PurchasedFundsEntity::getFundId));
            idList = purchasedFundsEntities.stream().map(PurchasedFundsEntity::getFundId).collect(Collectors.toList());
            if (request.getHistory() != null) {
                if (request.getHistory() && idList.isEmpty()) {
                    return CommonResponse.success();
                }
                if (Boolean.TRUE.equals(request.getHistory())) {
                    request.setIdList(idList);
                } else {
                    request.setExcludeIdList(idList);
                }
            }
        } else {
            idList = null;
        }
        PageInfo<FundsEntity> fundsEntities = PageHelper.startPage(pageNum, pageSize)
                .doSelectPageInfo(()->queryFundsEntities(request));
        PageInfo<FundsResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(fundsEntities, responses, "list");
        responses.setList(
            fundsEntities.getList().stream().map((FundsEntity f)-> {
                FundsResponse response = new FundsResponse(f);
                if (StringUtils.hasText(f.getCover())) {
                    response.setCover(getFundFileFullPath(COVER, f.getId(), f.getCover()));
                }
                if (StringUtils.hasText(f.getCoverCn())) {
                    response.setCoverCn(getFundFileFullPath(COVER_CN, f.getId(), f.getCoverCn()));
                }
                if (StringUtils.hasText(f.getCoverTwo())) {
                    response.setCoverTwo(getFundFileFullPath(COVER, f.getId(), f.getCoverTwo()));
                }
                if (StringUtils.hasText(f.getCoverCnTwo())) {
                    response.setCoverCnTwo(getFundFileFullPath(COVER_CN, f.getId(), f.getCoverCnTwo()));
                }
                if (StringUtils.hasText(f.getCoverThree())) {
                    response.setCoverThree(getFundFileFullPath(COVER, f.getId(), f.getCoverThree()));
                }
                if (StringUtils.hasText(f.getCoverCnThree())) {
                    response.setCoverCnThree(getFundFileFullPath(COVER_CN, f.getId(), f.getCoverCnThree()));
                }
                if (StringUtils.hasText(f.getCoverFour())) {
                    response.setCoverFour(getFundFileFullPath(COVER, f.getId(), f.getCoverFour()));
                }
                if (StringUtils.hasText(f.getCoverCnFour())) {
                    response.setCoverCnFour(getFundFileFullPath(COVER_CN, f.getId(), f.getCoverCnFour()));
                }
                if (StringUtils.hasText(f.getImFilePath())) {
                    response.setImFilePath(getFundFileFullPath(IM_FILE_PATH, f.getId(), f.getImFilePath()));
                }
                if (StringUtils.hasText(f.getEoiFilePath())) {
                    response.setEoiFilePath(getFundFileFullPath(EOI_FILE_PATH, f.getId(), f.getEoiFilePath()));
                }
                if (idList != null && idList.contains(f.getId())) {
                    response.setHistory(Boolean.TRUE);
                }
                return response;
            }).collect(Collectors.toList()));
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<FundDetailResponse> queryFundById(QueryByIdRequest request) {
        FundsEntity fundsEntity = getFundEntity(request);
        FundDetailResponse response = new FundDetailResponse(fundsEntity);
        if (StringUtils.hasText(fundsEntity.getImFilePath())){
            response.setImFilePath(getFundFileFullPath(IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getImFilePath()));
        }
        if (StringUtils.hasText(fundsEntity.getIntroduceFilePath())){
            response.setIntroduceFilePath(getFundFileFullPath(INTRODUCE_FILE_PATH, fundsEntity.getId(), fundsEntity.getIntroduceFilePath()));
        }
        if (StringUtils.hasText(fundsEntity.getEoiFilePath())){
            response.setEoiFilePath(getFundFileFullPath(EOI_FILE_PATH, fundsEntity.getId(), fundsEntity.getEoiFilePath()));
        }
        if (StringUtils.hasText(fundsEntity.getReportFilePath())){
            response.setReportFilePath(getFundFileFullPath(REPORT_FILE_PATH, fundsEntity.getId(), fundsEntity.getReportFilePath()));
        }
        if (StringUtils.hasText(fundsEntity.getAdditionalInvestmentFile())){
            response.setAdditionalInvestmentFile(getFundFileFullPath(ADDITIONAL_INVESTMENT_FILE, fundsEntity.getId(),
             fundsEntity.getAdditionalInvestmentFile()));
        }
        if (StringUtils.hasText(fundsEntity.getConstitutionFile())){
            response.setConstitutionFile(getFundFileFullPath(CONSTITUTION_FILE, fundsEntity.getId(), fundsEntity.getConstitutionFile()));
        }
        if (StringUtils.hasText(fundsEntity.getSubImFilePath())){
            response.setSubImFilePath(getFundFileFullPath(SUB_IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getSubImFilePath()));
        }
        if (StringUtils.hasText(fundsEntity.getApplicationForm())){
            response.setApplicationForm(getFundFileFullPath(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationForm()));
        }
        if (StringUtils.hasText(fundsEntity.getCover())){
            response.setCover(getFundFileFullPath(COVER, fundsEntity.getId(), fundsEntity.getCover()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverCn())){
            response.setCoverCn(getFundFileFullPath(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCn()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverTwo())){
            response.setCoverTwo(getFundFileFullPath(COVER, fundsEntity.getId(), fundsEntity.getCoverTwo()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverCnTwo())){
            response.setCoverCnTwo(getFundFileFullPath(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnTwo()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverThree())){
            response.setCoverThree(getFundFileFullPath(COVER, fundsEntity.getId(), fundsEntity.getCoverThree()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverCnThree())){
            response.setCoverCnThree(getFundFileFullPath(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnThree()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverFour())){
            response.setCoverFour(getFundFileFullPath(COVER, fundsEntity.getId(), fundsEntity.getCoverFour()));
        }
        if (StringUtils.hasText(fundsEntity.getCoverCnFour())){
            response.setCoverCnFour(getFundFileFullPath(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnFour()));
        }
        return CommonResponse.success(response);
    }

    @Override
    public String getFundFileFullPath(String fileType, Long fundId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(FUND, fileType, fundId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }

    @Override
    public CommonResponse<List<FundsResponse>> popular() {
        List<Long> fundIdList = pfMapper.getPopularFundId();
        List<FundsEntity> fundsEntities = Lists.newArrayList();
        if (CollUtil.isNotEmpty(fundIdList)) {
            fundsEntities.addAll(fundsMapper.selectList(new LambdaQueryWrapper<FundsEntity>()
                    .eq(FundsEntity::getDelFlag, Boolean.FALSE).in(FundsEntity::getId, fundIdList)));
        }
        if (fundsEntities.size() < 6) {
            fundsEntities.addAll(fundsMapper.selectList(new LambdaQueryWrapper<FundsEntity>()
                    .notIn(FundsEntity::getId, fundIdList)
                    .eq(FundsEntity::getDelFlag, Boolean.FALSE)
                    .last(" limit " + (6 - fundsEntities.size()))));
        }
        List<FundsResponse> result = fundsEntities.stream().map(f -> {
            FundsResponse response = new FundsResponse(f);
            if (StringUtils.hasText(f.getCover())) {
                response.setCover(getFundFileFullPath(COVER, f.getId(), f.getCover()));
            }
            if (StringUtils.hasText(f.getCoverCn())) {
                response.setCoverCn(getFundFileFullPath(COVER_CN, f.getId(), f.getCoverCn()));
            }
            return response;
        }).collect(Collectors.toList());
        return CommonResponse.success(result);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createFund(MultipartFile imFilePath, MultipartFile subImFilePath,
                           MultipartFile introduceFilePath, MultipartFile eoiFilePath,
                           MultipartFile reportFilePath, MultipartFile additionalInvestmentFile,
                           MultipartFile constitutionFile, MultipartFile applicationForm,
                           MultipartFile applicationFormTwo,
                           MultipartFile applicationFormThree,  MultipartFile applicationFormFour,
                           MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree,
                           MultipartFile coverFour, MultipartFile coverCn, MultipartFile coverCnTwo,
                           MultipartFile coverCnThree, MultipartFile coverCnFour, FundCreateRequest request) {
        FundsEntity fundsEntity = buildFundEntity(imFilePath, subImFilePath, introduceFilePath, eoiFilePath,
                                                 reportFilePath, additionalInvestmentFile, constitutionFile,
                                                 applicationForm, cover, coverCn, applicationFormFour, cover, coverTwo, coverThree, coverFour, coverCn, coverCnTwo, coverCnThree, coverCnFour, request);
        int insert = fundsMapper.insert(fundsEntity);
        if (insert != 1){
            FundsErrorEnum.FUND_CREATE_FAIL.throwException();
        }
        batchStoreFundFiles(imFilePath, subImFilePath, introduceFilePath, eoiFilePath, reportFilePath, additionalInvestmentFile,
                  constitutionFile, applicationForm,
                applicationFormTwo,
                applicationFormThree,
                applicationFormFour,
                cover,
                coverTwo,
                coverThree,
                coverFour,
                coverCn,
                coverCnTwo,
                coverCnThree,
                coverCnFour, fundsEntity);
        logService.saveLog(OperateEntityTypeEnum.FUND.getMessage(), fundsEntity.getId(), OperateTypeEnum.CREATE.getMessage(), fundsEntity.getName());
        return fundsEntity.getId();
    }


    @Override
    public CommonResponse<FundEditDetailResponse> queryFundByIdWhenEdit(QueryByIdRequest request) {
        FundsEntity fundsEntity = getFundEntity(request);
        return CommonResponse.success(new FundEditDetailResponse(fundsEntity));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editFund(MultipartFile imFilePath, MultipartFile subImFilePath,
                                         MultipartFile introduceFilePath, MultipartFile eoiFilePath,
                                         MultipartFile reportFilePath, MultipartFile additionalInvestmentFile,
                                         MultipartFile constitutionFile, MultipartFile applicationForm,
                                         MultipartFile applicationFormTwo,
                                         MultipartFile applicationFormThree,  MultipartFile applicationFormFour,
                                         MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree,
                                         MultipartFile coverFour, MultipartFile coverCn, MultipartFile coverCnTwo,
                                         MultipartFile coverCnThree, MultipartFile coverCnFour, FundEditRequest request) {
        FundsEntity entityFromDB = fundsMapper.selectOne(
            Wrappers.<FundsEntity>query().lambda().eq(FundsEntity::getId, request.getId()).eq(FundsEntity::getDelFlag,
                                                                                              Boolean.FALSE));

        if (ObjectUtil.isNull(entityFromDB)){
            FundsErrorEnum.FUND_NOT_EXIST.throwException();
        }
        FundsEntity fundsEntity = buildFundEntity(imFilePath, subImFilePath, introduceFilePath, eoiFilePath,
                                                  reportFilePath, additionalInvestmentFile, constitutionFile,
                                                  applicationForm, applicationFormTwo,
                applicationFormThree,
                applicationFormFour,
                cover,
                coverTwo,
                coverThree,
                coverFour,
                coverCn,
                coverCnTwo,
                coverCnThree,
                coverCnFour, request);
        fundsEntity.setId(request.getId());
        fundsEntity.setCreatedAt(null);
        int update = fundsMapper.update(null, Wrappers.<FundsEntity>update().lambda()
                .set(FundsEntity::getName, fundsEntity.getName())
                .set(FundsEntity::getNameCN, fundsEntity.getNameCN())
                .set(FundsEntity::getDescription, fundsEntity.getDescription())
                .set(FundsEntity::getDescriptionCN, fundsEntity.getDescriptionCN())
                .set(FundsEntity::getSettlementDate, fundsEntity.getSettlementDate())
                .set(FundsEntity::getInterestStartsDate, fundsEntity.getInterestStartsDate())
                .set(FundsEntity::getAmount, fundsEntity.getAmount())
                .set(FundsEntity::getCurrency, fundsEntity.getCurrency())
                .set(FundsEntity::getCurrencyCN, fundsEntity.getCurrencyCN())
                .set(FundsEntity::getFundType, fundsEntity.getFundType())
                .set(FundsEntity::getFundTypeCN, fundsEntity.getFundTypeCN())
                .set(FundsEntity::getInvestmentType, fundsEntity.getInvestmentType())
                .set(FundsEntity::getInvestmentTypeCN, fundsEntity.getInvestmentTypeCN())
                .set(FundsEntity::getProductType, fundsEntity.getProductType())
                .set(FundsEntity::getProductTypeCN, fundsEntity.getProductTypeCN())
                .set(FundsEntity::getPurchaseMinAmount, fundsEntity.getPurchaseMinAmount())
                .set(FundsEntity::getInvestmentCycle, fundsEntity.getInvestmentCycle())
                .set(FundsEntity::getInvestmentCycleCN, fundsEntity.getInvestmentCycleCN())
                .set(FundsEntity::getFixNetReturn, fundsEntity.getFixNetReturn())
                .set(FundsEntity::getFixNetReturnCN, fundsEntity.getFixNetReturnCN())
                .set(FundsEntity::getFloatNetReturn, fundsEntity.getFloatNetReturn())
                .set(FundsEntity::getFloatNetReturnCN, fundsEntity.getFloatNetReturnCN())
                .set(FundsEntity::getApplicationFeeRate, fundsEntity.getApplicationFeeRate())
                .set(FundsEntity::getApplicationFeeRateCN, fundsEntity.getApplicationFeeRateCN())
                .set(FundsEntity::getManagementFeeRate, fundsEntity.getManagementFeeRate())
                .set(FundsEntity::getManagementFeeRateCN, fundsEntity.getManagementFeeRateCN())
                .set( FundsEntity::getImFilePath, fundsEntity.getImFilePath())
                .set( FundsEntity::getIntroduceFilePath, fundsEntity.getIntroduceFilePath())
                .set( FundsEntity::getEoiFilePath, fundsEntity.getEoiFilePath())
                .set(FundsEntity::getUpdatedAt, fundsEntity.getUpdatedAt())
                .set(FundsEntity::getNetReturnA, fundsEntity.getNetReturnA())
                .set(FundsEntity::getNetReturnACN, fundsEntity.getNetReturnACN())
                .set(FundsEntity::getNetReturnB, fundsEntity.getNetReturnB())
                .set(FundsEntity::getNetReturnBCN, fundsEntity.getNetReturnBCN())
                .set(FundsEntity::getCashDividedCycle, fundsEntity.getCashDividedCycle())
                .set(FundsEntity::getCashDividedCycleCN, fundsEntity.getCashDividedCycleCN())
                .set(FundsEntity::getPerformanceFeeRate, fundsEntity.getPerformanceFeeRate())
                .set(FundsEntity::getPerformanceFeeRateCN, fundsEntity.getPerformanceFeeRateCN())
                .set(FundsEntity::getInvestmentStrategy, fundsEntity.getInvestmentStrategy())
                .set(FundsEntity::getInvestmentStrategyCN, fundsEntity.getInvestmentStrategyCN())
                .set(FundsEntity::getNatureYearlyReturn, fundsEntity.getNatureYearlyReturn())
                .set(FundsEntity::getNatureYearlyReturnCN, fundsEntity.getNatureYearlyReturnCN())
                .set(FundsEntity::getValueYearlyReturn, fundsEntity.getValueYearlyReturn())
                .set(FundsEntity::getValueYearlyReturnCN, fundsEntity.getValueYearlyReturnCN())
                .set(FundsEntity::getSubscriptionFeeRate, fundsEntity.getSubscriptionFeeRate())
                .set(FundsEntity::getSubscriptionFeeRateCN, fundsEntity.getSubscriptionFeeRateCN())
                .set(FundsEntity::getReportFilePath, fundsEntity.getReportFilePath())
                .set(FundsEntity::getLanguage, fundsEntity.getLanguage())
                .set(FundsEntity::getTransId, fundsEntity.getTransId())
                .set(FundsEntity::getAdditionalInvestmentFile, fundsEntity.getAdditionalInvestmentFile())
                .set(FundsEntity::getDisplayOrder, fundsEntity.getDisplayOrder())
                .set(FundsEntity::getConstitutionFile, fundsEntity.getConstitutionFile())
                .set(FundsEntity::getBFundCategory, fundsEntity.getBFundCategory())
                .set(FundsEntity::getBProjectDurationMonth, fundsEntity.getBProjectDurationMonth())
                .set(FundsEntity::getBYearlyReturnRate, fundsEntity.getBYearlyReturnRate())
                .set(FundsEntity::getBDelayedGrowthRate, fundsEntity.getBDelayedGrowthRate())
                .set(FundsEntity::getFullySubscription, fundsEntity.getFullySubscription())
                .set(FundsEntity::getFundStatus, fundsEntity.getFundStatus())
                .set(FundsEntity::getEndDate, fundsEntity.getEndDate())
                .set(FundsEntity::getSubImFilePath, fundsEntity.getSubImFilePath())
                .set(FundsEntity::getApplicationForm, fundsEntity.getApplicationForm())
                .set(CharSequenceUtil.isNotBlank(fundsEntity.getApplicationFormTwo()), FundsEntity::getApplicationFormTwo, fundsEntity.getApplicationFormTwo())
                .set(CharSequenceUtil.isNotBlank(fundsEntity.getApplicationFormThree()), FundsEntity::getApplicationFormThree, fundsEntity.getApplicationFormThree())
                .set(CharSequenceUtil.isNotBlank(fundsEntity.getApplicationFormFour()), FundsEntity::getApplicationFormFour, fundsEntity.getApplicationFormFour())
                .set(FundsEntity::getSubImDate, fundsEntity.getSubImDate())
                .set(FundsEntity::getDeedDate, fundsEntity.getDeedDate())
                .set(FundsEntity::getCover, fundsEntity.getCover())
                .set(FundsEntity::getCoverCn, fundsEntity.getCoverCn())
                .set(FundsEntity::getCoverTwo, fundsEntity.getCoverTwo())
                .set(FundsEntity::getCoverCnTwo, fundsEntity.getCoverCnTwo())
                .set(FundsEntity::getCoverThree, fundsEntity.getCoverThree())
                .set(FundsEntity::getCoverCnThree, fundsEntity.getCoverCnThree())
                .set(FundsEntity::getCoverFour, fundsEntity.getCoverFour())
                .set(FundsEntity::getCoverCnFour, fundsEntity.getCoverCnFour())
                .set(ObjectUtil.isNotNull(fundsEntity.getPopular()), FundsEntity::getPopular, fundsEntity.getPopular())
                .set(ObjectUtil.isNotNull(fundsEntity.getStateId()), FundsEntity::getStateId, fundsEntity.getStateId())
                .set(ObjectUtil.isNotNull(fundsEntity.getStateCn()), FundsEntity::getStateCn, fundsEntity.getStateCn())
                .set(ObjectUtil.isNotNull(fundsEntity.getStateEn()), FundsEntity::getStateEn, fundsEntity.getStateEn())
                .set(FundsEntity::getExtendStartDate, fundsEntity.getExtendStartDate())
                .set(FundsEntity::getDefaultStartDate, fundsEntity.getDefaultStartDate())
                .set(FundsEntity::getCompany, fundsEntity.getCompany())
                .eq(FundsEntity::getId, fundsEntity.getId()));
        if (update != 1){
            FundsErrorEnum.FUND_UPDATE_FAIL.throwException();
        }
        batchStoreFundFiles(imFilePath, subImFilePath, introduceFilePath, eoiFilePath, reportFilePath, additionalInvestmentFile,
                            constitutionFile, applicationForm, cover, coverCn, applicationFormFour, cover, coverTwo, coverThree, coverFour, coverCn, coverCnTwo, coverCnThree, coverCnFour, fundsEntity);
        CompletableFuture.runAsync(()->{
        if (ObjectUtil.isNotNull(imFilePath)){
            delFundFileInOss(IM_FILE_PATH, entityFromDB.getId(), entityFromDB.getImFilePath());
        }
        if (ObjectUtil.isNotNull(subImFilePath)){
            delFundFileInOss(SUB_IM_FILE_PATH, entityFromDB.getId(), entityFromDB.getSubImFilePath());
        }
        if (ObjectUtil.isNotNull(introduceFilePath)){
            delFundFileInOss(INTRODUCE_FILE_PATH, entityFromDB.getId(), entityFromDB.getIntroduceFilePath());
        }
        if (ObjectUtil.isNotNull(eoiFilePath)){
            delFundFileInOss(EOI_FILE_PATH, entityFromDB.getId(), entityFromDB.getEoiFilePath());
        }
        if (ObjectUtil.isNotNull(reportFilePath)){
            delFundFileInOss(REPORT_FILE_PATH, entityFromDB.getId(), entityFromDB.getReportFilePath());
        }
        if (ObjectUtil.isNotNull(additionalInvestmentFile)){
            delFundFileInOss(ADDITIONAL_INVESTMENT_FILE, entityFromDB.getId(), entityFromDB.getAdditionalInvestmentFile());
        }
        if (ObjectUtil.isNotNull(constitutionFile)){
            delFundFileInOss(CONSTITUTION_FILE, entityFromDB.getId(), entityFromDB.getConstitutionFile());
        }
        if (ObjectUtil.isNotNull(applicationForm)){
            delFundFileInOss(APPLICATION_FORM, entityFromDB.getId(), entityFromDB.getApplicationForm());
        }
        if (ObjectUtil.isNotNull(cover)){
            delFundFileInOss(COVER, entityFromDB.getId(), entityFromDB.getCover());
        }
        if (ObjectUtil.isNotNull(coverCn)){
            delFundFileInOss(COVER_CN, entityFromDB.getId(), entityFromDB.getCoverCn());
        }
        if (ObjectUtil.isNotNull(coverTwo)){
            delFundFileInOss(COVER, entityFromDB.getId(), entityFromDB.getCoverTwo());
        }
        if (ObjectUtil.isNotNull(coverCnTwo)){
            delFundFileInOss(COVER_CN, entityFromDB.getId(), entityFromDB.getCoverCnTwo());
        }
        if (ObjectUtil.isNotNull(coverThree)){
            delFundFileInOss(COVER, entityFromDB.getId(), entityFromDB.getCoverThree());
        }
        if (ObjectUtil.isNotNull(coverCnThree)){
            delFundFileInOss(COVER_CN, entityFromDB.getId(), entityFromDB.getCoverCnThree());
        }
        if (ObjectUtil.isNotNull(coverFour)){
            delFundFileInOss(COVER, entityFromDB.getId(), entityFromDB.getCoverFour());
        }
        if (ObjectUtil.isNotNull(coverCnFour)){
            delFundFileInOss(COVER_CN, entityFromDB.getId(), entityFromDB.getCoverCnFour());
        }
        }, executor);
        logService.saveUpdateLog(OperateEntityTypeEnum.FUND.getMessage(), fundsEntity.getId(), fundsEntity, entityFromDB, fundsEntity.getName());
        return CommonResponse.success(request.getId());
    }



    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delFund(QueryByIdRequest request) {
        FundsEntity entityFromDB = getFundEntity(request);
        int update = fundsMapper.update(null, Wrappers.<FundsEntity>update().lambda()
            .set(FundsEntity::getDelFlag,Boolean.TRUE)
            .set(FundsEntity::getUpdatedAt, new Date())
            .eq(FundsEntity::getId, request.getId()));
        if (update != 1){
            FundsErrorEnum.FUND_DELETE_FAIL.throwException();
        }
        CompletableFuture.runAsync(()->{
            if (StringUtils.hasText(entityFromDB.getImFilePath())){
                delFundFileInOss(IM_FILE_PATH, entityFromDB.getId(), entityFromDB.getImFilePath());
            }
            if (StringUtils.hasText(entityFromDB.getSubImFilePath())){
                delFundFileInOss(SUB_IM_FILE_PATH, entityFromDB.getId(), entityFromDB.getSubImFilePath());
            }
            if (StringUtils.hasText(entityFromDB.getIntroduceFilePath())){
                delFundFileInOss(INTRODUCE_FILE_PATH, entityFromDB.getId(), entityFromDB.getIntroduceFilePath());
            }
            if (StringUtils.hasText(entityFromDB.getEoiFilePath())){
                delFundFileInOss(EOI_FILE_PATH, entityFromDB.getId(), entityFromDB.getEoiFilePath());
            }
            if (StringUtils.hasText(entityFromDB.getReportFilePath())){
                delFundFileInOss(REPORT_FILE_PATH, entityFromDB.getId(), entityFromDB.getReportFilePath());
            }
            if (StringUtils.hasText(entityFromDB.getAdditionalInvestmentFile())){
                delFundFileInOss(ADDITIONAL_INVESTMENT_FILE, entityFromDB.getId(), entityFromDB.getAdditionalInvestmentFile());
            }
            if (StringUtils.hasText(entityFromDB.getConstitutionFile())){
                delFundFileInOss(CONSTITUTION_FILE, entityFromDB.getId(), entityFromDB.getConstitutionFile());
            }
            if (StringUtils.hasText(entityFromDB.getApplicationForm())){
                delFundFileInOss(APPLICATION_FORM, entityFromDB.getId(), entityFromDB.getApplicationForm());
            }
        }, executor);
        logService.saveLog(OperateEntityTypeEnum.FUND.getMessage(), request.getId(), OperateTypeEnum.DELETE.getMessage(), entityFromDB.getName());
        return CommonResponse.success(request.getId());
    }

    @Override
    public void exportFundsCsv(FundsQueryRequest request, HttpServletResponse response) throws IOException {

        List<FundsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_FUNDS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, FundsExportDTO.class);
    }

    @Override
    public List<FundsExportDTO> exportFundsXml(FundsQueryRequest request) {
        return queryExportData(request);
    }


    //    ---------------------------------------------------------------------------------------------------
    private FundsEntity getFundEntity(QueryByIdRequest request) {
        FundsEntity fundsEntity = fundsMapper.selectOne(
            Wrappers.<FundsEntity>query().lambda().eq(FundsEntity::getId, request.getId()).eq(FundsEntity::getDelFlag,
                                                                                              Boolean.FALSE));
        if (ObjectUtil.isNull(fundsEntity)){
            FundsErrorEnum.FUND_NOT_EXIST.throwException();
        }
        return fundsEntity;
    }

    private List<FundsEntity> queryFundsEntities(FundsQueryRequest request) {
        return  fundsMapper.selectListByRequest(request);
    }
    private FundsEntity buildFundEntity(MultipartFile imFilePath, MultipartFile subImFilePath, MultipartFile introduceFilePath, MultipartFile eoiFilePath, MultipartFile reportFilePath, MultipartFile additionalInvestmentFile, MultipartFile constitutionFile, MultipartFile applicationForm, MultipartFile applicationFormTwo, MultipartFile applicationFormThree, MultipartFile applicationFormFour, MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree, MultipartFile coverFour, MultipartFile coverCn, MultipartFile coverCnTwo, MultipartFile coverCnThree, MultipartFile coverCnFour, FundCreateRequest request) {
        FundsEntity fundsEntity = BeanUtil.copyProperties(request, FundsEntity.class);
        for (int i = 0; i < GET_LIST.size(); i++) {
            String str = GET_LIST.get(i).apply(fundsEntity);
            if (CharSequenceUtil.isNotBlank(str)) {
                SET_LIST.get(i).accept(fundsEntity, str.substring(str.lastIndexOf("/") + 1));

            }
        }
        fundsEntity.setName(request.getName());
        fundsEntity.setNameCN(request.getNameCN());
        fundsEntity.setFundStatus(request.getFundStatus());
        fundsEntity.setLanguage(request.getLanguage());
        fundsEntity.setDescription(request.getDescription());
        fundsEntity.setDescriptionCN(request.getDescriptionCN());
        fundsEntity.setPopular(request.getPopular());
        fundsEntity.setStateId(request.getStateId());
        fundsEntity.setStateCn(request.getStateCn());
        fundsEntity.setStateEn(request.getStateEn());
        String format = "yyyy-MM-dd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        if (StringUtils.hasText(request.getSettlementDate())) {
            try {
                Date settlementDate = sdf.parse(request.getSettlementDate());
                fundsEntity.setSettlementDate(settlementDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Settlement date"});
            }
        }
        if (StringUtils.hasText(request.getInterestStartsDate())) {
            try {
                Date interestStartDate = sdf.parse(request.getInterestStartsDate());
                fundsEntity.setInterestStartsDate(interestStartDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Interest start date"});
            }
        }
        if (StringUtils.hasText(request.getEndDate())) {
            try {
                Date endDate = sdf.parse(request.getEndDate());
                fundsEntity.setEndDate(endDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"End date"});
            }
        }
        if (StringUtils.hasText(request.getSubImDate())) {
            try {
                Date subImDate = sdf.parse(request.getSubImDate());
                fundsEntity.setSubImDate(subImDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Sub iM date"});
            }
        }
        if (StringUtils.hasText(request.getDeedDate())) {
            try {
                Date deedDate = sdf.parse(request.getDeedDate());
                fundsEntity.setDeedDate(deedDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"deed date"});
            }
        }
        if (CharSequenceUtil.isNotBlank(request.getExtendStartDate())
                && DATE_PATTERN.matcher(request.getExtendStartDate()).matches()) {
            fundsEntity.setExtendStartDate(DateUtil.parseDate(request.getExtendStartDate()));
        }
        if (CharSequenceUtil.isNotBlank(request.getDefaultStartDate())
                && DATE_PATTERN.matcher(request.getDefaultStartDate()).matches()) {
            fundsEntity.setDefaultStartDate(DateUtil.parseDate(request.getDefaultStartDate()));
        }
        fundsEntity.setAmount(request.getAmount());
        fundsEntity.setCurrency(request.getCurrency());
        fundsEntity.setCurrencyCN(request.getCurrencyCN());
        fundsEntity.setFundType(request.getFundType());
        fundsEntity.setFundTypeCN(request.getFundTypeCN());
        fundsEntity.setInvestmentType(request.getInvestmentType());
        fundsEntity.setInvestmentTypeCN(request.getInvestmentTypeCN());
        fundsEntity.setProductType(request.getProductType());
        fundsEntity.setProductTypeCN(request.getProductTypeCN());
        fundsEntity.setPurchaseMinAmount(request.getPurchaseMinAmount());
        fundsEntity.setInvestmentCycle(request.getInvestmentCycle());
        fundsEntity.setInvestmentCycleCN(request.getInvestmentCycleCN());
        fundsEntity.setFixNetReturn(request.getFixNetReturn());
        fundsEntity.setFixNetReturnCN(request.getFixNetReturnCN());
        fundsEntity.setFloatNetReturn(request.getFloatNetReturn());
        fundsEntity.setFloatNetReturnCN(request.getFloatNetReturnCN());
        fundsEntity.setApplicationFeeRate(request.getApplicationFeeRate());
        fundsEntity.setApplicationFeeRateCN(request.getApplicationFeeRateCN());
        fundsEntity.setManagementFeeRate(request.getManagementFeeRate());
        fundsEntity.setManagementFeeRateCN(request.getManagementFeeRateCN());
        if (ObjectUtil.isNotNull(imFilePath)){
            fundsEntity.setImFilePath(storageProcessor.generateUploadFileName(imFilePath.getOriginalFilename()));
        }else {
            fundsEntity.setImFilePath(Optional.ofNullable(request.getUpdateImFilePath()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(subImFilePath)){
            fundsEntity.setSubImFilePath(storageProcessor.generateUploadFileName(subImFilePath.getOriginalFilename()));
        }else {
            fundsEntity.setSubImFilePath(Optional.ofNullable(request.getUpdateSubImFilePath()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(introduceFilePath)){
            fundsEntity.setIntroduceFilePath(storageProcessor.generateUploadFileName(
                introduceFilePath.getOriginalFilename()));
        }else {
            fundsEntity.setIntroduceFilePath(Optional.ofNullable(request.getUpdateIntroduceFilePath()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(eoiFilePath)){
            fundsEntity.setEoiFilePath(storageProcessor.generateUploadFileName(eoiFilePath.getOriginalFilename()));
        }else {
            fundsEntity.setEoiFilePath(Optional.ofNullable(request.getUpdateEoiFilePath()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(reportFilePath)){
            fundsEntity.setReportFilePath(storageProcessor.generateUploadFileName(reportFilePath.getOriginalFilename()));
        }else {
            fundsEntity.setReportFilePath(Optional.ofNullable(request.getUpdateReportFilePath()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(additionalInvestmentFile)){
            fundsEntity.setAdditionalInvestmentFile(storageProcessor.generateUploadFileName(
                additionalInvestmentFile.getOriginalFilename()));
        }else {
            fundsEntity.setAdditionalInvestmentFile(Optional.ofNullable(request.getUpdateAdditionalInvestmentFile()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(constitutionFile)){
            fundsEntity.setConstitutionFile(storageProcessor.generateUploadFileName(
                constitutionFile.getOriginalFilename()));
        }else {
            fundsEntity.setConstitutionFile(Optional.ofNullable(request.getUpdateConstitutionFile()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(applicationForm)){
            fundsEntity.setApplicationForm(storageProcessor.generateUploadFileName(
                applicationForm.getOriginalFilename()));
        }else {
            fundsEntity.setApplicationForm(Optional.ofNullable(request.getUpdateApplicationForm()).map(s -> s.substring(s.lastIndexOf("/") + 1)).orElse(null));
        }
        if (ObjectUtil.isNotNull(applicationFormTwo)){
            fundsEntity.setApplicationFormTwo(storageProcessor.generateUploadFileName(
                    applicationFormTwo.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(applicationFormThree)){
            fundsEntity.setApplicationFormThree(storageProcessor.generateUploadFileName(
                    applicationFormThree.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(applicationFormFour)){
            fundsEntity.setApplicationFormFour(storageProcessor.generateUploadFileName(
                    applicationFormFour.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(cover)){
            fundsEntity.setCover(storageProcessor.generateUploadFileName(
                    cover.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverTwo)){
            fundsEntity.setCoverTwo(storageProcessor.generateUploadFileName(
                  coverTwo.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverThree)){
            fundsEntity.setCoverThree(storageProcessor.generateUploadFileName(
                    coverThree.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverFour)){
            fundsEntity.setCoverFour(storageProcessor.generateUploadFileName(
                    coverFour.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverCn)){
            fundsEntity.setCoverCn(storageProcessor.generateUploadFileName(
                    coverCn.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverCnTwo)){
            fundsEntity.setCoverCnTwo(storageProcessor.generateUploadFileName(
                    coverCnTwo.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverCnThree)){
            fundsEntity.setCoverCnThree(storageProcessor.generateUploadFileName(
                    coverCnThree.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(coverCnFour)){
            fundsEntity.setCoverCnFour(storageProcessor.generateUploadFileName(
                    coverCnFour.getOriginalFilename()));
        }

        fundsEntity.setNetReturnA(request.getNetReturnA());
        fundsEntity.setNetReturnACN(request.getNetReturnACN());
        fundsEntity.setNetReturnB(request.getNetReturnB());
        fundsEntity.setNetReturnBCN(request.getNetReturnBCN());
        fundsEntity.setCashDividedCycle(request.getCashDividedCycle());
        fundsEntity.setCashDividedCycleCN(request.getCashDividedCycleCN());
        fundsEntity.setPerformanceFeeRate(request.getPerformanceFeeRate());
        fundsEntity.setPerformanceFeeRateCN(request.getPerformanceFeeRateCN());
        fundsEntity.setInvestmentStrategy(request.getInvestmentStrategy());
        fundsEntity.setInvestmentStrategyCN(request.getInvestmentStrategyCN());
        fundsEntity.setNatureYearlyReturn(request.getNatureYearlyReturn());
        fundsEntity.setNatureYearlyReturnCN(request.getNatureYearlyReturnCN());
        fundsEntity.setValueYearlyReturn(request.getValueYearlyReturn());
        fundsEntity.setValueYearlyReturnCN(request.getValueYearlyReturnCN());
        fundsEntity.setSubscriptionFeeRate(request.getSubscriptionFeeRate());
        fundsEntity.setSubscriptionFeeRateCN(request.getSubscriptionFeeRateCN());
        fundsEntity.setBFundCategory(request.getBfundCategory());
        fundsEntity.setBYearlyReturnRate(request.getByearlyReturnRate());
        fundsEntity.setBProjectDurationMonth(request.getBprojectDurationMonth());
        fundsEntity.setBDelayedGrowthRate(request.getBdelayedGrowthRate());
        fundsEntity.setFullySubscription(request.getFullySubscription());
        fundsEntity.setDisplayOrder(request.getDisplayOrder());
        fundsEntity.setTransId(request.getTrans());
        Date now = new Date();
        fundsEntity.setCreatedAt(now);
        fundsEntity.setUpdatedAt(now);
        return fundsEntity;
    }

    // batch store fund files in Oss

    private void batchStoreFundFiles(MultipartFile imFilePath, MultipartFile subImFilePath, MultipartFile introduceFilePath,
                                     MultipartFile eoiFilePath, MultipartFile reportFilePath,
                                     MultipartFile additionalInvestmentFile, MultipartFile constitutionFile,
                                     MultipartFile applicationForm, MultipartFile applicationFormTwo, MultipartFile applicationFormThree, MultipartFile applicationFormFour, MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree, MultipartFile coverFour, MultipartFile coverCn, MultipartFile coverCnTwo, MultipartFile coverCnThree, MultipartFile coverCnFour, FundsEntity fundsEntity) {
        List<String> fileType = Arrays.asList("Im file path", "Sub im file path", "Introduce file path", "Eoi file path",
                                              "Report file path", "Additional investment file", "Constitution file",
                                              "Application form", "cover", "coverCn");
        int index = 0;
        try {
            if (ObjectUtil.isNotNull(imFilePath)) {
                index = 0;
                storageProcessor.store(imFilePath.getInputStream(), FUND, IM_FILE_PATH, fundsEntity.getId().toString(), fundsEntity.getImFilePath());
            }
            if (ObjectUtil.isNotNull(subImFilePath)){
                index = 1;
                storageProcessor.store(subImFilePath.getInputStream(), FUND, SUB_IM_FILE_PATH, fundsEntity.getId().toString(), fundsEntity.getSubImFilePath());
            }
            if (ObjectUtil.isNotNull(introduceFilePath)){
                index = 2;
                storageProcessor.store(introduceFilePath.getInputStream(), FUND, INTRODUCE_FILE_PATH, fundsEntity.getId().toString(), fundsEntity.getIntroduceFilePath());
            }
            if (ObjectUtil.isNotNull(eoiFilePath)){
                index = 3;
                storageProcessor.store(eoiFilePath.getInputStream(), FUND, EOI_FILE_PATH, fundsEntity.getId().toString(), fundsEntity.getEoiFilePath());
            }
            if (ObjectUtil.isNotNull(reportFilePath)){
                index = 4;
                storageProcessor.store(reportFilePath.getInputStream(), FUND, REPORT_FILE_PATH, fundsEntity.getId().toString(), fundsEntity.getReportFilePath());
            }
            if (ObjectUtil.isNotNull(additionalInvestmentFile)){
                index = 5;
                storageProcessor.store(additionalInvestmentFile.getInputStream(), FUND, ADDITIONAL_INVESTMENT_FILE, fundsEntity.getId().toString(), fundsEntity.getAdditionalInvestmentFile());
            }
            if (ObjectUtil.isNotNull(constitutionFile)){
                index = 6;
                storageProcessor.store(constitutionFile.getInputStream(), FUND, CONSTITUTION_FILE, fundsEntity.getId().toString(), fundsEntity.getConstitutionFile());
            }
            if (ObjectUtil.isNotNull(applicationForm)){
                index = 7;
                storageProcessor.store(applicationForm.getInputStream(), FUND, APPLICATION_FORM, fundsEntity.getId().toString(), fundsEntity.getApplicationForm());
            }
            if (ObjectUtil.isNotNull(cover)){
                index = 8;
                storageProcessor.store(cover.getInputStream(), FUND, COVER, fundsEntity.getId().toString(), fundsEntity.getCover());
            }
            if (ObjectUtil.isNotNull(coverCn)){
                index = 9;
                storageProcessor.store(coverCn.getInputStream(), FUND, COVER_CN, fundsEntity.getId().toString(), fundsEntity.getCoverCn());
            }
            if (ObjectUtil.isNotNull(applicationFormTwo)){
                index = 10;
                storageProcessor.store(applicationFormTwo.getInputStream(), FUND, APPLICATION_FORM, fundsEntity.getId().toString(), fundsEntity.getApplicationFormTwo());
            }
            if (ObjectUtil.isNotNull(applicationFormThree)){
                index = 11;
                storageProcessor.store(applicationFormThree.getInputStream(), FUND, APPLICATION_FORM, fundsEntity.getId().toString(), fundsEntity.getApplicationFormThree());
            }
            if (ObjectUtil.isNotNull(applicationFormFour)){
                index = 12;
                storageProcessor.store(applicationFormFour.getInputStream(), FUND, APPLICATION_FORM, fundsEntity.getId().toString(), fundsEntity.getApplicationFormFour());
            }
            if (ObjectUtil.isNotNull(coverTwo)){
                index = 13;
                storageProcessor.store(coverTwo.getInputStream(), FUND, COVER, fundsEntity.getId().toString(), fundsEntity.getCoverTwo());
            }
            if (ObjectUtil.isNotNull(coverThree)){
                index = 14;
                storageProcessor.store(coverThree.getInputStream(), FUND, COVER, fundsEntity.getId().toString(), fundsEntity.getCoverThree());
            }
            if (ObjectUtil.isNotNull(coverFour)){
                index = 15;
                storageProcessor.store(coverFour.getInputStream(), FUND, COVER, fundsEntity.getId().toString(), fundsEntity.getCoverFour());
            }
            if (ObjectUtil.isNotNull(coverCnTwo)){
                index = 16;
                storageProcessor.store(coverCnTwo.getInputStream(), FUND, COVER_CN, fundsEntity.getId().toString(), fundsEntity.getCoverCnTwo());
            }
            if (ObjectUtil.isNotNull(coverCnThree)){
                index = 17;
                storageProcessor.store(coverCnThree.getInputStream(), FUND, COVER_CN, fundsEntity.getId().toString(), fundsEntity.getCoverCnThree());
            }
            if (ObjectUtil.isNotNull(coverCnFour)){
                index = 18;
                storageProcessor.store(coverCnFour.getInputStream(), FUND, COVER_CN, fundsEntity.getId().toString(), fundsEntity.getCoverCnFour());
            }
        } catch (IOException e){
            int finalIndex = index;
            CompletableFuture.runAsync(()->{
            // 上传失败时，把同fund下的其他上传成功文件删除
            for (int i = finalIndex; i >= 0; i--){
                switch (i){
                    case 0:
                        delFundFileInOss(IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getImFilePath());
                        break;
                    case 1:
                        delFundFileInOss(SUB_IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getSubImFilePath());
                        break;
                    case 2:
                        delFundFileInOss(INTRODUCE_FILE_PATH, fundsEntity.getId(), fundsEntity.getIntroduceFilePath());
                        break;
                    case 3:
                        delFundFileInOss(EOI_FILE_PATH, fundsEntity.getId(), fundsEntity.getEoiFilePath());
                        break;
                    case 4:
                        delFundFileInOss(REPORT_FILE_PATH, fundsEntity.getId(), fundsEntity.getReportFilePath());
                        break;
                    case 5:
                        delFundFileInOss(ADDITIONAL_INVESTMENT_FILE, fundsEntity.getId(), fundsEntity.getAdditionalInvestmentFile());
                        break;
                    case 6:
                        delFundFileInOss(CONSTITUTION_FILE, fundsEntity.getId(), fundsEntity.getConstitutionFile());
                        break;
                    case 7:
                        delFundFileInOss(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationForm());
                        break;
                    case 8:
                        delFundFileInOss(COVER, fundsEntity.getId(), fundsEntity.getCover());
                        break;
                    case 9:
                        delFundFileInOss(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCn());
                        break;
                    case 10:
                        delFundFileInOss(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationFormTwo());
                        break;
                    case 13:
                        delFundFileInOss(COVER, fundsEntity.getId(), fundsEntity.getCoverTwo());
                        break;
                    case 16:
                        delFundFileInOss(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnTwo());
                        break;
                    case 11:
                        delFundFileInOss(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationFormThree());
                        break;
                    case 14:
                        delFundFileInOss(COVER, fundsEntity.getId(), fundsEntity.getCoverThree());
                        break;
                    case 17:
                        delFundFileInOss(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnThree());
                        break;
                    case 12:
                        delFundFileInOss(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationFormFour());
                        break;
                    case 15:
                        delFundFileInOss(COVER, fundsEntity.getId(), fundsEntity.getCoverFour());
                        break;
                    case 18:
                        delFundFileInOss(COVER_CN, fundsEntity.getId(), fundsEntity.getCoverCnFour());
                        break;
                    default:
                        break;
                }
            }
            }, executor);
            e.printStackTrace();
            FundsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[]{fileType.get(index)});
        }
    }
    /**
     * delete other files in same fund in oss when having uploading exception
     * @param fileType
     * @param fundId
     * @param fileName
     */
    private void delFundFileInOss(String fileType, Long fundId, String fileName) {
        if (StringUtils.hasText(fileName)) {
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(FUND, fileType, fundId.toString())).append(fileName).toString());
            } catch (IOException delE) {
                log.error("=====fund/{}/{}delete Oss failed=====", fileType, fundId);
            }
        }
    }

    private List<FundsExportDTO> queryExportData(FundsQueryRequest request) {
        List<FundsEntity> fundsEntities = queryFundsEntities(request);
        List<FundsExportDTO> exportDTOS = fundsEntities.stream().map((FundsEntity fundsEntity)->{
            FundsExportDTO dto = new FundsExportDTO(fundsEntity);
            if (StringUtils.hasText(fundsEntity.getImFilePath())){
                dto.setImFilePath(getFundFileFullPath(IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getImFilePath()));
            }
            if (StringUtils.hasText(fundsEntity.getIntroduceFilePath())){
                dto.setIntroduceFilePath(getFundFileFullPath(INTRODUCE_FILE_PATH, fundsEntity.getId(), fundsEntity.getIntroduceFilePath()));
            }
            if (StringUtils.hasText(fundsEntity.getEoiFilePath())){
                dto.setEoiFilePath(getFundFileFullPath(EOI_FILE_PATH, fundsEntity.getId(), fundsEntity.getEoiFilePath()));
            }
            if (StringUtils.hasText(fundsEntity.getReportFilePath())){
                dto.setReportFilePath(getFundFileFullPath(REPORT_FILE_PATH, fundsEntity.getId(), fundsEntity.getReportFilePath()));
            }
            if (StringUtils.hasText(fundsEntity.getAdditionalInvestmentFile())){
                dto.setAdditionalInvestmentFile(getFundFileFullPath(ADDITIONAL_INVESTMENT_FILE, fundsEntity.getId(),
                                                                    fundsEntity.getAdditionalInvestmentFile()));
            }
            if (StringUtils.hasText(fundsEntity.getConstitutionFile())){
                dto.setConstitutionFile(getFundFileFullPath(CONSTITUTION_FILE, fundsEntity.getId(), fundsEntity.getConstitutionFile()));
            }
            if (StringUtils.hasText(fundsEntity.getSubImFilePath())){
                dto.setSubImFilePath(getFundFileFullPath(SUB_IM_FILE_PATH, fundsEntity.getId(), fundsEntity.getSubImFilePath()));
            }
            if (StringUtils.hasText(fundsEntity.getApplicationForm())){
                dto.setApplicationForm(getFundFileFullPath(APPLICATION_FORM, fundsEntity.getId(), fundsEntity.getApplicationForm()));
            }
            return dto;
        }).collect(Collectors.toList());
        return exportDTOS;
    }
}
