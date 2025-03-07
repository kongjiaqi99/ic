package com.bhg.bhgadmin.dto.response.permission;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-18 23:15
 **/
@Data
@ApiModel(description = "button permission response")
@AllArgsConstructor
public class PermissionResponse {

    @ApiModelProperty("edit permission")
    private Boolean editPerm;
}
