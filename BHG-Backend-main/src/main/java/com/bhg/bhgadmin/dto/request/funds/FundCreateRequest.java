package com.bhg.bhgadmin.dto.request.funds;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "FundCreateRequest", description = "Fund Create Request")
public class FundCreateRequest {

    @NotBlank
    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("fundStatus")
    private Integer fundStatus;

    @ApiModelProperty("language")
    private Integer language;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("Settlement Date")
    private String settlementDate;

    @ApiModelProperty("InterestStartsDate Date")
    private String interestStartsDate;

    @ApiModelProperty("endDate")
    private String endDate;

    @ApiModelProperty("amount")
    private BigDecimal amount;

    @ApiModelProperty("currency")
    private String currency;

    @ApiModelProperty("fund Type")
    private String fundType;

    @ApiModelProperty("investment Type")
    private String investmentType;

    @ApiModelProperty("product Type")
    private String productType;

    @ApiModelProperty("purchase Min Amount")
    private String purchaseMinAmount;

    @ApiModelProperty("investment cycle")
    private String investmentCycle;

    @ApiModelProperty("fixNetReturn")
    private String fixNetReturn;

    @ApiModelProperty("float Net Return")
    private String floatNetReturn;

    @ApiModelProperty("application Fee Rate")
    private String applicationFeeRate;

    @ApiModelProperty("managementFeeRate")
    private String managementFeeRate;

    @ApiModelProperty("netReturnA")
    private String netReturnA;

    @ApiModelProperty("netReturnB")
    private String netReturnB;

    @ApiModelProperty("cashDividedCycle")
    private String cashDividedCycle;

    @ApiModelProperty("performanceFeeRate")
    private String performanceFeeRate;

    @ApiModelProperty("investmentStrategy")
    private String investmentStrategy;

    @ApiModelProperty("natureYearlyReturn")
    private String natureYearlyReturn;

    @ApiModelProperty("valueYearlyReturn")
    private String valueYearlyReturn;

    @ApiModelProperty("subscriptionFeeRate")
    private String subscriptionFeeRate;

    @ApiModelProperty("bFundCategory")
    private Integer bfundCategory;

    @ApiModelProperty("bYearlyReturnRate")
    private BigDecimal byearlyReturnRate;

    @ApiModelProperty("bProjectDurationMonth")
    private Integer bprojectDurationMonth;

    @ApiModelProperty("bDelayedGrowthRate")
    private BigDecimal bdelayedGrowthRate;

    @ApiModelProperty("fullySubscription")
    private Boolean fullySubscription;

    @ApiModelProperty("displayOrder")
    private Integer displayOrder;

    @ApiModelProperty("transId")
    private Long trans;
    /**
     * 国际化字段
     */
    @ApiModelProperty("descriptionCN")
    private String descriptionCN;

    @ApiModelProperty("nameCN")
    private String nameCN;

    @ApiModelProperty("fundTypeCN")
    private String fundTypeCN;

    @ApiModelProperty("investmentTypeCN")
    private String investmentTypeCN;

    @ApiModelProperty("productTypeCN")
    private String productTypeCN;

    @ApiModelProperty("cashDividedCycleCN")
    private String cashDividedCycleCN;

    @ApiModelProperty("currencyCN")
    private String currencyCN;

    @ApiModelProperty("investmentCycleCN")
    private String investmentCycleCN;

    @ApiModelProperty("fixNetReturnCN")
    private String fixNetReturnCN;

    @ApiModelProperty("floatNetReturnCN")
    private String floatNetReturnCN;

    @ApiModelProperty("applicationFeeRateCN")
    private String applicationFeeRateCN;

    @ApiModelProperty("managementFeeRateCN")
    private String managementFeeRateCN;

    @ApiModelProperty("netReturnACN")
    private String netReturnACN;

    @ApiModelProperty("netReturnBCN")
    private String netReturnBCN;

    @ApiModelProperty("performanceFeeRateCN")
    private String performanceFeeRateCN;

    @ApiModelProperty("investmentStrategyCN")
    private String investmentStrategyCN;

    @ApiModelProperty("natureYearlyReturnCN")
    private String natureYearlyReturnCN;

    @ApiModelProperty("valueYearlyReturnCN")
    private String valueYearlyReturnCN;

    @ApiModelProperty("subscriptionFeeRateCN")
    private String subscriptionFeeRateCN;

    @ApiModelProperty("sub Im Date")
    private String subImDate;

    @ApiModelProperty("deed date")
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

    @ApiModelProperty(name = "cover")
    private String cover;
    @ApiModelProperty(name = "cover_two")
    private String coverTwo;
    @ApiModelProperty(name = "cover_three")
    private String coverThree;
    @ApiModelProperty(name = "cover_four")
    private String coverFour;
    @ApiModelProperty(name = "cover_cn")
    private String coverCn;
    @TableField(value = "cover_cn_two")
    @ApiModelProperty(name = "cover_cn_two")
    private String coverCnTwo;
    @ApiModelProperty(name = "cover_cn_three")
    private String coverCnThree;
    @ApiModelProperty(name = "cover_cn_four")
    private String coverCnFour;



    private String updateImFilePath;
    private String updateSubImFilePath;
    private String updateIntroduceFilePath;
    private String updateEoiFilePath;
    private String updateReportFilePath;
    private String updateAdditionalInvestmentFile;
    private String updateConstitutionFile;
    private String updateApplicationForm;
    @ApiModelProperty(name = "company")
    private String company;
}
