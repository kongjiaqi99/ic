package com.ic.icadmin.dto.response.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "PurchasedFundsResponse", description = "Purchased Funds Response")
public class PurchasedFundsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("client id")
    private Long clientId;

    @ApiModelProperty("client name")
    private String clientName;

    @ApiModelProperty("fund id")
    private Long fundId;

    @ApiModelProperty("fund name")
    private String fundName;

    @ApiModelProperty("unit certificate date")
    private String unitCertificateDate;

    @ApiModelProperty("purchase end date")
    private String purchaseEndDate;

    @ApiModelProperty("purchased amount")
    private BigDecimal purchasedAmount;

    @ApiModelProperty("current month return")
    private BigDecimal currentMonthReturn;

    @ApiModelProperty("current total return")
    private BigDecimal currentTotalReturn;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("investment entity id")
    private Long investmentEntityId;

    @ApiModelProperty("entity name")
    private String entityName;

    @ApiModelProperty("purchase start date")
    private String purchaseStartDate;

    @ApiModelProperty("transaction date")
    private String transactionDate;

    private String status;

}
