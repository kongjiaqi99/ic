package com.ic.icadmin.api.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.ic.icadmin.api.dto.response.wealth.ApiCommissionResponse;
import com.ic.icadmin.api.service.IApiWealthClientService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.FinanceReference;
import com.ic.icadmin.entity.FinancingsEntity;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.mapper.FinanceReferenceMapper;
import com.ic.icadmin.mapper.FinancingsMapper;
import com.ic.icadmin.mapper.PurchasedFundsMapper;
import com.ic.icadmin.service.IFinancingsService;
import com.ic.icadmin.service.IPurchasedFundsService;
import com.ic.icadmin.share.enums.FundCategoryEnum;
import com.ic.icadmin.share.exception.CommonException;
import com.ic.icadmin.share.utils.AmountFormatUtil;
import com.ic.icadmin.share.utils.DateFormatUtil;
import com.ic.icadmin.share.utils.EnumUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 16:26
 **/
@Slf4j
@Service
public class ApiWealthClientServiceImpl implements IApiWealthClientService {

    @Autowired
    private PurchasedFundsMapper purchasedFundsMapper;

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private IFinancingsService financingsService;

    @Autowired
    private FinancingsMapper financingsMapper;

    @Autowired
    private IPurchasedFundsService purchasedFundsService;

    @Resource
    FinanceReferenceMapper referenceMapper;

    @Override
    public CommonResponse<List<ApiCommissionOverviewResponse>> queryCommissionOverview(ClientsEntity client) {
        List<ApiCommissionOverviewResponse> responses = new ArrayList<>();
        if (ObjectUtil.isNotNull(client.getUpperClientId()) && ObjectUtil.isNotNull(client.getLevel2UpperClientId())){
            // 3级用户直接返回空
            return CommonResponse.success(responses);
        }
        List<ClientsEntity> subClients = new ArrayList<>();
        List<ClientsEntity> subSubClients = new ArrayList<>();
        // 需要考虑自己做自己的upper client的情况
//        if (ObjectUtil.isNotNull(client.getUpperClientId())
//            && ObjectUtil.isNull(client.getLevel2UpperClientId()) && !client.getId().equals(client.getLevel2UpperClientId())){
            // 该用户是2级客户
            subSubClients = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda()
                                                   .eq(ClientsEntity::getLevel2UpperClientId, client.getId())
                                                   .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
            if (CollectionUtil.isEmpty(subSubClients)){
                return CommonResponse.success(responses);
            }

            List<FinancingsEntity> financingsEntities = financingsMapper.selectList(
                Wrappers.<FinancingsEntity>query().lambda().eq(FinancingsEntity::getClientId, client.getId()).eq(
                    FinancingsEntity::getDelFlag, Boolean.FALSE).orderByDesc(FinancingsEntity::getId));
            for (FinancingsEntity financing : financingsEntities){
                ApiCommissionOverviewResponse response = new ApiCommissionOverviewResponse();
                List<ApiCommissionResponse> commissionResponses = new ArrayList<>();
                List<FinanceReference> referenceList = referenceMapper.selectList(new LambdaQueryWrapper<FinanceReference>()
                        .eq(FinanceReference::getFinanceId, financing.getId())
                        .eq(FinanceReference::getClientId, client.getId()));
                // 3级用户购买的记录
                List<BizPurchasedFundsDTO> pfsLevel3 = purchasedFundsMapper.queryPurchasedFundsForFinancings(
                    subSubClients.stream().map(ClientsEntity::getId).collect(Collectors.toList()), financing.getFundId(),
                        referenceList.stream().map(FinanceReference::getEntityId).collect(Collectors.toList()));
                if (CollectionUtil.isEmpty(pfsLevel3)){
                    continue;
                }
                pfsLevel3.forEach(pfLevel3->{
                    pfLevel3.setCommissionRate(financing.getCommissionRate());
                });
                BigDecimal expectedCommission = BigDecimal.ZERO;
                BigDecimal monthlyCommission = BigDecimal.ZERO;
                LocalDate nextPaymentTime = null;
                for (BizPurchasedFundsDTO pfLevel3 : pfsLevel3) {
                    ApiCommissionResponse commissionResponse = new ApiCommissionResponse();
                    FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, pfLevel3.getBFundCategory());
                    commissionResponse.setCustomerName(pfLevel3.getClientName());
                    try {
                        commissionResponse.setStartTime(
                            DateUtil.format(purchasedFundsService.getStartReturnDay(pfLevel3), DatePattern.NORM_DATE_PATTERN));
                    } catch (CommonException ce){
                        log.error("客户端queryCommissionOverview===purchaseFunId={},exception:{}===", pfLevel3.getId(),
                                  ce.getErrorMessage());
                    }
                    commissionResponse.setTotalAmount(
                        AmountFormatUtil.formatThousandsSeparator(pfLevel3.getPurchaseAmount()));
                    try {
                        BigDecimal currentTotalReturn = purchasedFundsService.getCurrentTotalReturn(pfLevel3);
                        commissionResponse.setCustomerTotalIncome(AmountFormatUtil.formatThousandsSeparator(currentTotalReturn));
                        commissionResponse.setCommissionRate(pfLevel3.getCommissionRate());
                        Date now = new Date();
                        long currentDays = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(pfLevel3),now
                                                               , Boolean.TRUE) + 1L;
                        commissionResponse.setCommissionAmount(AmountFormatUtil.formatThousandsSeparator(pfLevel3.getPurchaseAmount().multiply(
                            pfLevel3.getCommissionRate()).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(currentDays)).setScale(2, RoundingMode.HALF_UP)));
                        commissionResponses.add(commissionResponse);
                        monthlyCommission = pfLevel3.getPurchaseAmount().multiply(
                            pfLevel3.getCommissionRate()).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(DateUtil.dayOfMonth(now))).setScale(2, RoundingMode.HALF_UP);
                    } catch (NullPointerException e){
                        log.error("用户端queryCommissionOverview===purchased fund Id={}, exception={}", pfLevel3.getId(), e);
                    }
                    try {
                        long days = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(pfLevel3),
                                                        purchasedFundsService.getEndDay(pfLevel3, fundEnum), Boolean.TRUE) + 1L;
                        expectedCommission = expectedCommission.add(
                            pfLevel3.getCommissionRate().multiply((pfLevel3.getPurchaseAmount().multiply(pfLevel3.getBYearlyReturnRate()))
                                                                      .divide(BigDecimal.valueOf(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), 60,
                                                                              RoundingMode.HALF_UP)).multiply(new BigDecimal(days)).setScale(2, RoundingMode.HALF_UP)
                                                                   );
                    } catch (Exception e){
                        log.error("客户端queryCommissionOverview===purchaseFunId={},exception:{}===", pfLevel3.getId(),
                                  e);
                    }
                    List<DividendHistoryResponse> afterNowDividends = dividendDayList(pfLevel3, fundEnum).stream().filter(
                        dividendTime -> dividendTime.getDividendDate().isAfter(LocalDate.now())).collect(
                        Collectors.toList());
                    LocalDate nextDividendDate = CollectionUtil.isEmpty(afterNowDividends)?
                        null : afterNowDividends.get(0).getDividendDate();
                    if (ObjectUtil.isNotNull(nextDividendDate)){
                        nextPaymentTime = nextDividendDate;
                    }
                }
                if (CollectionUtil.isNotEmpty(commissionResponses)) {
                    response.setFundName(pfsLevel3.get(0).getFundName());
                    response.setCommissionResponses(commissionResponses);
                    response.setExpectedCommission(AmountFormatUtil.formatThousandsSeparator(expectedCommission));
                    response.setMonthlyAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(monthlyCommission));
                    response.setNextPaymentTime(nextPaymentTime);
                    responses.add(response);
                }
            }
//        } else if ((ObjectUtil.isNull(client.getUpperClientId()) || client.getId().equals(client.getUpperClientId()))
//            && ObjectUtil.isNull(client.getLevel2UpperClientId())) {
//            List<BizPurchasedFundsDTO> purchasedFunds = purchasedFundsMapper.queryPurchasedFundsForClientAPI(client.getId());
//            if (CollectionUtil.isEmpty(purchasedFunds)){
//                return CommonResponse.success(responses);
//            }
//            // 该用户是1级客户
//            // 查询其下2级客户
//            subClients = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda().eq(ClientsEntity::getUpperClientId, client.getId()).isNull(ClientsEntity::getLevel2UpperClientId).eq(
//                ClientsEntity::getDelFlag, Boolean.FALSE));
//            // 查询其下3级客户
//            subSubClients = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda().eq(ClientsEntity::getUpperClientId, client.getId()).isNotNull(ClientsEntity::getLevel2UpperClientId).eq(
//                ClientsEntity::getDelFlag, Boolean.FALSE));
//            if (CollectionUtil.isEmpty(subSubClients) && CollectionUtil.isEmpty(subClients)) {
//                return CommonResponse.success(responses);
//            }
//            for (BizPurchasedFundsDTO pfNowClient : purchasedFunds){
//                ApiCommissionOverviewResponse response = new ApiCommissionOverviewResponse();
//                List<ApiCommissionResponse> commissionResponses = new ArrayList<>();
//                //查询financing中的commission rate
//                try {
//                    FinancingsEntity financingsEntity = financingsMapper.selectOne(Wrappers.<FinancingsEntity>query().lambda()
//                                                                                       .eq(FinancingsEntity::getClientId, client.getId())
//                                                                                       .eq(FinancingsEntity::getFundId, pfNowClient.getFundId())
//                                                                                       .eq(FinancingsEntity::getDelFlag, Boolean.FALSE));
//                    if (ObjectUtil.isNotNull(financingsEntity) && ObjectUtil.isNotNull(financingsEntity.getCommissionRate())){
//                        pfNowClient.setCommissionRate(financingsEntity.getCommissionRate());
//                    }
//                } catch (Exception e){
//                    log.error("用户端queryCommissionOverview===ClientId={}, FundId={}查出多个financing===", pfNowClient.getClientId(), pfNowClient.getFundId());
//                }
//                // 查询每个2级下的3级用户，并求和
//                for (ClientsEntity subClient : subClients){
//                    List<ClientsEntity> subSubClientOfCurrentSubClient = subSubClients.stream().filter(
//                        subSubClient -> subSubClient.getLevel2UpperClientId().equals(subClient.getId())).collect(
//                        Collectors.toList());
//                    if (CollectionUtil.isEmpty(subSubClientOfCurrentSubClient)){
//                        subSubClientOfCurrentSubClient.add(subClient);
//                    }
//                    // 3级用户购买的记录
//                    List<BizPurchasedFundsDTO> pfsLevel3 = purchasedFundsMapper.queryPurchasedFundsForFinancings(
//                        subSubClientOfCurrentSubClient.stream().map(ClientsEntity::getId).collect(Collectors.toList()), pfNowClient.getFundId());
//                    if (CollectionUtil.isEmpty(pfsLevel3)){
//                        continue;
//                    }
//                    pfsLevel3.forEach(pfLevel3->{
//                        pfLevel3.setCommissionRate(pfNowClient.getCommissionRate());
//                    });
//                    Date earliestStartTime = new Date();
//                    LocalDate nextPaymentTime = null;
//                    BigDecimal totalAmount = BigDecimal.ZERO;
//                    BigDecimal customerTotalIncome = BigDecimal.ZERO;
//                    BigDecimal customerMonthlyIncome = BigDecimal.ZERO;
//                    BigDecimal commissionAmount = BigDecimal.ZERO;
//
//                    BigDecimal monthlyAccumulatedCommission = BigDecimal.ZERO;
//                    BigDecimal expectedCommission = BigDecimal.ZERO;
//                    for (BizPurchasedFundsDTO pfLevel3 : pfsLevel3) {
//                        FundCategoryEnum fundEnum = EnumUtil.getByCode(FundCategoryEnum.class, pfLevel3.getBFundCategory());
//                        try {
//                            Date startTime = purchasedFundsService.getStartReturnDay(pfLevel3);
//                        if (DateUtil.compare(startTime, earliestStartTime) < 0){
//                            earliestStartTime = startTime;
//                        }
//                            List<DividendHistoryResponse> afterNowDividends = dividendDayList(pfLevel3, fundEnum).stream().filter(
//                                dividendTime -> dividendTime.getDividendDate().isAfter(LocalDate.now())).collect(
//                                Collectors.toList());
//                            LocalDate nextDividendDate = CollectionUtil.isEmpty(afterNowDividends)?
//                                null : afterNowDividends.get(0).getDividendDate();
//                            if (ObjectUtil.isNotNull(nextDividendDate)){
//                                nextPaymentTime = nextDividendDate;
//                            }
//                        } catch (Exception e){
//                            log.error("客户端queryCommissionOverview===purchaseFunId={},exception:{}===", pfLevel3.getId(), e);
//                        }
//
//                        totalAmount = totalAmount.add(pfLevel3.getPurchaseAmount());
//                        BigDecimal totalIncome = purchasedFundsService.getCurrentTotalReturn(pfLevel3);
//                        customerTotalIncome = customerTotalIncome.add(totalIncome);
//                        BigDecimal monthReturn = purchasedFundsService.getCurrentMonthReturn(pfLevel3);
//                        customerMonthlyIncome = customerMonthlyIncome.add(monthReturn);
//                        try {
//                            Date now = new Date();
//                            long currentDays = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(pfLevel3),now, Boolean.TRUE) + 1L;
//                            commissionAmount =
//                                commissionAmount.add(pfLevel3.getPurchaseAmount().multiply(
//                                    pfLevel3.getCommissionRate()).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(currentDays)).setScale(2, RoundingMode.HALF_UP));
//                        } catch (NullPointerException e){
//                            log.error("用户端queryCommissionOverview===purchased fund Id={}, exception={}", pfLevel3.getId(), e);
//                        }
//                        try {
//                            long days = DateFormatUtil.betweenDay(purchasedFundsService.getStartReturnDay(pfLevel3),
//                                                            purchasedFundsService.getEndDay(pfLevel3, fundEnum), Boolean.TRUE) + 1L;
//                            expectedCommission = expectedCommission.add(
//                                pfLevel3.getCommissionRate().multiply((pfLevel3.getPurchaseAmount().multiply(pfLevel3.getBYearlyReturnRate()))
//                                                                          .divide(BigDecimal.valueOf(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), 60,
//                                                                                  RoundingMode.HALF_UP)).multiply(new BigDecimal(days)).setScale(2, RoundingMode.HALF_UP)
//                                                                       );
//                        } catch (Exception e){
//                        log.error("客户端queryCommissionOverview===purchaseFunId={},exception:{}===", pfLevel3.getId(), e);
//                    }
//                    Date now = new Date();
//                    monthlyAccumulatedCommission = monthlyAccumulatedCommission.add(pfLevel3.getPurchaseAmount().multiply(
//                        pfLevel3.getCommissionRate()).divide(new BigDecimal(purchasedFundsService.getLengthOfThisYear(pfLevel3.getUnitCertificateDate())), RoundingMode.CEILING).multiply(new BigDecimal(DateUtil.dayOfMonth(now))).setScale(2, RoundingMode.HALF_UP));
//                    }
//                    ApiCommissionResponse commissionResponse = new ApiCommissionResponse();
//                    commissionResponse.setCustomerName(subClient.getName());
//                    commissionResponse.setStartTime(DateUtil.format(earliestStartTime, DatePattern.NORM_DATE_PATTERN));
//                    commissionResponse.setTotalAmountBigDecimal(totalAmount);
//                    commissionResponse.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(totalAmount));
//                    commissionResponse.setCustomerTotalIncomeBigDecimal(customerTotalIncome);
//                    commissionResponse.setCustomerTotalIncome(AmountFormatUtil.formatThousandsSeparator(customerTotalIncome));
//                    commissionResponse.setCommissionRate(pfNowClient.getCommissionRate());
//                    commissionResponse.setCommissionAmountBigDecimal(commissionAmount);
//                    commissionResponse.setCommissionAmount(AmountFormatUtil.formatThousandsSeparator(commissionAmount));
//                    commissionResponse.setCustomerCurrentMonthIncome(customerMonthlyIncome);
//                    commissionResponse.setExpectedCommission(expectedCommission);
//                    try {
//                        commissionResponse.setMonthlyAccumulatedCommission(monthlyAccumulatedCommission);
//                    } catch (NullPointerException e){
//                        log.error("用户端queryCommissionOverview===purchased fund Id={}, exception={}", pfNowClient.getId(), e);
//                    }
//                    commissionResponse.setNextPaymentTime(nextPaymentTime);
//                    commissionResponses.add(commissionResponse);
//                }
//                if (CollectionUtil.isNotEmpty(commissionResponses)) {
//                    response.setFundName(pfNowClient.getFundName());
//                    response.setCommissionResponses(commissionResponses);
//                    response.setExpectedCommission(AmountFormatUtil.formatThousandsSeparator(
//                        commissionResponses.stream().map(ApiCommissionResponse::getExpectedCommission).reduce(BigDecimal.ZERO, BigDecimal::add)));
//                    try {
//                        response.setMonthlyAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(
//                            commissionResponses.stream().map(ApiCommissionResponse::getMonthlyAccumulatedCommission).reduce(BigDecimal.ZERO, BigDecimal::add)));
//                    } catch (NullPointerException e) {
//                        log.error("用户端queryCommissionOverview===purchased fund Id={}, exception={}", pfNowClient.getId(), e);
//                    }
//                    List<ApiCommissionResponse> apiCommissionResponses = commissionResponses.stream().sorted(Comparator.comparing(ApiCommissionResponse::getNextPaymentTime)).collect(Collectors.toList());
//                    if (CollectionUtil.isNotEmpty(apiCommissionResponses)) {
//                        response.setNextPaymentTime(apiCommissionResponses.get(0).getNextPaymentTime());
//                    }
//                    responses.add(response);
//                }
//            }
//        }
        return CommonResponse.success(responses);
    }

//    ----------------------------------------------------------

    private List<DividendHistoryResponse> dividendDayList(BizPurchasedFundsDTO pf,
                                                          FundCategoryEnum fundCategory) {
        List<DividendHistoryResponse> dividendDays = null;
        // calculate dividend history
        Date endDay = purchasedFundsService.getEndDay(pf, fundCategory);
        switch (fundCategory) {
            case POOL:
                dividendDays = purchasedFundsService.dividendDates(pf, pf.getUnitCertificateDate(), endDay);
                break;
            case DIRECT:
                if (ObjectUtils.isNotNull(pf.getTransactionDate())) {
                    dividendDays = purchasedFundsService.dividendDates(pf, purchasedFundsService.getStartReturnDay(pf), endDay);
                }
                break;
        }
        return dividendDays;
    }
}
