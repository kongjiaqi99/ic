package com.bhg.bhgadmin.dto.request.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-18 01:24
 **/
@Data
@ApiModel(value = "SendResetAdminPasswordRequest", description = "send reset admin password parameter")
public class SendResetAdminPasswordRequest {

    @Email
    @ApiModelProperty("admin Email")
    private String adminEmail;
}
