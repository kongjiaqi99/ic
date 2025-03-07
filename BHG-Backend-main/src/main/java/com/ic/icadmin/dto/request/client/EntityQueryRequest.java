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
@ApiModel(value = "EntityQueryRequest", description = "entity_query_request")
public class EntityQueryRequest {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("client_id")
    private Long clientId;
}
