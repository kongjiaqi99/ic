package com.ic.icadmin.dto.request.audit;

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
@ApiModel(value = "AuditQueryRequest", description = "AuditQueryRequest")
public class AuditEditRequest {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("status")
    private String status;

}
