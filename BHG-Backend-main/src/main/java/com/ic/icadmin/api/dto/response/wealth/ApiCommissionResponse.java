package com.ic.icadmin.api.dto.response.wealth;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:56
 **/
@Data
@ApiModel(description = "commission response")
public class ApiCommissionResponse {

    @ApiModelProperty(value = "customer name")
    private String customerName;

    @ApiModelProperty(value = "Start Time")
    private String startTime;

    @ApiModelProperty(value = "Total Amount")
    private String totalAmount;

    private BigDecimal totalAmountBigDecimal;

    @ApiModelProperty(value = "customer's total income")
    private String customerTotalIncome;

    private BigDecimal customerTotalIncomeBigDecimal;

    private BigDecimal customerCurrentMonthIncome;

    @ApiModelProperty(value = "commission rate")
    private BigDecimal commissionRate;

    @ApiModelProperty(value = "Commission Amount")
    private String commissionAmount;

    private BigDecimal commissionAmountBigDecimal;

    private BigDecimal expectedCommission;

    private BigDecimal monthlyAccumulatedCommission;

    private LocalDate nextPaymentTime;

/*    private BigDecimal totalAmountBigDecimal;

    @ApiModelProperty(name = "Accumulated Commission", value = "accumulatedCommission")
    private String accumulatedCommission;

    private BigDecimal accumulatedCommissionBigDecimal;*/
}
