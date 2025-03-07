package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.aspose.words.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.config.OssClientConfig;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizFinancingSubClientTotalReturn;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.financings.FinanceRefRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingCreateRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingUpdateRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingsQueryRequest;
import com.bhg.bhgadmin.dto.response.financings.*;
import com.bhg.bhgadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.entity.FinanceReference;
import com.bhg.bhgadmin.entity.FinancingsEntity;
import com.bhg.bhgadmin.entity.InvestmentEntities;
import com.bhg.bhgadmin.mapper.*;
import com.bhg.bhgadmin.service.*;
import com.bhg.bhgadmin.service.export.ExportService;
import com.bhg.bhgadmin.share.constants.CommonConstants;
import com.bhg.bhgadmin.share.enums.FundCategoryEnum;
import com.bhg.bhgadmin.share.enums.OperateEntityTypeEnum;
import com.bhg.bhgadmin.share.enums.OperateTypeEnum;
import com.bhg.bhgadmin.share.error.ClientsErrorEnum;
import com.bhg.bhgadmin.share.error.CommonErrorEnum;
import com.bhg.bhgadmin.share.error.FinancingsErrorEnum;
import com.bhg.bhgadmin.share.exception.CommonException;
import com.bhg.bhgadmin.share.utils.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:05
 **/
@Slf4j
@Service
public class FinancingsServiceImpl implements IFinancingsService {

    private static final String FINANCINGS = "financings";
    private static final String REFERRAL_AGREEMENT = "referral_agreement";

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private FundsMapper fundsMapper;

    @Autowired
    private FinancingsMapper financingsMapper;

    @Autowired
    private PurchasedFundsMapper purchasedFundsMapper;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private ExportService exportService;

    @Autowired
    private IPurchasedFundsService purchasedFundsService;

    @Resource
    private InvestmentEntitiesMapper entityMapper;
    @Resource
    private FinanceReferenceMapper referenceMapper;
    @Resource
    private FinanceReferenceService referenceService;
    @Resource
    private InvestmentEntitiesMapper getEntityMapper;
    @Value("${template.path:/root/files/unitCertificate}")
    private String templatePath;
    @Resource
    OperateLogService operateLogService;

    @Override
    public List<ClientsNameResponse> getClientsNames() {
        return clientsMapper.getClientsNames();
    }

    @Override
    public List<FundsNameResponse> getFundsNames() {
        return fundsMapper.getFundsNames();
    }

    @Override
    public List<FundsNameResponse> getFundsNamesCN() {
        return fundsMapper.getFundsNamesCN();
    }

    @Override
    public CommonResponse<PageInfo<FinancingsResponse>> queryFinancings(FinancingsQueryRequest request, int pageNum,
                                                                        int pageSize) {
        PageInfo<FinancingsResponse> responses =
            PageHelper.startPage(pageNum, pageSize)
        .doSelectPageInfo(()->financingsMapper.queryFinancingsResponses(request));
        for (FinancingsResponse r : responses.getList()) {
            r.setCreateAt(r.getCreateAtDate());
            // 该financing用户
            // 需要考虑自己做自己的upper client的情况
            InvestmentEntities entity = entityMapper.selectById(r.getEntityId());
            if (entity == null || entity.getDelFlag().equals(Boolean.TRUE)) {
                continue;
            }
            List<FinanceReference> refList = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>()
                    .eq(FinanceReference::getFinanceId, r.getId())
            );
            if (CollUtil.isEmpty(refList)) {
                continue;
            }
            // get subClientTotalReturns
            List<BizPurchasedFundsDTO> subSubClientPurchasedFunds = purchasedFundsMapper.queryPurchasedFundsForFinancings(
                    null, r.getFundId(),
                    refList.stream().map(FinanceReference::getEntityId).collect(Collectors.toList()));
            if (CollUtil.isEmpty(subSubClientPurchasedFunds)){
                r.setFinancingAmount(BigDecimal.ZERO);
                continue;
            }
            List<BizFinancingSubClientTotalReturn> subClientTotalReturns =
                calculateFinancingSubClientTotalReturn(r.getCommissionRate(), r.getBYearlyReturnRate(), refList, subSubClientPurchasedFunds, false);
            r.setFinancingAmount(subClientTotalReturns.stream().map(BizFinancingSubClientTotalReturn::getPurchasedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
        }
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<FinancingDetailResponse> queryFinancingById(QueryByIdRequest request) {
        FinancingDetailResponse response = financingsMapper.queryFinancingById(request.getId());
        if (ObjectUtil.isNull(response)){
            FinancingsErrorEnum.FINANCING_NOT_EXIST.throwException();
        }
        response.setCurrentTotalReturn(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP));
        response.setFinancingAmount(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP));
        response.setCreateAt(DateFormatUtil.getMHHmm(response.getCreateAtDate()));
        response.setUpdateAt(DateFormatUtil.getMHHmm(response.getUpdateAtDate()));
        if (ObjectUtil.isNull(response.getClientId())){
            FinancingsErrorEnum.MISSING_CLIENT_DATA.throwException();
        }
        InvestmentEntities entity = entityMapper.selectById(response.getEntityId());
        if (entity == null || entity.getDelFlag().equals(Boolean.TRUE)) {
            return CommonResponse.success(response);
        }
        List<FinanceReference> refList = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>()
                .eq(FinanceReference::getFinanceId, response.getId())
        );
        if (CollUtil.isEmpty(refList)) {
            return CommonResponse.success(response);
        }
        Set<Long> pidSet = refList.stream().map(FinanceReference::getParentId).collect(Collectors.toSet());
        Set<Long> clientIdSet = refList.stream().map(FinanceReference::getClientId).collect(Collectors.toSet());
        // get subClientTotalReturns
        List<BizPurchasedFundsDTO> subSubClientPurchasedFunds = purchasedFundsMapper.queryPurchasedFundsForFinancings(null,
                response.getFundId(), refList.stream().map(FinanceReference::getEntityId).collect(Collectors.toList()));
        if (CollUtil.isEmpty(subSubClientPurchasedFunds)) {
            return CommonResponse.success(response);
        }
        subSubClientPurchasedFunds.forEach(pf->{
            if (pidSet.contains(pf.getInvestmentEntityId())) {
                pf.setPurchaseAmount(BigDecimal.ZERO);
            }
            pf.setCommissionRate(response.getCommissionRate());
        });
        List<BizFinancingSubClientTotalReturn> subSubClientTotalReturns = calculateFinancingSubClientTotalReturn(
                subSubClientPurchasedFunds.get(0).getBYearlyReturnRate(), response.getBYearlyReturnRate(), refList,
                subSubClientPurchasedFunds, true);
        List<CurrentTotalReturnResponse> subClientsCurrentTotalReturnResponses = getCurrentTotalReturnResponses(
                subSubClientTotalReturns);
        response.setCurrentTotalReturn(subClientsCurrentTotalReturnResponses.stream().map(CurrentTotalReturnResponse::getCurrentTotalReturn).filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add).setScale(2, RoundingMode.HALF_UP));
        response.setFinancingAmount(subClientsCurrentTotalReturnResponses.stream().map(CurrentTotalReturnResponse::getPurchaseAmount).reduce(BigDecimal.ZERO, BigDecimal::add).setScale(2, RoundingMode.HALF_UP));
        if(CollUtil.isNotEmpty(subClientsCurrentTotalReturnResponses)){
            Map<Long, CurrentTotalReturnResponse> subIdMap = subClientsCurrentTotalReturnResponses.stream()
                    .collect(Collectors.toMap(CurrentTotalReturnResponse::getEntityId,
                        Function.identity(), (v1, v2) -> {
                            v1.setCurrentTotalReturn(v1.getCurrentTotalReturn().add(v2.getCurrentTotalReturn()));
                            v1.setPurchaseAmount(v1.getPurchaseAmount().add(v2.getPurchaseAmount()));
                            return v1;
                        }));
            Map<Long, List<CurrentTotalReturnResponse>> subPidMap = subIdMap.values().stream().collect(Collectors.groupingBy(CurrentTotalReturnResponse::getPid));
            List<CurrentTotalReturnResponse> currentTotalReturnResponses = subPidMap.get(0L);
            setSubChildren(currentTotalReturnResponses, subPidMap);
            response.setSubClientsCurrentTotalReturnResponses(currentTotalReturnResponses);
        }
        response.setCommissionHistoryResponses(getCommissionList(subSubClientPurchasedFunds, response.getGst()));
        response.setRefList(getRespList(refList));
        return CommonResponse.success(response);
    }

    private void setSubChildren(List<CurrentTotalReturnResponse> currentTotalReturnResponses, Map<Long, List<CurrentTotalReturnResponse>> subPidMap) {
        if (CollUtil.isNotEmpty(currentTotalReturnResponses)) {
            for (CurrentTotalReturnResponse sub : currentTotalReturnResponses) {
                List<CurrentTotalReturnResponse> tempSub = subPidMap.get(sub.getEntityId());
                if (CollUtil.isNotEmpty(tempSub)) {
                    sub.setPurchaseAmount(tempSub.stream().map(CurrentTotalReturnResponse::getPurchaseAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
                    sub.setCurrentTotalReturn(tempSub.stream().map(CurrentTotalReturnResponse::getCurrentTotalReturn).reduce(BigDecimal.ZERO, BigDecimal::add));
                }
                sub.setSubSubClientTotalReturn(tempSub);
                setSubChildren(tempSub, subPidMap);
            }
        }
    }

    private List<FinanceRefResponse> getRespList(List<FinanceReference> refList) {
        List<FinanceRefResponse> refResponseList = BeanUtil.copyToList(refList, FinanceRefResponse.class);
        Map<Long, String> clientNameMap = clientsMapper.selectList(new LambdaQueryWrapper<ClientsEntity>()
                        .in(ClientsEntity::getId, refList.stream().map(FinanceReference::getClientId).collect(Collectors.toSet())))
                .stream().collect(Collectors.toMap(ClientsEntity::getId, ClientsEntity::getName));
        Map<Long, String> entityNameMap = entityMapper.selectList(new LambdaQueryWrapper<InvestmentEntities>()
                        .in(InvestmentEntities::getId, refList.stream().map(FinanceReference::getEntityId).collect(Collectors.toSet())))
                .stream().collect(Collectors.toMap(InvestmentEntities::getId, InvestmentEntities::getEntityName));
        refResponseList.forEach(r->{
            r.setClientName(clientNameMap.get(r.getClientId()));
            r.setEntityName(entityNameMap.get(r.getEntityId()));
        });
        return refResponseList;
    }

    private List<CurrentTotalReturnResponse> getCurrentTotalReturnResponses(List<BizFinancingSubClientTotalReturn> subSubClientTotalReturns) {
        List<CurrentTotalReturnResponse> result = Lists.newArrayList();
        for (BizFinancingSubClientTotalReturn subSubClientReturn : subSubClientTotalReturns) {
            CurrentTotalReturnResponse currentTotalReturn = new CurrentTotalReturnResponse();
            currentTotalReturn.setEntityId(subSubClientReturn.getEntityId());
            currentTotalReturn.setLevel(subSubClientReturn.getLevel());
            currentTotalReturn.setEntityName(subSubClientReturn.getEntityName());
            currentTotalReturn.setClientId(subSubClientReturn.getClientId());
            currentTotalReturn.setClientName(subSubClientReturn.getClientName());
            currentTotalReturn.setPid(subSubClientReturn.getPid());
            currentTotalReturn.setPurchaseAmount(subSubClientReturn.getPurchasedAmount());
            currentTotalReturn.setCurrentTotalReturn(subSubClientReturn.getCommissionTotalReturn());
            result.add(currentTotalReturn);
        }
        return result;
    }

    private List<DividendHistoryResponse> getCommissionList(List<BizPurchasedFundsDTO> purchasedFunds, Boolean gst) {
        Map<String, BigDecimal> data = Maps.newHashMap();
        for (BizPurchasedFundsDTO purchasedFund : purchasedFunds) {
            if (purchasedFund.getCommissionRate() == null || purchasedFund.getCommissionRate().compareTo(BigDecimal.ZERO) <= 0) {
                continue;
            }
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, purchasedFund.getBFundCategory());
            Date startDay = purchasedFundsService.getStartReturnDay(purchasedFund);
            Date endDay = purchasedFundsService.getEndDay(purchasedFund, fundCategory);
            DateTime firstMouth = DateUtil.offsetMonth(DateUtil.beginOfMonth(startDay), 1);
            long monthCount = DateUtil.betweenMonth(firstMouth, endDay, Boolean.FALSE);
            List<LocalDate> dateList = Lists.newArrayList();
            LocalDate startLocalDate = startDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate firstMouthDate = firstMouth.toLocalDateTime().toLocalDate();
            dateList.add(startLocalDate);
            dateList.add(firstMouthDate);
            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            for (int i = 1; i <= monthCount; i++) {
                dateList.add(firstMouthDate.plusMonths(i));
            }
            for (int i = 1; i < dateList.size(); i++) {
                BigDecimal monthReturn = purchasedFund.getPurchaseAmount().multiply(purchasedFund.getCommissionRate())
                        .divide(BigDecimal.valueOf(purchasedFundsService.getLengthOfThisYear(purchasedFund.getUnitCertificateDate())), 30, RoundingMode.HALF_UP)
                        .multiply(BigDecimal.valueOf(dateList.get(i).toEpochDay() - dateList.get(i - 1).toEpochDay()))
                        .setScale(2, RoundingMode.HALF_UP);
                putReturn(data, dateList.get(i), monthReturn, sdf);
            }
            if (DateUtil.dayOfMonth(endDay) != 1){
                LocalDate endShowLocalDate = purchasedFundsService.offsetWeekendDays(DateUtil.offsetMonth(DateUtil.beginOfMonth(endDay), 1)).toLocalDateTime().toLocalDate();
                LocalDate lastStartDate = dateList.get(dateList.size() - 1);
                LocalDate endLocalDate = endDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                BigDecimal monthReturn = purchasedFund.getPurchaseAmount().multiply(purchasedFund.getCommissionRate())
                        .divide(BigDecimal.valueOf(purchasedFundsService.getLengthOfThisYear(purchasedFund.getUnitCertificateDate())), 30, RoundingMode.HALF_UP)
                        .multiply(BigDecimal.valueOf(endLocalDate.toEpochDay() + 1  - lastStartDate.toEpochDay()))
                        .setScale(2, RoundingMode.HALF_UP);
                putReturn(data, endShowLocalDate, monthReturn, sdf);
            }
        }
        Calendar instance = Calendar.getInstance();
        instance.add(Calendar.DATE, 1);
        LocalDate offsetWeekend = purchasedFundsService.offsetWeekendDays(DateTime.of(instance.getTime())).toLocalDateTime().toLocalDate();
        return data.entrySet().stream().map(d -> {
            DateTime of = DateTime.of(d.getKey(), DatePattern.NORM_DATE_PATTERN);
            LocalDate localDate = purchasedFundsService.offsetWeekendDays(of).toLocalDateTime().toLocalDate();
            BigDecimal decimal = d.getValue();
            if (Boolean.TRUE.equals(gst)) {
                decimal = (decimal.multiply(BigDecimal.valueOf(1.1)));
            }
            return new DividendHistoryResponse(localDate, decimal);
        }).sorted(Comparator.comparing(DividendHistoryResponse::getDividendDate)).filter(di -> !di.getDividendDate().isAfter(offsetWeekend)).collect(Collectors.toList());
    }

    private void putReturn(Map<String, BigDecimal> data, LocalDate endShowLocalDate, BigDecimal monthReturn, DateTimeFormatter sdf) {
        String tempDate = endShowLocalDate.format(sdf);
        BigDecimal tempNum = data.getOrDefault(tempDate, BigDecimal.ZERO);
        tempNum = tempNum.add(monthReturn);
        data.put(tempDate, tempNum);
    }

    // 获取Subclient cuerrentTotalReturn 表
    @Override
    public List<CurrentTotalReturnResponse> getSubClientCurrentTotalReturnResponses(List<ClientsEntity> subClients,
                                                                            List<ClientsEntity> subSubClients,
                                                                            List<BizFinancingSubClientTotalReturn> subSubClientTotalReturns) {
        List<CurrentTotalReturnResponse> subClientsCurrentTotalReturnResponses = new ArrayList<>();
        // 只有3级用户，没有2级用户 || 只有2级用户，没有3级用户
        if (CollectionUtil.isEmpty(subClients) || CollectionUtil.isEmpty(subSubClients)){
            // 该用户下没有二级用户情况
            if (CollectionUtil.isNotEmpty(subSubClientTotalReturns)) {
                for (BizFinancingSubClientTotalReturn subSubClientReturn : subSubClientTotalReturns) {
                    CurrentTotalReturnResponse currentTotalReturn = new CurrentTotalReturnResponse();
                    currentTotalReturn.setEntityId(subSubClientReturn.getClientId());
                    currentTotalReturn.setEntityName(subSubClientReturn.getEntityName());
                    currentTotalReturn.setPurchaseAmount(subSubClientReturn.getPurchasedAmount());
                    currentTotalReturn.setCurrentTotalReturn(subSubClientReturn.getCommissionTotalReturn());
                    subClientsCurrentTotalReturnResponses.add(currentTotalReturn);
                }
            } else {
                // 所有3级用户没有购买记录
                for (ClientsEntity subSubClient : CollectionUtil.isEmpty(subSubClients) ? subClients : subSubClients){
                    CurrentTotalReturnResponse currentTotalReturn = new CurrentTotalReturnResponse();
                    currentTotalReturn.setEntityId(subSubClient.getId());
                    currentTotalReturn.setEntityName(subSubClient.getName());
                    currentTotalReturn.setPurchaseAmount(BigDecimal.ZERO);
                    currentTotalReturn.setCurrentTotalReturn(BigDecimal.ZERO);
                    subClientsCurrentTotalReturnResponses.add(currentTotalReturn);
                }
            }
        } else {
//            subSubClients.removeAll(subClients);
            for (ClientsEntity subClient : subClients){
                // 该2级用户下的3级客户
                List<ClientsEntity> subSubClientOfThisLevel2Client = subSubClients.stream().filter(
                    subSub -> subSub.getLevel2UpperClientId().equals(subClient.getId())).collect(Collectors.toList());
                if (CollectionUtil.isNotEmpty(subSubClientOfThisLevel2Client)){
                    // 该2级用户下的3级客户的购买记录
                    List<BizFinancingSubClientTotalReturn> subSubReturnOfThisLevel2Client = subSubClientTotalReturns.stream().filter(
                        subSubReturn -> subSubClientOfThisLevel2Client.stream().map(ClientsEntity::getId).collect(
                            Collectors.toList()).contains(subSubReturn.getClientId())).collect(Collectors.toList());
                    List<CurrentTotalReturnResponse> subSubClientsCurrentTotalReturnResponses = new ArrayList<>();
                    for (BizFinancingSubClientTotalReturn subSubReturn : subSubReturnOfThisLevel2Client){
                        CurrentTotalReturnResponse subSubClientReturn = new CurrentTotalReturnResponse();
                        subSubClientReturn.setEntityId(subSubReturn.getClientId());
                        subSubClientReturn.setEntityName(subSubReturn.getEntityName());
                        subSubClientReturn.setPurchaseAmount(subSubReturn.getPurchasedAmount());
                        subSubClientReturn.setCurrentTotalReturn(subSubReturn.getCommissionTotalReturn());
                        subSubClientsCurrentTotalReturnResponses.add(subSubClientReturn);
                    }
                    CurrentTotalReturnResponse currentTotalReturn = new CurrentTotalReturnResponse();
                    currentTotalReturn.setEntityId(subClient.getId());
                    currentTotalReturn.setEntityName(subClient.getName());
                    currentTotalReturn.setPurchaseAmount(subSubClientsCurrentTotalReturnResponses.stream().map(CurrentTotalReturnResponse::getPurchaseAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
                    currentTotalReturn.setCurrentTotalReturn(subSubClientsCurrentTotalReturnResponses.stream().map(CurrentTotalReturnResponse::getCurrentTotalReturn).reduce(BigDecimal.ZERO, BigDecimal::add));
                    currentTotalReturn.setSubSubClientTotalReturn(subSubClientsCurrentTotalReturnResponses);
                    subClientsCurrentTotalReturnResponses.add(currentTotalReturn);
                } else {
                    // 该2级用户下没有3级客户
                    BizFinancingSubClientTotalReturn financingSubClientTotalReturn =
                        subSubClientTotalReturns.stream().filter(
                        subSubReturn -> subSubReturn.getClientId().equals(subClient.getId())).collect(
                        Collectors.toList()).get(0);
                    CurrentTotalReturnResponse currentTotalReturn = new CurrentTotalReturnResponse();
                    currentTotalReturn.setEntityId(financingSubClientTotalReturn.getClientId());
                    currentTotalReturn.setEntityName(financingSubClientTotalReturn.getEntityName());
                    currentTotalReturn.setCurrentTotalReturn(financingSubClientTotalReturn.getCommissionTotalReturn());
                    currentTotalReturn.setPurchaseAmount(financingSubClientTotalReturn.getPurchasedAmount());
                    subClientsCurrentTotalReturnResponses.add(currentTotalReturn);
                }
            }
        }
        return subClientsCurrentTotalReturnResponses;
    }

    /**
     * calculate sub clients' total return in Financing
     *
     * @param commissionRate
     * @param bYearlyReturnRate
     * @param referenceList
     * @param subClientPurchasedFunds
     * @param tax
     * @return
     */
    @Override
    public List<BizFinancingSubClientTotalReturn> calculateFinancingSubClientTotalReturn(BigDecimal commissionRate,
                                                                                         BigDecimal bYearlyReturnRate, List<FinanceReference> referenceList, List<BizPurchasedFundsDTO> subClientPurchasedFunds, boolean tax) {
        List<BizFinancingSubClientTotalReturn> financingSubClientTotalReturns = new ArrayList<>(subClientPurchasedFunds.size());
        List<InvestmentEntities> entityList = entityMapper.selectList(new LambdaQueryWrapper<InvestmentEntities>().in(InvestmentEntities::getId,
                referenceList.stream().map(FinanceReference::getEntityId).collect(Collectors.toList())));
        List<ClientsEntity> clientList = clientsMapper.selectList(new LambdaQueryWrapper<ClientsEntity>().in(ClientsEntity::getId,
                referenceList.stream().map(FinanceReference::getClientId).collect(Collectors.toList())));
        Map<Long, FinanceReference> refMap = referenceList.stream().collect(Collectors.toMap(FinanceReference::getEntityId, Function.identity(), (v1, v2) -> v1));
        Map<Long, InvestmentEntities> entityMap = entityList.stream().collect(Collectors.toMap(InvestmentEntities::getId, Function.identity()));
        Map<Long, ClientsEntity> clientMap = clientList.stream().collect(Collectors.toMap(ClientsEntity::getId, Function.identity()));
        for (BizPurchasedFundsDTO p : subClientPurchasedFunds){
            BizPurchasedFundsDTO dto = subClientPurchasedFunds.stream().filter(bizP -> bizP.getId().equals(p.getId())).collect(Collectors.toList()).get(0);
            BigDecimal currentTotalReturn = BigDecimal.ZERO;
            try {
                currentTotalReturn = purchasedFundsService.getCurrentTotalReturn(dto);
            } catch (CommonException e){
                log.error("calculateFinancingSubClientTotalReturn===getCurrentTotalReturn Exception, purchasedFund " +
                              "Id:{}, exception:{}", p.getId(), e);
            }
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
//            BigDecimal targetReturn = purchasedFundsService.getTargetReturn(dto, fundCategory, DateUtil.lengthOfYear(DateUtil.year(new Date())));
//            BigDecimal currentMonthReturn = purchasedFundsService.getCurrentMonthReturn(dto);

            BizFinancingSubClientTotalReturn financingSubClientTotalReturn = new BizFinancingSubClientTotalReturn();
            InvestmentEntities entity = entityMap.get(p.getInvestmentEntityId());
            ClientsEntity clientsEntity = clientMap.get(p.getClientId());

            FinanceReference financeReference = refMap.get(p.getInvestmentEntityId());
            if (financeReference != null) {
                financingSubClientTotalReturn.setLevel(financeReference.getLevel());
                financingSubClientTotalReturn.setPid(financeReference.getParentId());
            }
            financingSubClientTotalReturn.setPurchasedDate(p.getUnitCertificateDate());
            financingSubClientTotalReturn.setPurchasedAmount(p.getPurchaseAmount());
            financingSubClientTotalReturn.setCurrentTotalReturn(currentTotalReturn);
            financingSubClientTotalReturn.setCommissionRate(commissionRate);
            try {
                long currentDays = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(p),
                                                       new Date(), Boolean.TRUE) + 1L;
                long targetDays = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(p),
                                                      purchasedFundsService.getEndDay(p, fundCategory), Boolean.TRUE) + 1L;
                financingSubClientTotalReturn.setCommissionTotalReturn(p.getPurchaseAmount().multiply(
                    commissionRate).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(p.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(currentDays)).setScale(2,
                                                                                                                                                                                                       RoundingMode.HALF_UP));
                financingSubClientTotalReturn.setCommissionTargetReturn(p.getPurchaseAmount().multiply(
                    commissionRate).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(p.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(targetDays)).setScale(2,
                                                                                                                                                                                                      RoundingMode.HALF_UP));
                //            financingSubClientTotalReturn.setCommissionMonthReturn(currentMonthReturn.multiply(
                //                commissionRate.divide(bYearlyReturnRate)
                //                                                                                              ).setScale(2, RoundingMode.HALF_UP));
                if (clientsEntity != null) {
                    financingSubClientTotalReturn.setClientName(clientsEntity.getName());

                }
                if (entity != null) {
                    if (tax && Boolean.TRUE.equals(entity.getWithheldTax())) {
                        financingSubClientTotalReturn.setCommissionTotalReturn(financingSubClientTotalReturn
                                .getCommissionTotalReturn().multiply(BigDecimal.valueOf(0.9)));
                        financingSubClientTotalReturn.setCommissionTargetReturn(financingSubClientTotalReturn
                                .getCommissionTargetReturn().multiply(BigDecimal.valueOf(0.9)));
                    }
                    financingSubClientTotalReturn.setClientId(entity.getClientId());
                    financingSubClientTotalReturn.setEntityName(entity.getEntityName());
                    financingSubClientTotalReturn.setEntityId(entity.getId());
                }

            } catch (CommonException e){
                log.error("calculateFinancingSubClientTotalReturn===getCurrentTotalReturn Exception, purchasedFund " +
                              "Id:{}, exception:{}", p.getId(), e);
            }
            financingSubClientTotalReturns.add(financingSubClientTotalReturn);
        }
        return financingSubClientTotalReturns;
    }

    @Override
    public void exportPdf(String date, Long id, HttpServletResponse response) throws Exception {
        FinancingDetailResponse financing = financingsMapper.queryFinancingById(id);
        ClientsEntity client = clientsMapper.selectOne(
                Wrappers.<ClientsEntity>query().lambda()
                        .eq(ClientsEntity::getId, financing.getClientId())
                        .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        DateTime parse = DateUtil.parse(date, "yyyy-MM-dd");
        DateTime startDate = DateUtil.beginOfMonth(parse);
        LocalDate searchStartDate = startDate.toLocalDateTime().toLocalDate();
        LocalDate searchEndDate = DateUtil.offsetMonth(DateUtil.beginOfMonth(startDate), 1).toLocalDateTime().toLocalDate();
        // 需要考虑自己做自己的upper client的情况
        List<FinanceReference> refList = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>()
                .eq(FinanceReference::getFinanceId, id)
        );
        List<BizPurchasedFundsDTO> subSubClientPurchasedFunds = purchasedFundsMapper.queryPurchasedFundsForFinancings(null, financing.getFundId(),
                refList.stream().map(FinanceReference::getEntityId).collect(Collectors.toList()));
        Month month = searchStartDate.getMonth();
        List<String[]> tableList = Lists.newArrayList();
        BigDecimal total = BigDecimal.ZERO;
        BigDecimal gstTotal = BigDecimal.ZERO;
        //BCDIOF-MAY-Marketing Fee	1	$404.27	$404.27	$40.43
        for (BizPurchasedFundsDTO purchasedFund : subSubClientPurchasedFunds) {
            LocalDate startDay = purchasedFundsService.getStartReturnDay(purchasedFund).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, purchasedFund.getBFundCategory());
            LocalDate endDay = purchasedFundsService.getEndDay(purchasedFund, fundCategory).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate finalStart = startDay;
            LocalDate finalEnd = endDay;
            if (startDay.isBefore(searchStartDate)) {
                finalStart = searchStartDate;
            }
            if (endDay.isAfter(searchEndDate)) {
                finalEnd = searchEndDate;
            }
            if (finalStart.isBefore(finalEnd) && financing.getCommissionRate() != null) {
                BigDecimal monthReturn = purchasedFund.getPurchaseAmount().multiply(financing.getCommissionRate())
                        .divide(BigDecimal.valueOf(purchasedFundsService.getLengthOfThisYear(purchasedFund.getUnitCertificateDate())), 30, RoundingMode.HALF_UP)
                        .multiply(BigDecimal.valueOf(finalEnd.toEpochDay() - finalStart.toEpochDay()))
                        .setScale(2, RoundingMode.HALF_UP);
                BigDecimal gst = BigDecimal.ZERO;
                String beaverId = StrUtil.isNotBlank(purchasedFund.getUcNo()) ? purchasedFund.getUcNo() : "";
                if (ObjectUtil.equals(financing.getGst(), Boolean.TRUE)) {
                    gst = monthReturn.divide(BigDecimal.TEN, 30, RoundingMode.HALF_UP);
                    gstTotal = gstTotal.add(gst);
                }
                total = total.add(monthReturn);
                tableList.add(new String[]{beaverId + "-" + month + "-Marketing Fee", "1", "$" + AmountFormatUtil.formatThousandsSeparator(monthReturn),
                        "$" + AmountFormatUtil.formatThousandsSeparator(monthReturn), "$" + AmountFormatUtil.formatThousandsSeparator(gst)});
            }
        }
        BigDecimal totalAdd = total.add(gstTotal);
        tableList.add(new String[]{"", "", "", "SUBTOTAL:", total.compareTo(BigDecimal.ZERO)>0?("$" + AmountFormatUtil.formatThousandsSeparator(total)):"$0"});
        tableList.add(new String[]{"", "", "", "GST:", gstTotal.compareTo(BigDecimal.ZERO)>0?("$" + AmountFormatUtil.formatThousandsSeparator(gstTotal)):"$0"});
        tableList.add(new String[]{"", "", "", "Total:", totalAdd.compareTo(BigDecimal.ZERO)>0?("$" + AmountFormatUtil.formatThousandsSeparator(totalAdd)):"$0"});
        DateTimeFormatter sdf = DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.US);
        DateTimeFormatter sdfs = DateTimeFormatter.ofPattern("yyyyMMdd");
        File directory = new File("");
        String canonicalPath = directory.getCanonicalPath();
        String path = canonicalPath+"/src/main/resources/templates/unitCertificate/referral_invoice_template.docx";
//        Document document = new Document(path);
        Document document = new Document(templatePath+"/referral_invoice_template.docx");
        Range range = document.getRange();
        range.replace("${invoiceDateEn}", searchStartDate.format(sdf), new FindReplaceOptions());
        range.replace("${dueDate}", searchStartDate.plusDays(14).format(sdf), new FindReplaceOptions());
        range.replace("${INVOICE_DATE}", searchStartDate.format(sdfs), new FindReplaceOptions());
        range.replace("${clientName}", client.getName(), new FindReplaceOptions());
        range.replace("${clientAddress}", client.getCountryCode(), new FindReplaceOptions());
        range.replace("${accountName}", client.getAccountName(), new FindReplaceOptions());
        range.replace("${bsb}", client.getBsb(), new FindReplaceOptions());
        range.replace("${accountNo}", client.getAccountNumber(), new FindReplaceOptions());
        TableCollection tables = document.getFirstSection().getBody().getTables();
        for (Table table : tables) {
            Row firstRow = table.getFirstRow();
            String text = firstRow.getFirstCell().getFirstParagraph().getRuns().get(0).getText();
            log.info("第一个表头内容：{}", text);
            if (CharSequenceUtil.equals("DESCRIPTION", text)) {
                Row lastRow = table.getLastRow();
                table.removeChild(lastRow);
                for (String[] strings : tableList) {
                    Row row = (Row)lastRow.deepClone(true);
                    for (int i = 0; i < strings.length; i++) {
                        row.getCells().get(i).getFirstParagraph().getRuns().get(0).setText(strings[i]);
                    }
                    table.getRows().add(row);
                }
            }
        }
        AsposeWordsUtils.doc2pdf(document,"referral_invoice_"+date+".pdf", response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createFinancing(MultipartFile referralAgreement, FinancingCreateRequest request) {
        FinancingsEntity financingsEntity = buildFinancingsEntity(referralAgreement, request);
        int insert = financingsMapper.insert(financingsEntity);
        if (insert != 1){
            FinancingsErrorEnum.FINANCING_CREATE_FAIL.throwException();
        }
        if (ObjectUtil.isNotNull(referralAgreement)) {
            saveFileInOss(referralAgreement, financingsEntity);
        }
        List<FinanceReference> referenceList = BeanUtil.copyToList(request.getRefList(), FinanceReference.class);
        if (CollUtil.isNotEmpty(referenceList)) {
            referenceList.forEach(r->r.setFinanceId(financingsEntity.getId()));
            referenceService.saveBatch(referenceList);
            List<FinanceReference> childrenList = referenceList.stream().filter(r -> CollUtil.isNotEmpty(r.getChildren()))
                    .map(r -> {
                        r.getChildren().forEach(c -> c.setParentId(r.getId()).setFinanceId(financingsEntity.getId()));
                        return r.getChildren();
                    }).flatMap(Collection::stream).collect(Collectors.toList());
            referenceService.saveBatch(childrenList);
        }
        operateLogService.saveLog(OperateEntityTypeEnum.REFERRAL.getMessage(), financingsEntity.getId(), OperateTypeEnum.CREATE.getMessage(), financingsEntity.getClient());
        return CommonResponse.success(financingsEntity.getId());
    }

    @Override
    public CommonResponse<FinancingEditDetailResponse> queryFinancingByIdWhenEdit(QueryByIdRequest request) {
        FinancingEditDetailResponse response = financingsMapper.queryFinancingByIdWhenEdit(request.getId());
        List<FinanceReference> refList = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>().eq(FinanceReference::getFinanceId, response.getId()));
        response.setRefList(getRespList(refList));
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> updateFinancing(MultipartFile referralAgreement, FinancingUpdateRequest request) {
        FinancingsEntity entityFromDB = getFinancingEntity(request.getId());
        FinancingsEntity financingsEntity = buildFinancingsEntity(referralAgreement, request);
        financingsEntity.setId(request.getId());
        financingsEntity.setCreatedAt(null);

        int update = financingsMapper.update(null, Wrappers.<FinancingsEntity>update().lambda()
                                            .set(FinancingsEntity::getClientId, financingsEntity.getClientId())
                                            .set(FinancingsEntity::getFundId, financingsEntity.getFundId())
                                            .set(FinancingsEntity::getFinancingAmount, financingsEntity.getFinancingAmount())
                                            .set(FinancingsEntity::getCommissionRate, financingsEntity.getCommissionRate())
                                            .set(FinancingsEntity::getCommissionAmount, financingsEntity.getCommissionAmount())
                                            .set(FinancingsEntity::getCurrency, financingsEntity.getCurrency())
                                            .set(FinancingsEntity::getUpdatedAt, financingsEntity.getUpdatedAt())
                                            .set(FinancingsEntity::getReferralAgreement, financingsEntity.getReferralAgreement())
                                            .set(FinancingsEntity::getTargetAmount, financingsEntity.getTargetAmount())
                                            .set(FinancingsEntity::getTargetDate, financingsEntity.getTargetDate())
                                            .set(FinancingsEntity::getAchieveTarget, financingsEntity.getAchieveTarget())
                                            .set(FinancingsEntity::getGst, financingsEntity.getGst())
                                            .set(FinancingsEntity::getEntityId, financingsEntity.getEntityId())
                                            .eq(FinancingsEntity::getId, financingsEntity.getId()));
        if (update != 1){
            FinancingsErrorEnum.FINANCING_UPDATE_FAIL.throwException();
        }
        if (ObjectUtil.isNotNull(referralAgreement)) {
            saveFileInOss(referralAgreement, financingsEntity);
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        List<FinanceRefRequest> refRequestList = request.getRefList();
        if (CollUtil.isNotEmpty(refRequestList)) {
            refRequestList.forEach(r->r.setFinanceId(financingsEntity.getId()));
        }
        List<FinanceReference> insertList = Lists.newArrayList();
        List<FinanceReference> updateList = Lists.newArrayList();
        List<FinanceReference> financeReferences = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>().eq(FinanceReference::getFinanceId, request.getId()));
        Map<Long, FinanceReference> oldRefIdSet = financeReferences.stream().collect(Collectors.toMap(FinanceReference::getId, Function.identity()));
        List<FinanceReference> refList = BeanUtil.copyToList(refRequestList, FinanceReference.class);
        List<FinanceReference> childrenList = Lists.newArrayList();
        contrastRef(refList, oldRefIdSet, updateList, insertList, childrenList);
        List<FinanceReference> childrenInsertList = Lists.newArrayList();
        if (!insertList.isEmpty()) {
            referenceService.saveBatch(insertList);
            List<FinanceReference> tempChildrenList = insertList.stream().filter(r -> CollUtil.isNotEmpty(r.getChildren()))
                    .map(r -> {
                        r.getChildren().forEach(c -> c.setParentId(r.getId()).setFinanceId(financingsEntity.getId()));
                        return r.getChildren();
                    }).flatMap(Collection::stream).collect(Collectors.toList());
            childrenInsertList.addAll(tempChildrenList);
        }
        if (!childrenList.isEmpty()) {
            contrastRef(childrenList, oldRefIdSet, updateList, childrenInsertList, null);
            if (!updateList.isEmpty()) {
                referenceService.updateBatchById(updateList);
            }
            if (!childrenInsertList.isEmpty()) {
                referenceService.saveBatch(childrenInsertList);
            }
        }
        if (!oldRefIdSet.isEmpty()) {
            referenceService.removeByIds(oldRefIdSet.keySet());
        }
        operateLogService.saveUpdateLog(OperateEntityTypeEnum.REFERRAL.getMessage(), financingsEntity.getId(), financingsEntity, entityFromDB, "");
        return CommonResponse.success(request.getId());
    }

    private void contrastRef(List<FinanceReference> refList, Map<Long, FinanceReference> oldRefIdSet, List<FinanceReference> updateList, List<FinanceReference> insertList, List<FinanceReference> childrenList) {
        refList.forEach(r->{
            if (r.getId() != null && oldRefIdSet.containsKey(r.getId())) {
                FinanceReference remove = oldRefIdSet.remove(r.getId());
                if (!ObjectUtil.equals(remove.getEntityId(), r.getEntityId())
                        || !ObjectUtil.equals(remove.getClientId(), r.getClientId())
                        || !ObjectUtil.equals(remove.getParentId(), r.getParentId())) {
                    r.setCreatedAt(remove.getCreatedAt());
                    r.setUpdatedAt(new Date());
                    updateList.add(r);
                }
                if (childrenList != null && CollUtil.isNotEmpty(r.getChildren())) {
                    r.getChildren().forEach(c->c.setParentId(r.getId()).setFinanceId(r.getFinanceId()));
                    childrenList.addAll(r.getChildren());
                }
            } else {
                r.setId(null);
                insertList.add(r);
            }
        });
    }

    @Override
    public CommonResponse<Long> delFinancing(QueryByIdRequest request) {
        FinancingsEntity entityFromDB = getFinancingEntity(request.getId());
        int update = financingsMapper.update(null, Wrappers.<FinancingsEntity>update().lambda().set(
            FinancingsEntity::getDelFlag, Boolean.TRUE).set(FinancingsEntity::getUpdatedAt, new Date()).eq(
            FinancingsEntity::getId, request.getId()));
        if (update!=1){
            FinancingsErrorEnum.FINANCING_DELETE_FAIL.throwException();
        }
        if (StringUtils.hasText(entityFromDB.getReferralAgreement())) {
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        referenceService.remove(new LambdaQueryWrapper<FinanceReference>().eq(FinanceReference::getFinanceId, request.getId()));
        operateLogService.saveLog(OperateEntityTypeEnum.REFERRAL.getMessage(), request.getId(), OperateTypeEnum.DELETE.getMessage(), entityFromDB.getClient());
        return CommonResponse.success(request.getId());
    }

    @Override
    public void exportFinancingsCsv(FinancingsQueryRequest request, HttpServletResponse response) throws IOException {
        List<FinancingsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_FINANCINGS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, FinancingsExportDTO.class);
    }

    @Override
    public List<FinancingsExportDTO> exportFinancingsXml(FinancingsQueryRequest request) {
        return queryExportData(request);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> subClientDelete(QueryByIdRequest request) {
        ClientsEntity clientsEntity = clientsMapper.selectById(request.getId());
        if (ObjectUtil.isNull(clientsEntity)){
            ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
        }
        if (ObjectUtil.isNotNull(clientsEntity.getUpperClientId()) && ObjectUtil.isNotNull(clientsEntity.getLevel2UpperClientId())){
            // 3级用户
            clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                                .set(ClientsEntity::getUpperClientId, null)
                                .set(ClientsEntity::getLevel2UpperClientId, null)
                                .set(ClientsEntity::getUpdatedAt, new Date())
                                .eq(ClientsEntity::getId, request.getId()));
        } else if (ObjectUtil.isNotNull(clientsEntity.getUpperClientId()) && ObjectUtil.isNull(clientsEntity.getLevel2UpperClientId())){
            // 2级用户
            List<ClientsEntity> subSubClients = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda()
                                    .eq(ClientsEntity::getLevel2UpperClientId, request.getId())
                                    .eq(ClientsEntity::getUpperClientId, clientsEntity.getUpperClientId())
                                    .eq(ClientsEntity::getDelFlag, Boolean.FALSE)
                                    .orderByDesc(ClientsEntity::getId));
            // update upper client id = unll
            LambdaUpdateWrapper<ClientsEntity> updateWrapper = Wrappers.<ClientsEntity>update().lambda()
                .set(ClientsEntity::getUpperClientId, null)
                .set(ClientsEntity::getUpdatedAt, new Date());
            if (CollectionUtil.isEmpty(subSubClients)){
                updateWrapper.eq(ClientsEntity::getId, request.getId());
            } else {
                List<Long> updateIds = subSubClients.stream().map(ClientsEntity::getId).collect(Collectors.toList());
                updateIds.add(request.getId());
                updateWrapper.in(ClientsEntity::getId, updateIds);
            }
            clientsMapper.update(null, updateWrapper);
        } else {
            CommonErrorEnum.WRONG_DATA.throwException();
        }
        return CommonResponse.success(request.getId());
    }


    //    ----------------------------------------------------------------------------------------------

    private FinancingsEntity buildFinancingsEntity(MultipartFile referralAgreement, FinancingCreateRequest request) {
        FinancingsEntity financingsEntity = new FinancingsEntity();
        financingsEntity.setClientId(request.getClientId());
        financingsEntity.setFundId(request.getFundId());
        financingsEntity.setFinancingAmount(request.getFinancingAmount());
        financingsEntity.setCommissionRate(request.getCommissionRate());
        financingsEntity.setCommissionAmount(request.getCommissionAmount());
        financingsEntity.setCurrency(request.getCurrency());
        financingsEntity.setTargetAmount(request.getTargetAmount());
        financingsEntity.setGst(request.getGst());
        financingsEntity.setEntityId(request.getEntityId());
        String format = "yyyy-MM-dd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        if (StringUtils.hasText(request.getTargetDate())) {
            try {
                Date targetDate = sdf.parse(request.getTargetDate());
                financingsEntity.setTargetDate(targetDate);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Target date"});
            }
        }
        financingsEntity.setAchieveTarget(request.getAchieveTarget());
        if (ObjectUtil.isNotNull(referralAgreement)){
            financingsEntity.setReferralAgreement(storageProcessor.generateUploadFileName(
                referralAgreement.getOriginalFilename()));
        }
        Date now = new Date();
        financingsEntity.setCreatedAt(now);
        financingsEntity.setUpdatedAt(now);
        return financingsEntity;
    }
    private FinancingsEntity getFinancingEntity(Long id) {
        FinancingsEntity entityFromDB = financingsMapper.selectOne(
            Wrappers.<FinancingsEntity>query().lambda().eq(FinancingsEntity::getId, id).eq(
                FinancingsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            FinancingsErrorEnum.FINANCING_NOT_EXIST.throwException();
        }
        return entityFromDB;
    }

    private void saveFileInOss(MultipartFile referralAgreement, FinancingsEntity financingsEntity) {
        try {
            storageProcessor.store(referralAgreement.getInputStream(), FINANCINGS, REFERRAL_AGREEMENT,
                                   financingsEntity.getId().toString(), financingsEntity.getReferralAgreement()
                                  );
        } catch (IOException e) {
            e.printStackTrace();
            FinancingsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {REFERRAL_AGREEMENT});
        }
    }
    private void delFileInOss(FinancingsEntity entityFromDB) {
        if (StringUtils.hasText(entityFromDB.getReferralAgreement())){
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(FINANCINGS, REFERRAL_AGREEMENT,
                                                                entityFromDB.getId().toString())).append(
                    entityFromDB.getReferralAgreement()).toString());
            } catch (IOException delE) {
                log.error("====={}/{}/{}delete Oss failed=====", FINANCINGS, REFERRAL_AGREEMENT, entityFromDB.getId());
            }
        }
    }

    private String getFundFileFullPath(String fileType, Long fundId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(FINANCINGS, fileType, fundId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }

    private List<FinancingsExportDTO> queryExportData(FinancingsQueryRequest request) {
        List<FinancingsResponse> financingsEntities = financingsMapper.queryFinancingsResponses(request);
        List<FinancingsExportDTO> exportDTOS = financingsEntities.stream().map((FinancingsResponse f)->{
            FinancingsExportDTO dto = new FinancingsExportDTO(f);
//            dto.setReferralAgreement(getFundFileFullPath(REFERRAL_AGREEMENT, f.getId(), f.getReferralAgreement()));
            return dto;
        }).collect(Collectors.toList());
        return exportDTOS;
    }
}
