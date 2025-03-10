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
@ApiModel(value = "ClientsQueryRequest", description = "Clients Query Request")
public class ClientsQueryRequest {

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("mobile")
    private String mobile;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("Beaver Id")
    private String beaverId;

    @ApiModelProperty("client type")
    private Integer clientType;

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("state")
    private String state;

    @ApiModelProperty("entityName")
    private String entityName;

    @ApiModelProperty("withheldTax")
    private Boolean withheldTax;
}
