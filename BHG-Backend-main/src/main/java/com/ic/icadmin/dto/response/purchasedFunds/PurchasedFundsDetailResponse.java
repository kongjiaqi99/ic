package com.ic.icadmin.dto.response.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "PurchasedFundsDetailResponse", description = "Purchased Funds Detail Response")
public class PurchasedFundsDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("client id")
    private Long clientId;

    @ApiModelProperty("client name")
    private String clientName;

    @ApiModelProperty("entity name")
    private String entityName;

    @ApiModelProperty("fund id")
    private Long fundId;

    @ApiModelProperty("fund name")
    private String fundName;

    @ApiModelProperty("unit certificate date")
    private String unitCertificateDate;

    @ApiModelProperty("transaction date")
    private String transactionDate;

    @ApiModelProperty("purchase end date")
    private String purchaseEndDate;

    @ApiModelProperty("purchased amount")
    private BigDecimal purchasedAmount;

    @ApiModelProperty("current return")
    private BigDecimal currentReturn;

    @ApiModelProperty("dividend amount")
    private BigDecimal dividendAmount;

    @ApiModelProperty("dividend cycle")
    private String dividendCycle;

    @ApiModelProperty("current month return")
    private BigDecimal currentMonthReturn;

    @ApiModelProperty("current total return")
    private BigDecimal currentTotalReturn;

    @ApiModelProperty("investment Entity Id")
    private Long investmentEntityId;

    @ApiModelProperty("investment Entity Name")
    private String investmentEntityName;

    @ApiModelProperty("unitCerti")
    private String unitCertificate;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSigned;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedTwo;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedThree;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedFour;

    @ApiModelProperty("dividend History")
    private List<DividendHistoryResponse> dividendHistory;
}
