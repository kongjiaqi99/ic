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
@ApiModel(value = "VisitorQueryRequest", description = "VisitorQueryRequest")
public class VisitorQueryRequest {

    private String email;

    private String startDate;

    private String endDate;

    private String status;
}
