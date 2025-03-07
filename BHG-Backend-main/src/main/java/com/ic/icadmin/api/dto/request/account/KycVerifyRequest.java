package com.ic.icadmin.api.dto.request.account;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Kyc Verify Request")
public class KycVerifyRequest {

    @ApiModelProperty(value = "Document 1 type")
    private String docOneType;

    @ApiModelProperty(value = "Country Code")
    private String countryCode;

    @ApiModelProperty(value = "entity_id")
    private Long entityId;

    @ApiModelProperty(value = "entity_Type")
    private Integer entityType;

    @ApiModelProperty(value = "entity_Name")
    private String entityName;
}
