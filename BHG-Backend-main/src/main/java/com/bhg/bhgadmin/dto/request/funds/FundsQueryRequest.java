package com.bhg.bhgadmin.dto.request.funds;

import cn.afterturn.easypoi.excel.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "FundsQueryRequest", description = "Funds Query Request")
public class FundsQueryRequest {

    @ApiModelProperty("Fund category")
    private Integer fundCategory;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("fundStatus")
    private Integer fundStatus;
    @ApiModelProperty("fund Type")
    private String fundType;

    @ApiModelProperty("investment Type")
    private String investmentType;

    @ApiModelProperty(value = "product_type")
    private String productType;

    @ApiModelProperty(value = "popular")
    private Integer popular;

    @ApiModelProperty("fundStatusList")
    private List<Integer> fundStatusList;

    @ApiModelProperty("history")
    private Boolean history;

    private List<Long> idList;

    private List<Long> excludeIdList;

    private Long entityId;

    private Long stateId;
    private String company;
}
