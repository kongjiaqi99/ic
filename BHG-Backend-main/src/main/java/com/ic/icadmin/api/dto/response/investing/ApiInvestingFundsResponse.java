package com.ic.icadmin.api.dto.response.investing;

import com.baomidou.mybatisplus.annotation.TableField;
import com.ic.icadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import com.ic.icadmin.share.enums.FundsStatusEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 13:49
 **/
@Data
@ApiModel(description = "Investing Funds response")
public class ApiInvestingFundsResponse {

    @ApiModelProperty(value = "Fund Id")
    private Long fundId;

    @ApiModelProperty(value = "Fund Name")
    private String fundName;

    @ApiModelProperty(value = "Fund Name CN")
    private String fundNameCn;

    @ApiModelProperty(value = "Fund Status")
    private FundsStatusEnum fundStatus;

    @ApiModelProperty(value = "Fund Type")
    private String fundType;

    @ApiModelProperty(value = "Fund Type cn")
    private String fundTypeCn;


    @ApiModelProperty(value = "Investment Type")
    private String investmentType;

    @ApiModelProperty(value = "Investment Type cn")
    private String investmentTypeCn;

    @ApiModelProperty(value = "Min Investment Amount")
    private String minInvestmentAmount;

    @ApiModelProperty(value = "Investment Cycle")
    private String investmentCycle;

    @ApiModelProperty(value = "Investment Cycle cn")
    private String investmentCycleCn;

    @ApiModelProperty(value = "Fixed Net Return")
    private String fixedNetReturn;

    @ApiModelProperty(value = "Commission Cycle")
    private String commissionCycle;

    @ApiModelProperty(value = "Application Form")
    private String applicationForm;

    @ApiModelProperty(value = "Unit Certificate")
    private String unitCertificate;

    @ApiModelProperty(value = "Fund Information IM")
    private String fundInformationIm;

    @ApiModelProperty(value = "Fund Introduction")
    private String fundIntroduction;

    @ApiModelProperty(value = "Reinvest Form")
    private String reinvestForm;

    @ApiModelProperty(value = "Investment Detail")
    private ApiInvestmentDetailResponse investmentDetail;

    @ApiModelProperty(value = "Monthly Detail")
    private ApiMonthlyDetailResponse monthlyDetail;

    @ApiModelProperty(value = "History Payment Record")
    private List<DividendHistoryResponse> paymentRecord;

    @ApiModelProperty(value = "B Fund Category")
    private Integer bFundCategory;

    @ApiModelProperty(value = "purchasedId")
    private Long purchasedId;

    @ApiModelProperty(value = "interestStartsDate")
    private Date interestStartsDate;

    @ApiModelProperty(value = "interestEndDate")
    private Date interestEndDate;

}
