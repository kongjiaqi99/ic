package com.bhg.bhgadmin.api.dto.response.account;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:56
 **/
@Data
@ApiModel(description = "Investment project and amount response")
public class ApiInvestmentProjectsResponse {

    @ApiModelProperty(value = "Fund Name")
    private String fundName;

    @ApiModelProperty(value = "Settlement Date")
    private String settlementDate;

    @ApiModelProperty(value = "Interest Date")
    private String interestDate;

    @ApiModelProperty(value = "Transaction Date")
    private String transactionDate;

    @ApiModelProperty(value = "Total Amount")
    private String totalAmount;

    @ApiModelProperty(value = "Accumulated Income")
    private String accumulatedIncome;

    private BigDecimal accumulatedIncomeBigDecimal;
}
