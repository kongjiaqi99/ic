package com.bhg.bhgadmin.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 19:25
 **/
@Data
@ApiModel(value = "DictionaryQueryRequest", description = "Dictionary Query Request")
public class DictionaryQueryRequest {

    @NotBlank
    @ApiModelProperty("dic type")
    private String type;
}
