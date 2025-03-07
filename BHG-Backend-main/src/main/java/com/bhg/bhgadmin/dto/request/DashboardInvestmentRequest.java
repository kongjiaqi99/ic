package com.bhg.bhgadmin.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:33
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "DashboardInvestmentRequest", description = "Dashboard Investment request")
public class DashboardInvestmentRequest {

    @ApiModelProperty("start_date")
    private String startDate;

    @ApiModelProperty("end_date")
    private String endDate;
}
