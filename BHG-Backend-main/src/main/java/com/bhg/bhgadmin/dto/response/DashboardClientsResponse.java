package com.bhg.bhgadmin.dto.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:33
 **/
@Data
@AllArgsConstructor
@ApiModel(value = "DashboardClientsResponse", description = "Dashboard Clients response")
public class DashboardClientsResponse {

    @ApiModelProperty("clientId")
    private Long id;

    @ApiModelProperty("client name")
    private String clientName;

    @ApiModelProperty("birthday")
    private String birthday;

    @ApiModelProperty("Email")
    private String email;
}
