package com.ic.icadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ClientPushIdRequest", description = "ClientPushIdRequest")
public class ClientPushIdRequest {

    @ApiModelProperty("push Id")
    @NotNull
    private String pushId;

    @ApiModelProperty("language 0cn 1en")
    private Integer language;
}
