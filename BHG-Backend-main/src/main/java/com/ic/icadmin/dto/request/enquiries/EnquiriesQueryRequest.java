package com.ic.icadmin.dto.request.enquiries;

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
@ApiModel(value = "EnquiriesQueryRequest", description = "Enquiries Query Request")
public class EnquiriesQueryRequest {

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("message")
    private String message;

    @ApiModelProperty("Email")
    private String email;
}
