package com.ic.icadmin.dto.request.admin;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-18 21:57
 **/
@Data
@ApiModel(value = "ResetPwdFromEmailRequest")
public class ResetPwdFromEmailRequest {

    @ApiModelProperty("pwd")
    private String pwd;

    @ApiModelProperty("encryptedToken")
    private String encryptedToken;
}
