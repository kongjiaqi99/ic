package com.ic.icadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Client edit pin Request")
public class EditPinRequest {

    @ApiModelProperty(value = "current pin")
    private String currentPin;

    @ApiModelProperty(value = "current Password")
    private String currentPassword;

    @ApiModelProperty(value = "pin")
    private String pin;

    @ApiModelProperty(value = "confirm pin")
    private String confirmPin;

    @ApiModelProperty(value = "verificationCode")
    private String verificationCode;
}
