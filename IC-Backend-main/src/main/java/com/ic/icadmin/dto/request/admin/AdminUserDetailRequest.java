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
@ApiModel(value = "AdminUserDetailRequest", description = "Admin User Detail Request")
public class AdminUserDetailRequest {

    @ApiModelProperty("admin Id")
    private Long id;
}
