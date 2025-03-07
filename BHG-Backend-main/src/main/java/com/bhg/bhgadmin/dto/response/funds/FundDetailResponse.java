package com.bhg.bhgadmin.dto.response.funds;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.bhg.bhgadmin.entity.FundsEntity;
import com.bhg.bhgadmin.share.enums.FundCategoryEnum;
import com.bhg.bhgadmin.share.enums.FundsStatusEnum;
import com.bhg.bhgadmin.share.enums.LanguageEnum;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "FundDetailResponse", description = "Fund Detail Response")
public class FundDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("nameCN")
    private String nameCN;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("descriptionCN")
    private String descriptionCN;

    @ApiModelProperty("Settlement Date")
    private String settlementDate;

    @ApiModelProperty("interest starts date")
    private String interestStartsDate;

    @ApiModelProperty("amount")
    private BigDecimal amount;

    @ApiModelProperty("currency")
    private String currency;

    @ApiModelProperty("currencyCN")
    private String currencyCN;

    @ApiModelProperty("fund Type")
    private String fundType;

    @ApiModelProperty("fundTypeCN")
    private String fundTypeCN;

    @ApiModelProperty("investment Type")
    private String investmentType;

    @ApiModelProperty("investmentTypeCN")
    private String investmentTypeCN;

    @ApiModelProperty("product Type")
    private String productType;

    @ApiModelProperty("productTypeCN")
    private String productTypeCN;

    @ApiModelProperty("purchase Min Amount")
    private String purchaseMinAmount;

    @ApiModelProperty("investment cycle")
    private String investmentCycle;

    @ApiModelProperty("investmentCycleCN")
    private String investmentCycleCN;

    @ApiModelProperty("fixNetReturn")
    private String fixNetReturn;

    @ApiModelProperty("fixNetReturnCN")
    private String fixNetReturnCN;

    @ApiModelProperty("float Net Return")
    private String floatNetReturn;

    @ApiModelProperty("floatNetReturnCN")
    private String floatNetReturnCN;

    @ApiModelProperty("application Fee Rate")
    private String applicationFeeRate;

    @ApiModelProperty("applicationFeeRateCN")
    private String applicationFeeRateCN;

    @ApiModelProperty("managementFeeRate")
    private String managementFeeRate;

    @ApiModelProperty("managementFeeRateCN")
    private String managementFeeRateCN;

    @ApiModelProperty("imFilePath")
    private String imFilePath;

    @ApiModelProperty("introduceFilePath")
    private String introduceFilePath;

    @ApiModelProperty("eoiFilePath")
    private String eoiFilePath;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("update at")
    private String updateAt;

    @ApiModelProperty("netReturnA")
    private String netReturnA;

    @ApiModelProperty("netReturnACN")
    private String netReturnACN;

    @ApiModelProperty("netReturnB")
    private String netReturnB;

    @ApiModelProperty("netReturnBCN")
    private String netReturnBCN;

    @ApiModelProperty("cashDividedCycle")
    private String cashDividedCycle;

    @ApiModelProperty("cashDividedCycleCN")
    private String cashDividedCycleCN;

    @ApiModelProperty("performanceFeeRate")
    private String performanceFeeRate;

    @ApiModelProperty("performanceFeeRateCN")
    private String performanceFeeRateCN;

    @ApiModelProperty("investmentStrategy")
    private String investmentStrategy;

    @ApiModelProperty("investmentStrategyCN")
    private String investmentStrategyCN;

    @ApiModelProperty("natureYearlyReturn")
    private String natureYearlyReturn;

    @ApiModelProperty("natureYearlyReturnCN")
    private String natureYearlyReturnCN;

    @ApiModelProperty("valueYearlyReturn")
    private String valueYearlyReturn;

    @ApiModelProperty("valueYearlyReturnCN")
    private String valueYearlyReturnCN;

    @ApiModelProperty("subscriptionFeeRate")
    private String subscriptionFeeRate;

    @ApiModelProperty("subscriptionFeeRateCN")
    private String subscriptionFeeRateCN;

    @ApiModelProperty("reportFilePath")
    private String reportFilePath;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("transId")
    private Long trans;

    @ApiModelProperty("additionalInvestmentFile")
    private String additionalInvestmentFile;

    @ApiModelProperty("displayOrder")
    private Integer displayOrder;

    @ApiModelProperty("constitutionFile")
    private String constitutionFile;

    @ApiModelProperty("bFundCategory")
    private String bFundCategory;

    @ApiModelProperty("bProjectDurationMonth")
    private Integer bProjectDurationMonth;

    @ApiModelProperty("bYearlyReturnRate")
    private BigDecimal bYearlyReturnRate;

    @ApiModelProperty("bDelayedGrowthRate")
    private BigDecimal bDelayedGrowthRate;

    @ApiModelProperty("fullySubscription")
    private Boolean fullySubscription;

    @ApiModelProperty("fundStatus")
    private String fundStatus;

    @ApiModelProperty("endDate")
    private String endDate;

    @ApiModelProperty("subImFilePath")
    private String subImFilePath;

    @ApiModelProperty("applicationForm")
    private String applicationForm;

    @ApiModelProperty(value = "sub_im_date")
    private String subImDate;

    @ApiModelProperty(value = "deed_date")
    private String deedDate;
    @ApiModelProperty(value = "cover")
    private String cover;
    @ApiModelProperty(value = "coverCn")
    private String coverCn;
    @ApiModelProperty("popular")
    private Integer popular;
    @ApiModelProperty("state_id")
    private Long stateId;

    @ApiModelProperty("state_en")
    private String stateEn;

    @ApiModelProperty("state_cn")
    private String stateCn;

    @ApiModelProperty(name = "extend_start_date")
    private String extendStartDate;

    @ApiModelProperty(name = "default_start_date")
    private String defaultStartDate;

    @ApiModelProperty(name = "cover_two")
    private String coverTwo;
    @ApiModelProperty(name = "cover_three")
    private String coverThree;
    @ApiModelProperty(name = "cover_four")
    private String coverFour;
    @ApiModelProperty(name = "cover_cn_two")
    private String coverCnTwo;
    @ApiModelProperty(name = "cover_cn_three")
    private String coverCnThree;
    @ApiModelProperty(name = "cover_cn_four")
    private String coverCnFour;
    @ApiModelProperty(name = "company")
    private String company;
    public FundDetailResponse(FundsEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.nameCN = entity.getNameCN();
        this.description = entity.getDescription();
        this.descriptionCN = entity.getDescriptionCN();
        this.settlementDate = DateFormatUtil.getMMMddyyyy(entity.getSettlementDate());
        this.interestStartsDate = DateFormatUtil.getMMMddyyyy(entity.getInterestStartsDate());
        this.amount = entity.getAmount();
        this.currency = entity.getCurrency();
        this.currencyCN = entity.getCurrencyCN();
        this.fundType = entity.getFundType();
        this.fundTypeCN = entity.getFundTypeCN();
        this.investmentType = entity.getInvestmentType();
        this.investmentTypeCN = entity.getInvestmentTypeCN();
        this.productType = entity.getProductType();
        this.productTypeCN = entity.getProductTypeCN();
        this.purchaseMinAmount = entity.getPurchaseMinAmount();
        this.investmentCycle = entity.getInvestmentCycle();
        this.investmentCycleCN = entity.getInvestmentCycleCN();
        this.fixNetReturn = entity.getFixNetReturn();
        this.fixNetReturnCN = entity.getFixNetReturnCN();
        this.floatNetReturn = entity.getFloatNetReturn();
        this.floatNetReturnCN = entity.getFloatNetReturnCN();
        this.applicationFeeRate = entity.getApplicationFeeRate();
        this.applicationFeeRateCN = entity.getApplicationFeeRateCN();
        this.managementFeeRate = entity.getManagementFeeRate();
        this.managementFeeRateCN = entity.getManagementFeeRateCN();
//        this.imFilePath = entity.getImFilePath();
//        this.introduceFilePath = entity.getIntroduceFilePath();
//        this.eoiFilePath = entity.getEoiFilePath();
        this.createAt = DateFormatUtil.getMHHmm(entity.getCreatedAt());
        this.updateAt = DateFormatUtil.getMHHmm(entity.getUpdatedAt());
        this.netReturnA = entity.getNetReturnA();
        this.netReturnACN = entity.getNetReturnACN();
        this.netReturnB = entity.getNetReturnB();
        this.netReturnBCN = entity.getNetReturnBCN();
        this.cashDividedCycle = entity.getCashDividedCycle();
        this.cashDividedCycleCN = entity.getCashDividedCycleCN();
        this.performanceFeeRate = entity.getPerformanceFeeRate();
        this.performanceFeeRateCN = entity.getPerformanceFeeRateCN();
        this.investmentStrategy = entity.getInvestmentStrategy();
        this.investmentStrategyCN = entity.getInvestmentStrategyCN();
        this.natureYearlyReturn = entity.getNatureYearlyReturn();
        this.natureYearlyReturnCN = entity.getNatureYearlyReturnCN();
        this.valueYearlyReturn = entity.getValueYearlyReturn();
        this.valueYearlyReturnCN = entity.getValueYearlyReturnCN();
        this.subscriptionFeeRate = entity.getSubscriptionFeeRate();
        this.subscriptionFeeRateCN = entity.getSubscriptionFeeRateCN();
//        this.reportFilePath = entity.getReportFilePath();
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
        this.trans = entity.getTransId();
//        this.additionalInvestmentFile = entity.getAdditionalInvestmentFile();
        this.displayOrder = entity.getDisplayOrder();
//        this.constitutionFile = entity.getConstitutionFile();
        this.bFundCategory = EnumUtil.getEnumMessageByCode(FundCategoryEnum.class, entity.getBFundCategory());
        this.bProjectDurationMonth = entity.getBProjectDurationMonth();
        this.bYearlyReturnRate = entity.getBYearlyReturnRate();
        this.bDelayedGrowthRate = entity.getBDelayedGrowthRate();
        this.fullySubscription = entity.getFullySubscription();
        this.fundStatus = EnumUtil.getEnumMessageByCode(FundsStatusEnum.class, entity.getFundStatus());
        this.endDate = DateFormatUtil.getMMMddyyyy(entity.getEndDate());
        this.subImDate = DateUtil.formatDate(entity.getSubImDate());
        this.deedDate = DateUtil.formatDate(entity.getDeedDate());
        this.popular = entity.getPopular();
        this.stateId = entity.getStateId();
        this.stateCn = entity.getStateCn();
        this.stateEn = entity.getStateEn();
        this.company = entity.getCompany();
//        this.subImFilePath = entity.getSubImFilePath();
//        this.applicationForm = entity.getApplicationForm();
        this.extendStartDate = DateUtil.formatDate(entity.getExtendStartDate());
        this.defaultStartDate = DateUtil.formatDate(entity.getDefaultStartDate());
    }

}
