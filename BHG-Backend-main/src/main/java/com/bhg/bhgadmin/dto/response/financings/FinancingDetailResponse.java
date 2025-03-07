package com.bhg.bhgadmin.dto.response.financings;

import com.bhg.bhgadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "FinancingDetailResponse", description = "Financing detail Response")
public class FinancingDetailResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("client name")
    private String clientName;

    @ApiModelProperty("fund Id")
    private Long fundId;

    @ApiModelProperty("fund name")
    private String fundName;

    @ApiModelProperty("fund name CN")
    private String fundNameCN;

    @ApiModelProperty("commission Amount")
    private BigDecimal commissionAmount;

    @ApiModelProperty("commission rate")
    private BigDecimal commissionRate;

    @ApiModelProperty("currency")
    private String currency;

    @ApiModelProperty("current Total Return")
    private BigDecimal currentTotalReturn;

    @ApiModelProperty("target Amount")
    private BigDecimal targetAmount;

    @ApiModelProperty("total financing amount")
    private BigDecimal financingAmount;

    private Date createAtDate;

    @ApiModelProperty("create at")
    private String createAt;

    private Date updateAtDate;

    @ApiModelProperty("update at")
    private String updateAt;

    @ApiModelProperty("Current Total Return Response")
    private List<CurrentTotalReturnResponse> subClientsCurrentTotalReturnResponses;

    private BigDecimal bYearlyReturnRate;

    @ApiModelProperty("Commission History Response")
    private List<DividendHistoryResponse> commissionHistoryResponses;

    @ApiModelProperty(value = "gst")
    private Boolean gst = Boolean.FALSE;

    @ApiModelProperty(value = "refList")
    private List<FinanceRefResponse> refList;

    @ApiModelProperty("entity Id")
    private Long entityId;

    @ApiModelProperty("entity name")
    private String entityName;
}
