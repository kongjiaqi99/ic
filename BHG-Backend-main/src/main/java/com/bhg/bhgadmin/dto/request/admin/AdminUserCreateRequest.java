package com.bhg.bhgadmin.dto.request.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "AdminUserCreateRequest", description = "Admin User Create Request")
public class AdminUserCreateRequest {

    @ApiModelProperty("admin-email")
    @Email
    private String adminUserEmail;

    @ApiModelProperty("password")
    private String password;

    @NotNull
    @ApiModelProperty("roleId")
    private Long roleId;
}
