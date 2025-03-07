package com.bhg.bhgadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ClientsDownwardQueryRequest", description = "Clients Downward Query Request")
public class ClientsDownwardQueryRequest {

    @ApiModelProperty("upper Client Id")
    private Long upperClientId;
}
