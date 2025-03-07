package com.bhg.bhgadmin.dto.request.funds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "FundEditRequest", description = "Fund Edit Request")
public class FundEditRequest extends FundCreateRequest {

    @NotNull
    @ApiModelProperty("fund Id")
    private Long id;


}
