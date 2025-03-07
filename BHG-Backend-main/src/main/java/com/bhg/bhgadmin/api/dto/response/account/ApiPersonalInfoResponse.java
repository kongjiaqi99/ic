package com.bhg.bhgadmin.api.dto.response.account;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:56
 **/
@Data
@ApiModel(description = "personal info response")
public class ApiPersonalInfoResponse {

    @ApiModelProperty(value = "id")
    private Long id;

    @ApiModelProperty(value = "name")
    private String name;

    @ApiModelProperty(value = "email")
    private String email;

    @ApiModelProperty(value = "phone")
    private String phone;

    @ApiModelProperty(value = "birthday")
    private String birthday;

    @ApiModelProperty(value = "kycStatus 0:waiting, 1:approved, 2:not_match")
    private Integer kycStatus;

    @ApiModelProperty(value = "enablePin false true")
    private boolean enablePin;

    @ApiModelProperty(value = "md5 pin")
    private String pin;

    @ApiModelProperty(value = "pin")
    private String bsb;
}
