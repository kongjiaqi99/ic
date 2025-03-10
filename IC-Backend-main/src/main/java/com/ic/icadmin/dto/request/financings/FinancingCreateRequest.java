package com.ic.icadmin.dto.request.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@ApiModel(value = "FinancingCreateRequest", description = "Financing Create Request")
public class FinancingCreateRequest {

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("fund Id")
    private Long fundId;

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
    private String targetDate;

    @ApiModelProperty("achieve Target")
    private Boolean achieveTarget;

    @ApiModelProperty(value = "gst")
    private Boolean gst = Boolean.FALSE;

    @ApiModelProperty(value = "refList")
    private List<FinanceRefRequest> refList;

    @ApiModelProperty("entity Id")
    private Long entityId;

}
