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
@ApiModel(value = "InvestmentGlobalResponse", description = "Investment Global Response")
public class InvestmentGlobalResponse {

    @ApiModelProperty("total investment")
    private BigDecimal totalInvestment = BigDecimal.ZERO;

    @ApiModelProperty("investment count")
    private Integer investmentCount = 0;

    @ApiModelProperty("previous investment")
    private BigDecimal previousInvestment = BigDecimal.ZERO;

    @ApiModelProperty("current investment return")
    private BigDecimal currentReturn = BigDecimal.ZERO;
}
