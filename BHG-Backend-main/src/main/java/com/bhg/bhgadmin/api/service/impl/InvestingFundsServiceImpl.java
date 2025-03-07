package com.bhg.bhgadmin.api.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.bhg.bhgadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiInvestmentDetailResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiMonthlyDetailResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.bhg.bhgadmin.api.service.IInvestingFundsService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import com.bhg.bhgadmin.entity.FundsEntity;
import com.bhg.bhgadmin.entity.PurchasedFundsEntity;
import com.bhg.bhgadmin.mapper.FundsMapper;
import com.bhg.bhgadmin.mapper.PurchasedFundsMapper;
import com.bhg.bhgadmin.service.IFundsService;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.share.enums.FundCategoryEnum;
import com.bhg.bhgadmin.share.enums.FundsStatusEnum;
import com.bhg.bhgadmin.share.exception.CommonException;
import com.bhg.bhgadmin.share.utils.AmountFormatUtil;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 14:34
 **/
@Slf4j
@Service
public class InvestingFundsServiceImpl implements IInvestingFundsService {

    private final static String UNIT_CERTI = "unit_certi";

    private final static String APPLICATION_FORM = "application_form";
    private final static String APPLICATION_FORM_SIGNED = "application_form(signed)";

    private final static String IM_FILE_PATH = "im_file_path";
    private final static String SUB_IM_FILE_PATH = "sub_im_file_path";
    private final static String INTRODUCE_FILE_PATH = "introduce_file_path";
    private final static String EOI_FILE_PATH = "eoi_file_path";
    private final static String REPORT_FILE_PATH = "report_file_path";
    private final static String ADDITIONAL_INVESTMENT_FILE = "additional_investment_file";
    private final static String CONSTITUTION_FILE = "constitution_file";

    @Autowired
    private PurchasedFundsMapper purchasedFundsMapper;

    @Autowired
    private FundsMapper fundsMapper;

    @Autowired
    private IPurchasedFundsService purchasedFundsService;

    @Autowired
    private IFundsService fundsService;

    @Override
    public CommonResponse<List<ApiInvestingFundsResponse>> queryInvestmentProject(Long loginUserId, OtherFundsQueryRequest request) {
        List<ApiInvestingFundsResponse> responses = new ArrayList<>();
        List<BizPurchasedFundsDTO> purchasedFunds = purchasedFundsMapper.queryPurchasedFundsForClientAPI(loginUserId);
        if (CollectionUtil.isEmpty(purchasedFunds)){
            return CommonResponse.success(responses);
        }
        if(request.getPurchasedId() != null){
            for(BizPurchasedFundsDTO bpf : purchasedFunds){
                if(bpf.getId().equals(request.getPurchasedId())){
                    purchasedFunds = new ArrayList<>();
                    purchasedFunds.add(bpf);
                }
            }
        }
        List<FundsEntity> fundsEntities = fundsMapper.selectList(Wrappers.<FundsEntity>query().lambda()
                .in(FundsEntity::getId, purchasedFunds.stream().map(
                        PurchasedFundsEntity::getFundId).collect(
                        Collectors.toList()))
                .eq(FundsEntity::getDelFlag, Boolean.FALSE)
                .eq(request != null && request.getFundCategory() != null,
                        FundsEntity::getBFundCategory, request.getFundCategory())
                .eq(request.getFundStatus() != null,
                        FundsEntity::getFundStatus, request.getFundStatus())
                .ne(request.getFundStatusNe() != null,
                        FundsEntity::getFundStatus, request.getFundStatusNe())
                .eq(request.getFundId() != null,
                        FundsEntity::getId, request.getFundId())
        );
        if (CollectionUtil.isEmpty(fundsEntities)){
            return CommonResponse.success(responses);
        }
        BigDecimal totalAmount = BigDecimal.ZERO;
        BigDecimal totalReturn = BigDecimal.ZERO;
        for (BizPurchasedFundsDTO pf : purchasedFunds){


            List<FundsEntity> collect = fundsEntities.stream().filter(f -> f.getId().equals(pf.getFundId())).collect(Collectors.toList());
            if (CollUtil.isEmpty(collect)){
                continue;
            }
            FundsEntity fund = collect.get(0);
            ApiInvestingFundsResponse fundsResponse = new ApiInvestingFundsResponse();
            fundsResponse.setBFundCategory(fund.getBFundCategory());
            fundsResponse.setFundId(pf.getFundId());
            fundsResponse.setFundName(fund.getName());
            fundsResponse.setFundStatus(EnumUtil.getByCode(FundsStatusEnum.class, fund.getFundStatus()));
            fundsResponse.setFundType(fund.getFundType());
            fundsResponse.setInvestmentType(fund.getInvestmentType());
            fundsResponse.setMinInvestmentAmount(fund.getPurchaseMinAmount());
            fundsResponse.setInvestmentCycle(fund.getInvestmentCycle());
            fundsResponse.setFixedNetReturn(fund.getFixNetReturn());
            fundsResponse.setCommissionCycle(fund.getCashDividedCycle());

            fundsResponse.setFundNameCn(fund.getNameCN());
            fundsResponse.setInvestmentTypeCn(fund.getInvestmentTypeCN());
            fundsResponse.setInvestmentCycleCn(fund.getInvestmentCycleCN());
            fundsResponse.setFundTypeCn(fund.getFundTypeCN());
            fundsResponse.setPurchasedId(pf.getId());
            LocalDate startDay = purchasedFundsService.getStartReturnDay(pf).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, pf.getBFundCategory());
            LocalDate endDay = purchasedFundsService.getEndDay(pf, fundCategory).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            Date startDate = Date.from(startDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date endDate = Date.from(endDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
            fundsResponse.setInterestStartsDate(startDate);
            fundsResponse.setInterestEndDate(endDate);
            if (StringUtils.hasText(pf.getApplicationFormSigned())){
                fundsResponse.setApplicationForm(purchasedFundsService.getPurchasedFundFileFullPath(APPLICATION_FORM_SIGNED,
                        pf.getId(),
                        pf.getApplicationFormSigned()));
            }
            if (StringUtils.hasText(pf.getUnitCerti())){
                fundsResponse.setUnitCertificate(purchasedFundsService.getPurchasedFundFileFullPath(UNIT_CERTI,
                        pf.getId(),
                        pf.getUnitCerti()));
            }
            if (StringUtils.hasText(fund.getImFilePath())){
                fundsResponse.setFundInformationIm(fundsService.getFundFileFullPath(IM_FILE_PATH, fund.getId(),
                        fund.getImFilePath()));
            }
            if (StringUtils.hasText(fund.getIntroduceFilePath())){
                fundsResponse.setFundIntroduction(fundsService.getFundFileFullPath(INTRODUCE_FILE_PATH, fund.getId(),
                        fund.getIntroduceFilePath()));
            }
            if (StringUtils.hasText(fund.getAdditionalInvestmentFile())){
                fundsResponse.setReinvestForm(fundsService.getFundFileFullPath(ADDITIONAL_INVESTMENT_FILE, fund.getId(),
                        fund.getAdditionalInvestmentFile()));
            }
            try {
                // assemble InvestmentDetail
                fundsResponse.setInvestmentDetail(assembleInvestmentDetail(pf, fundCategory));
                // assemble MonthlyDetail
                fundsResponse.setMonthlyDetail(assembleMonthlyDetail(pf, fundCategory));
                // assemble History Payment Record
                fundsResponse.setPaymentRecord(dividendDayList(pf, fundCategory).stream().filter(d -> d.getDividendDate().isBefore(LocalDate.now())).collect(
                        Collectors.toList()));
            } catch (CommonException e){
                e.printStackTrace();
            }
            totalAmount = totalAmount.add(pf.getPurchaseAmount());
            totalReturn = totalReturn.add(purchasedFundsService.getCurrentTotalReturn(pf));
            responses.add(fundsResponse);
        }
        ApiInvestingFundsResponse total = new ApiInvestingFundsResponse();
        total.setFundName("Total");
        ApiInvestmentDetailResponse investmentDetail = new ApiInvestmentDetailResponse();
        investmentDetail.setInvestmentAmount(AmountFormatUtil.formatThousandsSeparator(totalAmount));
        investmentDetail.setCurrentTotalReturn(AmountFormatUtil.formatThousandsSeparator(totalReturn));
        total.setInvestmentDetail(investmentDetail);
        responses.add(total);
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<List<ApiOtherFundsResponse>> queryOtherFunds(OtherFundsQueryRequest request, Long loginUserId) {
        List<ApiOtherFundsResponse> responses = new ArrayList<>();
        List<PurchasedFundsEntity> pfs = purchasedFundsMapper.selectList(Wrappers.<PurchasedFundsEntity>query().lambda()
                .eq(PurchasedFundsEntity::getClientId, loginUserId)
                .eq(PurchasedFundsEntity::getDelFlag, Boolean.FALSE));
        List<Long> fundIds = null;
        if (CollectionUtil.isNotEmpty(pfs)){
            fundIds = pfs.stream().map(PurchasedFundsEntity::getFundId).distinct().collect(Collectors.toList());
        }
        List<FundsEntity> fundsEntities = fundsMapper.selectList(Wrappers.<FundsEntity>query().lambda()
                .eq(ObjectUtil.isNotNull(request.getFundCategory()), FundsEntity::getBFundCategory, request.getFundCategory())
//                              .eq(ObjectUtil.isNotNull(request.getLanguage()), FundsEntity::getLanguage, request.getLanguage())
                .notIn(CollectionUtil.isNotEmpty(fundIds), FundsEntity::getId, fundIds)
                .eq(FundsEntity::getDelFlag, Boolean.FALSE)
                .orderByDesc(FundsEntity::getId)
                .last(ObjectUtil.isNotNull(request.getNumLimit()), "limit " + request.getNumLimit()));
        for (FundsEntity fund : fundsEntities){
            ApiOtherFundsResponse response = new ApiOtherFundsResponse();
            response.setFundId(fund.getId());
            response.setFundName(fund.getName());
            response.setFundStatus(EnumUtil.getByCode(FundsStatusEnum.class, fund.getFundStatus()));
            response.setDescription(fund.getDescription());
            response.setFundType(fund.getFundType());
            response.setInvestmentType(fund.getInvestmentType());
            response.setProductType(fund.getProductType());
            try {
                response.setMinInvestmentAmount(
                        AmountFormatUtil.formatThousandsSeparator(new BigDecimal(fund.getPurchaseMinAmount())));
            } catch (Exception e){
                log.error("===Wrong Data of PurchaseMinAmount in FundId:{}====", fund.getId());
            }
            response.setInvestmentCycle(fund.getInvestmentCycle());
            response.setFixedNetReturn(fund.getFixNetReturn());
            try {
                response.setApplicationFee(new BigDecimal(fund.getApplicationFeeRate()));
            } catch (Exception e){
                log.error("===Wrong Data of ApplicationFeeRate in FundId:{}====", fund.getId());
            }
            try {
                response.setManagementFee(new BigDecimal(fund.getManagementFeeRate()));
            } catch (Exception e){
                log.error("===Wrong Data of ManagementFeeRate in FundId:{}====", fund.getId());
            }
            if (StringUtils.hasText(fund.getImFilePath())) {
                response.setFundInformationIm(fundsService.getFundFileFullPath(IM_FILE_PATH, fund.getId(), fund.getImFilePath()));
            }
            if (StringUtils.hasText(fund.getSubImFilePath())) {
                response.setFundInformationSubIm(fundsService.getFundFileFullPath(SUB_IM_FILE_PATH, fund.getId(), fund.getSubImFilePath()));
            }
            if (StringUtils.hasText(fund.getApplicationForm())) {
                response.setApplicationForm(fundsService.getFundFileFullPath(APPLICATION_FORM, fund.getId(), fund.getApplicationForm()));
            }
            responses.add(response);
        }
        return CommonResponse.success(responses);
    }


    //-----------------------------------------------------------------------------------------------------------

    private ApiInvestmentDetailResponse assembleInvestmentDetail(BizPurchasedFundsDTO pf,
                                                                 FundCategoryEnum fundCategory) {
        ApiInvestmentDetailResponse investmentDetail = new ApiInvestmentDetailResponse();
        investmentDetail.setInvestmentAmount(AmountFormatUtil.formatThousandsSeparator(pf.getPurchaseAmount()));
        investmentDetail.setInvestmentDate(DateUtil.format(purchasedFundsService.getStartReturnDay(pf), DatePattern.NORM_DATE_PATTERN));
        investmentDetail.setSettlementDate(DateUtil.format(pf.getSettlementDate(), DatePattern.NORM_DATE_PATTERN));
        investmentDetail.setExpiredDate(DateUtil.format(pf.getPurchaseEndDate(), DatePattern.NORM_DATE_PATTERN));

        investmentDetail.setExpectedTotalReturn(
                AmountFormatUtil.formatThousandsSeparator(
                        purchasedFundsService.getTargetReturn(pf, fundCategory,
                                purchasedFundsService.getLengthOfThisYear(new Date()))
                )
        );
        investmentDetail.setCurrentTotalReturn(AmountFormatUtil.formatThousandsSeparator(
                purchasedFundsService.getCurrentTotalReturn(pf)
        ));
        return investmentDetail;
    }
    private ApiMonthlyDetailResponse assembleMonthlyDetail(BizPurchasedFundsDTO pf, FundCategoryEnum fundCategory) {
        ApiMonthlyDetailResponse monthlyDetail = new ApiMonthlyDetailResponse();
        monthlyDetail.setMonthlyBenefit(AmountFormatUtil.formatThousandsSeparator(purchasedFundsService.getCurrentMonthReturn(
                pf)));
        List<DividendHistoryResponse> afterNowDividends = dividendDayList(pf, fundCategory).stream().filter(
                di -> di.getDividendDate().isAfter(LocalDate.now())).collect(Collectors.toList());
        if (CollectionUtil.isNotEmpty(afterNowDividends)) {
            monthlyDetail.setNextPaymentTime(afterNowDividends.get(0).getDividendDate().toString());
        }
        return monthlyDetail;
    }

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
