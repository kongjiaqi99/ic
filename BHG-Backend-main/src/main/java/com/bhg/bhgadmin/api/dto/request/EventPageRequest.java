package com.bhg.bhgadmin.api.dto.request;

import com.bhg.bhgadmin.dto.request.events.EventQueryRequest;
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
@ApiModel(value = "EventPageRequest", description = "Event Page Request")
public class EventPageRequest extends EventQueryRequest{
    int pageNum = 1;
    int pageSize = 30;
}
