package com.bhg.bhgadmin.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "DTO representing a tag request")
public class TagRequestDTO {
    
    @ApiModelProperty(value = "The ID of the tag", required = true)
    private Long id;
    @ApiModelProperty(value = "The name of the tag", required = true)
    private String name;
    @ApiModelProperty(value = "An ABN associated with the tag", required = true)
    private String abn;
}
