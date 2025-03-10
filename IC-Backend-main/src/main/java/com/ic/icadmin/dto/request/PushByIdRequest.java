package com.ic.icadmin.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "PushByIdRequest", description = "Query By Id Request")
public class PushByIdRequest {

    @ApiModelProperty("msgId")
    private Long msgId;

    @ApiModelProperty("client_id_list")
    private List<Long> clientIdList;
}
