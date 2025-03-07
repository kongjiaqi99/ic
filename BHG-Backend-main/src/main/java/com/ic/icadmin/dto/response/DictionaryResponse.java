package com.ic.icadmin.dto.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 19:20
 **/
@Data
@ApiModel(value = "DictionaryResponse", description = "Dictionary response")
@AllArgsConstructor
public class DictionaryResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("dic type")
    private String type;

    @ApiModelProperty("dic code")
    private String code;

    @ApiModelProperty("dic value")
    private String value;

    @ApiModelProperty("sort")
    private Integer sort;
}
