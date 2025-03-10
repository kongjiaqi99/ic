package com.ic.icadmin.dto.request.loanItems;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "LoanItemUpdateRequest", description = "Loan Item Update Request")
public class LoanItemUpdateRequest extends LoanItemCreateRequest {

    @NotNull
    @ApiModelProperty("id")
    private Long id;


}
