package com.ic.icadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ClientDelRequest", description = "Clients Delete Request")
public class ClientDelRequest {

    @ApiModelProperty("Client Id")
    private Long id;
}
