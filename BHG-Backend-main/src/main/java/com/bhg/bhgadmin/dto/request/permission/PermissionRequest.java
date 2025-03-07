package com.bhg.bhgadmin.dto.request.permission;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-18 23:15
 **/
@Data
@ApiModel(description = "query button permission request")
public class PermissionRequest {

    @NotBlank
    @ApiModelProperty("parent permission name")
    private String parentPermission;
}
