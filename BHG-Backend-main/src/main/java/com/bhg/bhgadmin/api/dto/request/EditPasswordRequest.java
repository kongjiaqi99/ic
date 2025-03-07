package com.bhg.bhgadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Client edit password Request")
public class EditPasswordRequest {

    @ApiModelProperty(value = "current password")
    @NotBlank
    private String currentPassword;

    @ApiModelProperty(value = "password")
    @NotBlank
    private String password;

    @ApiModelProperty(value = "confirm password")
    @NotBlank
    private String confirmPassword;
}
