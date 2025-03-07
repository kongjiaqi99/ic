package com.bhg.bhgadmin.dto.request;

import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(description = "Request containing the funds associated with the selected tag")
public class FundTagRequest {
    @ApiModelProperty(value = "Current selected tag id")
    private Long tagId;
    @ApiModelProperty(value = "The funds id you selected")
    private List<Long> fundId;
}
