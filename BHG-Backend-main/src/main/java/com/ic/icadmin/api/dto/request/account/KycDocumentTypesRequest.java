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
@ApiModel(description = "Kyc Document Types Request")
public class KycDocumentTypesRequest {

    @ApiModelProperty(value = "Country code")
    private String countryCode;
}
