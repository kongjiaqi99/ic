package com.ic.icadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "InvestmentCreateRequest", description = "Investment Create Request")
public class InvestmentCreateRequest {

    @ApiModelProperty("Investment Id")
    private Long id;

    @ApiModelProperty("Entity Type")
    private Integer entityType;

    @ApiModelProperty("Entity Name")
    private String entityName;

    @ApiModelProperty("kyc Result")
    private Boolean kycResult;

    @ApiModelProperty("ic id")
    private String icId;

    @ApiModelProperty("email_list")
    private List<String> emailList;

    @ApiModelProperty("address_line")
    private String addressLine;

    @ApiModelProperty("suburb")
    private String suburb;

    @ApiModelProperty("state")
    private String state;

    @ApiModelProperty("postcode")
    private String postcode;

    @NotNull
    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("Account Number")
    private String accountNumber;

    @ApiModelProperty("Account Name")
    private String accountName;

    @ApiModelProperty("Withheld tax")
    private Boolean withheldTax = Boolean.FALSE;

    @ApiModelProperty("Tf num")
    private String tfNum;

    @ApiModelProperty("bsb")
    private String bsb;

    @ApiModelProperty(name = "Application form signed")
    private String applicationFormSigned;

    @ApiModelProperty(name = "Application form signed_two")
    private String applicationFormSignedTwo;

    @ApiModelProperty(name = "Application form signed_three")
    private String applicationFormSignedThree;

    @ApiModelProperty(name = "Application form signed_four")
    private String applicationFormSignedFour;

    @ApiModelProperty("application_form_list")
    private List<String> applicationFormList;

}
