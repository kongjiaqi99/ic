package com.bhg.bhgadmin.dto.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:33
 **/
@Data
@AllArgsConstructor
@ApiModel(value = "DashboardNumResponse", description = "Dashboard Num response")
public class DashboardNumResponse {

    @ApiModelProperty("enquiry_num")
    private Integer enquiryNum;

    @ApiModelProperty("client_num")
    private Integer clientNum;
}
