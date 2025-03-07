package com.ic.icadmin.dto.response.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "RoleResponse", description = "Roles Response")
public class RoleResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("role name")
    private String roleName;

}
