package com.ic.icadmin.dto.request.events;

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
@ApiModel(value = "EventEditRequest", description = "Event Edit Request")
public class EventEditRequest extends EventCreateRequest {

    @NotNull
    @ApiModelProperty("event Id")
    private Long id;

}
