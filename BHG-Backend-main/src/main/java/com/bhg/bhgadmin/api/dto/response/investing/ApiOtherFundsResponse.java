package com.bhg.bhgadmin.api.dto.response.investing;

import com.bhg.bhgadmin.share.enums.FundsStatusEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 13:49
 **/
@Data
@ApiModel(description = "Other Funds response")
public class ApiOtherFundsResponse {

    @ApiModelProperty(value = "Fund Id")
    private Long fundId;

    @ApiModelProperty(value = "Fund Name")
    private String fundName;

    @ApiModelProperty(value = "Fund Status")
    private FundsStatusEnum fundStatus;

    @ApiModelProperty(value = "Description")
    private String description;

    @ApiModelProperty(value = "Fund Type")
    private String fundType;

    @ApiModelProperty(value = "Investment Type")
    private String investmentType;

    @ApiModelProperty(value = "Product Type")
    private String productType;

    @ApiModelProperty(value = "Min Investment Amount")
    private String minInvestmentAmount;

    @ApiModelProperty(value = "Investment Cycle")
    private String investmentCycle;

    @ApiModelProperty(value = "Fixed Net Return")
    private String fixedNetReturn;

    @ApiModelProperty(value = "ApplicationFee")
    private BigDecimal applicationFee;

    @ApiModelProperty(value = "ManagementFee")
    private BigDecimal managementFee;

    @ApiModelProperty(value = "Fund Information IM")
    private String fundInformationIm;

    @ApiModelProperty(value = "Fund Information Sub IM")
    private String fundInformationSubIm;

    @ApiModelProperty(value = "Application Form")
    private String applicationForm;

}
