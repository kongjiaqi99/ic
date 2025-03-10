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
@ApiModel(description = "Monthly Detail response")
public class ApiMonthlyDetailResponse {

    @ApiModelProperty(value = "Monthly Benefit")
    private String monthlyBenefit;

    @ApiModelProperty(value = "Next Payment Time")
    private String nextPaymentTime;
}
