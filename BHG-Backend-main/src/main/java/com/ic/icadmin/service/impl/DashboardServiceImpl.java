package com.ic.icadmin.service.impl;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.request.DashboardInvestmentRequest;
import com.ic.icadmin.dto.response.DashboardClientsResponse;
import com.ic.icadmin.dto.response.DashboardInvestmentResponse;
import com.ic.icadmin.dto.response.DashboardNumResponse;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.EnquiriesEntity;
import com.ic.icadmin.entity.FundsEntity;
import com.ic.icadmin.entity.PurchasedFundsEntity;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.mapper.EnquiriesMapper;
import com.ic.icadmin.mapper.FundsMapper;
import com.ic.icadmin.mapper.PurchasedFundsMapper;
import com.ic.icadmin.service.IDashboardService;
import com.ic.icadmin.service.IPurchasedFundsService;
import com.ic.icadmin.share.constants.RedisConstants;
import com.ic.icadmin.share.enums.FundCategoryEnum;
import com.ic.icadmin.share.utils.DateFormatUtil;
import com.ic.icadmin.share.utils.EnumUtil;
import com.ic.icadmin.share.utils.RedisCache;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.function.BiConsumer;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:45
 **/
@Slf4j
@Service
public class DashboardServiceImpl implements IDashboardService {

    @Resource
    private ClientsMapper clientsMapper;

    @Resource
    private EnquiriesMapper enquiriesMapper;

    @Resource
    private PurchasedFundsMapper purchasedFundsMapper;

    @Resource
    private FundsMapper fundsMapper;

    @Resource
    private IPurchasedFundsService purchasedFundsService;

    @Resource
    private RedisCache redisCache;

    private static String DATE_FORMAT_PATTERN = "MMM dd, yyyy";

    @Override
    public CommonResponse<List<DashboardClientsResponse>> queryDashboardClients() {
        List<ClientsEntity> birthdayAlarms = clientsMapper.queryBirthdayComingOneMonth();
        List<DashboardClientsResponse> responseList = new ArrayList<>();
        birthdayAlarms.forEach(ba ->{
            responseList.add(new DashboardClientsResponse(ba.getId(), ba.getName(), DateUtil.format(ba.getBirth(),
                                                                                                    FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US)), ba.getEmail()));
        });
        return CommonResponse.success(responseList);
    }

    @Override
    public CommonResponse<DashboardNumResponse> queryDashboardNum() {
        Integer clientNum = clientsMapper.selectCount(new LambdaQueryWrapper<ClientsEntity>()
                .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        Integer enquiryNum = enquiriesMapper.selectCount(new LambdaQueryWrapper<EnquiriesEntity>()
                .eq(EnquiriesEntity::getDelFlag, Boolean.FALSE));
        return CommonResponse.success(new DashboardNumResponse(enquiryNum, clientNum));
    }

    @Override
    public CommonResponse<List<DashboardInvestmentResponse>> queryInvestment(DashboardInvestmentRequest request) {
        if (request == null) {
            request = new DashboardInvestmentRequest();
        }
        if (request.getStartDate() == null && request.getEndDate() == null) {
            LocalDate now = LocalDate.now();
            request.setEndDate(now.format(DatePattern.NORM_DATE_FORMATTER));
            request.setStartDate(now.minusMonths(5).format(DatePattern.NORM_DATE_FORMATTER));
        }
        String key = String.format(RedisConstants.DASHBOARD_INVESTMENT, request.getStartDate(), request.getEndDate());
        List<DashboardInvestmentResponse> result = redisCache.getCacheObject(key);
//        if (result == null) {
            result = Lists.newArrayList();
            DateTime startDate = DateUtil.parseDate(request.getStartDate());
            LocalDate endLocalDate = DateUtil.parseDate(request.getEndDate()).toLocalDateTime().toLocalDate();
            LocalDate tempLocalDate = DateUtil.beginOfMonth(startDate).toLocalDateTime().toLocalDate();
            while (tempLocalDate.isBefore(endLocalDate)) {
                DashboardInvestmentResponse response = new DashboardInvestmentResponse();
                response.setStartLocalDate(tempLocalDate);
                //下个月第一天
                tempLocalDate = tempLocalDate.plusMonths(1);
                if (tempLocalDate.isAfter(endLocalDate)) {
                    tempLocalDate = endLocalDate;
                }
                response.setEndLocalDate(tempLocalDate);
                Integer clientCount = clientsMapper.selectCount(new LambdaQueryWrapper<ClientsEntity>()
                        .le(ClientsEntity::getCreatedAt, tempLocalDate).eq(ClientsEntity::getDelFlag, Boolean.FALSE));
                response.setClientNum(clientCount);
                result.add(response);
            }
            int i = 0;
            int flag = 500;
            List<FundsEntity> fundList = fundsMapper.selectList(new LambdaQueryWrapper<>());
            Map<Long, FundsEntity> fundMap = fundList.stream().collect(Collectors.toMap(FundsEntity::getId, Function.identity()));
            while (flag == 500) {
                List<PurchasedFundsEntity> list = purchasedFundsMapper.selectList(new LambdaQueryWrapper<PurchasedFundsEntity>()
                        .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE).isNotNull(PurchasedFundsEntity::getPurchaseAmount)
                        .isNotNull(PurchasedFundsEntity::getUnitCertificateDate).orderByAsc(PurchasedFundsEntity::getTransactionDate)
                        .last(" limit 500 offset " + i * 500));
                for (PurchasedFundsEntity pf : list) {
                    FundsEntity fund = fundMap.get(pf.getFundId());
                    if (fund == null) {
                        continue;
                    }
                    FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, fund.getBFundCategory());
                    if (fundCategory == null) {
                        continue;
                    }
                    BizPurchasedFundsDTO bizPf = purchasedFundsService.getBizPf(pf, fund);
                    Date startReturnDay = null;
                    Date endDay = null;
                    try {
                        startReturnDay = purchasedFundsService.getStartReturnDay(bizPf);
                        endDay = purchasedFundsService.getEndDay(bizPf, fundCategory);
                    } catch (Exception e) {
                        log.info("queryInvestment date ranger error, pf:{}", JSONUtil.toJsonStr(pf));
                        continue;
                    }
                    if (startReturnDay == null || endDay == null) {
                        continue;
                    }
                    for (int j = 0; j < result.size(); j++) {
                        DashboardInvestmentResponse tempResponse = result.get(j);
                        LocalDate tempEndLocalDate = tempResponse.getEndLocalDate().minusDays(1);
                        DateTime tempEndDate = DateUtil.parseDate(tempEndLocalDate.format(DatePattern.NORM_DATE_FORMATTER));
                        DateTime tempStartDate = DateUtil.parseDate(tempResponse.getStartLocalDate().format(DatePattern.NORM_DATE_FORMATTER));
                        if (!startReturnDay.after(tempEndDate)) {
                            tempResponse.addTotalInvestment(pf.getPurchaseAmount());
                        }
                        if (endDay.after(startReturnDay)) {
                            BigDecimal aReturn = BigDecimal.ZERO;
                            if (j == 0) {
                                if (!endDay.after(tempEndDate)) {
                                    aReturn = purchasedFundsService.getTargetReturn(bizPf, fundCategory,
                                            purchasedFundsService.getLengthOfThisYear(bizPf.getUnitCertificateDate()));
                                } else if (!startReturnDay.after(tempEndDate)) {
                                    aReturn = purchasedFundsService.getCurrentTotalReturnByDate(bizPf, tempEndLocalDate);
                                }
                            }else if(Boolean.TRUE.equals(DateFormatUtil.checkTimesHasOverlap(tempStartDate, tempEndDate, startReturnDay, endDay))){
                                aReturn = purchasedFundsService.getMonthReturnByDate(bizPf, tempEndLocalDate);
                            }
                            if (aReturn.compareTo(BigDecimal.ZERO) > 0) {
                                setReturn(aReturn, j, result, DashboardInvestmentResponse::addInvestmentReturn);
                            }
                        }
                    }
                }
                flag = list.size();
                i++;
            }
            // 设置 0点过期
            redisCache.setCacheObject(key, result,
                    PurchasedFundsServiceImpl.getRemainSecondsOneDay(new Date()), TimeUnit.SECONDS);
//        }
        return CommonResponse.success(result);
    }

    private void setReturn(BigDecimal aReturn, int i, List<DashboardInvestmentResponse> result, BiConsumer<DashboardInvestmentResponse, BigDecimal> fun) {
        for (int j = i; j < result.size(); j++) {
            fun.accept(result.get(j), aReturn);
        }
    }
}
