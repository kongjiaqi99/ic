package com.ic.icadmin.dto.response;

import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@ApiModel(description = "Response containing the funds associated with the selected tag")
public class FundTagResponse {
    @ApiModelProperty(value = "The funds belong to the selected tag", example = "[[1, 'fund1'], [2, 'fund2']]")
    private List<FundDetails> funds;
}
