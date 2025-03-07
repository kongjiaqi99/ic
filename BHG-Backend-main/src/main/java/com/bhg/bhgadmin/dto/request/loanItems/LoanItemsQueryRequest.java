package com.bhg.bhgadmin.dto.request.loanItems;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "LoanItemsQueryRequest", description = "Loan Items Query Request")
public class LoanItemsQueryRequest {

    @ApiModelProperty("addressFilter")
    private Integer addressFilter;
    @ApiModelProperty("address")
    private String address;

    @ApiModelProperty("projectDateStart")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate projectDateStart;

    @ApiModelProperty("projectDateEnd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate projectDateEnd;

    @ApiModelProperty("loanStatusFilter")
    private Integer loanStatusFilter;
    @ApiModelProperty("loanStatus")
    private Integer loanStatus;

    @ApiModelProperty("descriptionFilter")
    private Integer descriptionFilter;
    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("valueFilter")
    private Integer valueFilter;
    @ApiModelProperty("value")
    private String value;

    @ApiModelProperty("createAtStart")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate createAtStart;

    @ApiModelProperty("createAtEnd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate createAtEnd;

    @ApiModelProperty("updateAtStart")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate updateAtStart;

    @ApiModelProperty("updateAtEnd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate updateAtEnd;

}
