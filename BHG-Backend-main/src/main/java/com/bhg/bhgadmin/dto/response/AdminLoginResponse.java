package com.bhg.bhgadmin.dto.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-16 11:43
 **/
@Data
@ApiModel(value = "AdminLoginResponse", description = "admin login response")
public class AdminLoginResponse {

    @ApiModelProperty("adminEmail")
    private String adminEmail;

    @ApiModelProperty("token")
    private String token;

    @ApiModelProperty("permissions")
    private List<String> perms;

    @ApiModelProperty("roles")
    private List<String> roles;
}
