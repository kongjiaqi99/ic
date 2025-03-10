package com.ic.icadmin.dto.response.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "FinancingDetailResponse", description = "Financing detail Response")
public class FinancingEditDetailResponse {

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

    @ApiModelProperty("fund nameCN")
    private String fundNameCN;

    @ApiModelProperty("total financing amount")
    private BigDecimal financingAmount;

    @ApiModelProperty("commission rate")
    private BigDecimal commissionRate;

    @ApiModelProperty("commission Amount")
    private BigDecimal commissionAmount;

    @ApiModelProperty("currency")
    private String currency;

    @ApiModelProperty("target Amount")
    private BigDecimal targetAmount;

    @ApiModelProperty("target Date")
    private Date targetDate;

    @ApiModelProperty("achieve Target")
    private Boolean achieveTarget;

    @ApiModelProperty(value = "gst")
    private Boolean gst = Boolean.FALSE;

    @ApiModelProperty(value = "refList")
    private List<FinanceRefResponse> refList;

    @ApiModelProperty("entity Id")
    private Long entityId;

    @ApiModelProperty("entity name")
    private String entityName;
}
