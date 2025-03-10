package com.ic.icadmin.dto.request.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "PurchasedFundsQueryRequest", description = "PurchasedFunds Query Request")
public class PurchasedFundsQueryRequest {

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("fund Id")
    private Long fundId;

    @ApiModelProperty("Fund category")
    private Integer fundCategory;

    @ApiModelProperty("Id list")
    private List<Long> idList;

    @ApiModelProperty("Start date")
    private String startDate;

    @ApiModelProperty("End date")
    private String endDate;

    @ApiModelProperty("Template type 1-Monthly 2-Annual")
    private Integer templateType;

    @ApiModelProperty("entity Id")
    private Long entityId;

    @ApiModelProperty("fund Name")
    private String fundName;

    @ApiModelProperty("client Name")
    private String clientName;

    @ApiModelProperty("entity Name")
    private String entityName;

    @ApiModelProperty("ic id")
    private String icId;

    @ApiModelProperty("note")
    private String note;

}
