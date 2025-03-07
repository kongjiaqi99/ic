package com.ic.icadmin.dto.response.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@ApiModel(value = "ClientsNameResponse", description = "Clients Name Response")
public class ClientsNameResponse {

    @ApiModelProperty("client Id")
    private Long id;

    @ApiModelProperty("client name")
    private String name;
}
