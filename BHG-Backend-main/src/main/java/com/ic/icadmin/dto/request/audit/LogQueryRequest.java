package com.ic.icadmin.dto.request.audit;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "LogQueryRequest", description = "LogQueryRequest")
public class LogQueryRequest {

    private String entityType;

    private String operateType;

    private Long entityId;
    private String entityName;

    private String startDate;

    private String endDate;

    private Long creator;

    private String creatorName;
}
