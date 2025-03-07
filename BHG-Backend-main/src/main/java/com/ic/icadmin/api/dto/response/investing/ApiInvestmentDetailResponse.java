package com.ic.icadmin.api.dto.response.investing;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 13:49
 **/
@Data
@ApiModel(description = "Investment Detail response")
public class ApiInvestmentDetailResponse {

    @ApiModelProperty(value = "Investment Amount")
    private String investmentAmount;

    @ApiModelProperty(value = "Investment Date")
    private String investmentDate;

    @ApiModelProperty(value = "Settlement Date")
    private String settlementDate;

    @ApiModelProperty(value = "Expire Date")
    private String expiredDate;

    @ApiModelProperty(value = "Expected Total Return")
    private String expectedTotalReturn;

    @ApiModelProperty(value = "Current Total Return")
    private String currentTotalReturn;
}
