package com.bhg.bhgadmin.dto.response.investment;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "InvestmentResponse", description = "Investment Response")
public class InvestmentResponse {

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
    private BigDecimal purchasedAmount = BigDecimal.ZERO;

    @ApiModelProperty("current return")
    private BigDecimal currentReturn = BigDecimal.ZERO;

    @ApiModelProperty("total return")
    private BigDecimal totalReturn = BigDecimal.ZERO;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("entity id")
    private Long entityId;

    @ApiModelProperty("entity name")
    private String entityName;

    @ApiModelProperty("record count")
    private Integer recordCount;

    @ApiModelProperty("status")
    private String status;

    @ApiModelProperty("bhg id")
    private String bhgId;
    @ApiModelProperty("purchased_funds id")
    private Object pfId;

    @ApiModelProperty("month_return")
    private BigDecimal monthReturn = BigDecimal.ZERO;

    @ApiModelProperty("prev_month_return")
    private BigDecimal prevMonthReturn = BigDecimal.ZERO;
}
