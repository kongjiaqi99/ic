package com.ic.icadmin.dto.request.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "AdminUserQueryRequest", description = "Admin User Query Request")
public class AdminUserQueryRequest {

    @ApiModelProperty("admin-email")
    private String adminUserEmail;

    @ApiModelProperty("filter Type")
    private Integer filterType;
}
