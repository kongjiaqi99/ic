package com.ic.icadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Client reset password code send Request")
public class ResetPasswordCodeSendRequest {

    @ApiModelProperty(value = "email")
    @Email
    private String email;

    @ApiModelProperty(value = "mobile")
    private String mobile;
}
