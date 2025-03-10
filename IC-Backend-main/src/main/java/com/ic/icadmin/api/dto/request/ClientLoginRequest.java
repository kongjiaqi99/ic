package com.ic.icadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "ClientLoginRequest", description = "login parameter")
public class ClientLoginRequest {

    @ApiModelProperty(value = "email")
    @Email
    private String email;

    @ApiModelProperty(value = "password")
    private String password;

    @ApiModelProperty(value = "verificationCode")
    private String verificationCode;
}
