package com.ic.icadmin.dto.response.funds;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.ic.icadmin.entity.FundsEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "FundEditDetailResponse", description = "Fund Edit Detail Response")
public class FundEditDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("nameCN")
    private String nameCN;

    @ApiModelProperty("fundStatus")
    private String fundStatus;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("descriptionCN")
    private String descriptionCN;

    @ApiModelProperty("settlement Date")
    private Date settlementDate;

    @ApiModelProperty("interest starts date")
    private Date interestStartsDate;

    @ApiModelProperty("endDate")
    private Date endDate;

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

    @ApiModelProperty("bFundCategory")
    private String bFundCategory;

    @ApiModelProperty("bYearlyReturnRate")
    private BigDecimal bYearlyReturnRate;

    @ApiModelProperty("bProjectDurationMonth")
    private Integer bProjectDurationMonth;

    @ApiModelProperty("bDelayedGrowthRate")
    private BigDecimal bDelayedGrowthRate;

    @ApiModelProperty("fullySubscription")
    private Boolean fullySubscription;

    @ApiModelProperty("displayOrder")
    private Integer displayOrder;

    @ApiModelProperty("transId")
    private Long trans;

    @ApiModelProperty(value = "sub_im_date")
    private String subImDate;

    @ApiModelProperty(value = "deed_date")
    private String deedDate;

    @ApiModelProperty("popular")
    private Integer popular;
    @ApiModelProperty("state_id")
    private Long stateId;

    @ApiModelProperty("state_en")
    private String stateEn;

    @ApiModelProperty("state_cn")
    private String stateCn;

    @ApiModelProperty( "extend_start_date")
    private String extendStartDate;

    @ApiModelProperty( "default_start_date")
    private String defaultStartDate;
    @ApiModelProperty(name = "company")
    private String company;
    public FundEditDetailResponse(FundsEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.nameCN = entity.getNameCN();
        this.fundStatus = ObjectUtil.isNotNull(entity.getFundStatus()) ? entity.getFundStatus().toString() : null;
        this.language = ObjectUtil.isNotNull(entity.getLanguage()) ? entity.getLanguage().toString() : null;
        this.description = entity.getDescription();
        this.descriptionCN = entity.getDescriptionCN();
        this.settlementDate = entity.getSettlementDate();
        this.interestStartsDate = entity.getInterestStartsDate();
        this.endDate = entity.getEndDate();
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
        this.bFundCategory = ObjectUtil.isNotNull(entity.getBFundCategory()) ? entity.getBFundCategory().toString() : null;
        this.bYearlyReturnRate = entity.getBYearlyReturnRate();
        this.bProjectDurationMonth = entity.getBProjectDurationMonth();
        this.bDelayedGrowthRate = entity.getBDelayedGrowthRate();
        this.fullySubscription = entity.getFullySubscription();
        this.displayOrder = entity.getDisplayOrder();
        this.trans = entity.getTransId();
        this.subImDate = DateUtil.formatDate(entity.getSubImDate());
        this.deedDate = DateUtil.formatDate(entity.getDeedDate());
        this.popular = entity.getPopular();
        this.stateId = entity.getStateId();
        this.stateCn = entity.getStateCn();
        this.stateEn = entity.getStateEn();
        this.extendStartDate = DateUtil.formatDate(entity.getExtendStartDate());
        this.defaultStartDate = DateUtil.formatDate(entity.getDefaultStartDate());
        this.company = entity.getCompany();
    }
}
