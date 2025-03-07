package com.bhg.bhgadmin.dto.request.investment;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "InvestmentRequest", description = "InvestmentRequest")
public class InvestmentRequest {
    @ApiModelProperty("fund Id")
    private Long fundId;

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("investment entity Id")
    private Long investmentEntityId;

    @ApiModelProperty("fund Name")
    private String fundName;

    @ApiModelProperty("client Name")
    private String clientName;

    @ApiModelProperty("entity Name")
    private String entityName;

    @ApiModelProperty("bhg id")
    private String bhgId;
}
