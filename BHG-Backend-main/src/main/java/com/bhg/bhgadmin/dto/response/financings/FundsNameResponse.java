package com.bhg.bhgadmin.dto.response.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@ApiModel(value = "FundsNameResponse", description = "Funds Name Response")
public class FundsNameResponse {

    @ApiModelProperty("fund Id")
    private Long id;

    @ApiModelProperty("fund name")
    private String name;

    @ApiModelProperty("fund name CN")
    private String nameCN;

    @ApiModelProperty("b fund category")
    private String bFundCategory;
}
