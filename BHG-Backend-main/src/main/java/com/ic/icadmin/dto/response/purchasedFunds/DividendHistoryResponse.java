package com.ic.icadmin.dto.response.purchasedFunds;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-08 21:07
 **/
@Data
@AllArgsConstructor
public class DividendHistoryResponse {

    @ApiModelProperty("Dividend Date")
    private LocalDate dividendDate;

    @ApiModelProperty("Dividend Amount")
    private BigDecimal dividendAmount;

}
