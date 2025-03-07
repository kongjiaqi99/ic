package com.ic.icadmin.dto.response.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-16 17:59
 **/
@Data
@ApiModel(value = "sub client & Current Total Return", description = "sub client & Current Total Return")
public class CurrentTotalReturnResponse {

    @ApiModelProperty("entity id")
    private Long entityId;

    @ApiModelProperty("entity Name")
    private String entityName;

    @ApiModelProperty("client id")
    private Long clientId;

    @ApiModelProperty("client Name")
    private String clientName;

    @ApiModelProperty("entity id")
    private Long pid;

    @ApiModelProperty("level")
    private Integer level;

    @ApiModelProperty("purchase amount")
    private BigDecimal purchaseAmount;

    @ApiModelProperty("current Total Return")
    private BigDecimal currentTotalReturn;

    @ApiModelProperty("Sub sub client total return")
    private List<CurrentTotalReturnResponse> subSubClientTotalReturn;
}
