package com.bhg.bhgadmin.dto.request.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "AdminUserDelRequest", description = "Admin User Delete Request")
public class AdminUserDelRequest {

    @ApiModelProperty("admin Id")
    private Long id;
}
