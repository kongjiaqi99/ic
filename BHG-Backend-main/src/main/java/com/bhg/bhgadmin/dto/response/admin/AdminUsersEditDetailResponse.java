package com.bhg.bhgadmin.dto.response.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "AdminUsersEditDetailResponse", description = "Admin Users Edit Detail Response")
public class AdminUsersEditDetailResponse {

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("roleId")
    private String roleId;

}
