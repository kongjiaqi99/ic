package com.bhg.bhgadmin.dto.response.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "UpperClientsResponse", description = "Upper Clients Response")
public class UpperClientsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("name")
    private String name;

}
