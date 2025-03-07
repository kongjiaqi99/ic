package com.bhg.bhgadmin.dto.request.enquiries;

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
@ApiModel(value = "EnquiryDetailRequest", description = "Enquiry Detail Request")
public class EnquiryDetailRequest {

    @ApiModelProperty("Enquiry Id")
    private Long id;
}
