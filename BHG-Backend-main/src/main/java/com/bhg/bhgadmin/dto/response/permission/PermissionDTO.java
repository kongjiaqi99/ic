package com.bhg.bhgadmin.dto.response.permission;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-18 15:33
 **/
@Data
@ApiModel(value = "PermissionDTO", description = "Parent permission")
@AllArgsConstructor
public class PermissionDTO {

    @ApiModelProperty("parent permission name")
    private String permissionName;

    @ApiModelProperty("parent Permission code")
    private String permissionCode;

    @ApiModelProperty("sub permission")
    private List<String> subPermission;
}
