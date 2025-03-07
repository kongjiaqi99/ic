package com.bhg.bhgadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Client pin Request")
public class PinRequest {

    @ApiModelProperty(value = "pin")
    @NotBlank
    private String pin;

}
