package com.bhg.bhgadmin.api.dto.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-16 11:43
 **/
@Data
@ApiModel(value = "ClientsLoginResponse", description = "client login response")
public class ClientsLoginResponse {

    @ApiModelProperty(value = "clientEmail")
    private String clientEmail;

    @ApiModelProperty(value = "token")
    private String token;

    @ApiModelProperty(value = "permissions")
    private List<String> perms;
}
