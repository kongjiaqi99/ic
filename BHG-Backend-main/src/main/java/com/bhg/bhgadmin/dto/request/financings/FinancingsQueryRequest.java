package com.bhg.bhgadmin.dto.request.financings;

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
@ApiModel(value = "FinancingsQueryRequest", description = "Financings Query Request")
public class FinancingsQueryRequest {

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("fund Id")
    private Long fundId;

    @ApiModelProperty("entity Id")
    private Long entityId;

    @ApiModelProperty("client Name")
    private String clientName;

    @ApiModelProperty("fund Name")
    private String fundName;

    @ApiModelProperty("entity Name")
    private String entityName;

}
