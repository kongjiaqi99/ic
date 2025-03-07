package com.ic.icadmin.dto.request.loanItems;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "LoanItemCreateRequest", description = "Loan Item Create Request")
public class LoanItemCreateRequest {

    @ApiModelProperty("address")
    private String address;

    @ApiModelProperty("project date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate projectDate;

    @ApiModelProperty("loan status")
    private Integer loanStatus;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("value")
    private String value;

}
