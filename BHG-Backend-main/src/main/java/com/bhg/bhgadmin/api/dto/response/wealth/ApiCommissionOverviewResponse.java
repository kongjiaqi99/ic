package com.bhg.bhgadmin.api.dto.response.wealth;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 13:38
 **/
@Data
@ApiModel(description = "commission overview response")
public class ApiCommissionOverviewResponse {

    @ApiModelProperty(value = "Fund Name")
    private String fundName;

    @ApiModelProperty(value = "commission Responses")
    private List<ApiCommissionResponse> commissionResponses;

    @ApiModelProperty(value = "Expected Commission")
    private String expectedCommission;

    @ApiModelProperty(value = "Monthly Accumulated Commission")
    private String monthlyAccumulatedCommission;

    @ApiModelProperty(value = "Next payment Time")
    private LocalDate nextPaymentTime;
}
