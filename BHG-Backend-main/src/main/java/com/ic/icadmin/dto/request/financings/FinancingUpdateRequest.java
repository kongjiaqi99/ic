package com.ic.icadmin.dto.request.financings;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@ApiModel(value = "FinancingUpdateRequest", description = "Financing Update Request")
public class FinancingUpdateRequest extends FinancingCreateRequest {

    @ApiModelProperty("id")
    private Long id;

}
