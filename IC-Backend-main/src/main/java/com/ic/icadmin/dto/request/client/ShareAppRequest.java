package com.ic.icadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ShareAppRequest", description = "ShareAppRequest")
public class ShareAppRequest  {

//    @ApiModelProperty("phone")
//    @Pattern(regexp = "^04\\d{8}$",message = "Wrong number")
//    @NotBlank(message = "The number is a required field")
    private String phone;
}
