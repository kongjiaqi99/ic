package com.ic.icadmin.dto.request.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "PurchasedFundCreateRequest", description = "Purchased Fund Create Request")
public class PurchasedFundCreateRequest {

    @ApiModelProperty("client id")
    private Long clientId;

    @ApiModelProperty("fund id")
    private Long fundId;

    @ApiModelProperty("unit certificate date")
    private String unitCertificateDate;

    @ApiModelProperty("transaction date")
    private String transactionDate;

    @ApiModelProperty("purchase end date")
    private String purchaseEndDate;

    @ApiModelProperty("purchased amount")
    private BigDecimal purchasedAmount;

    @ApiModelProperty("investment entity")
    private Long investmentEntityId;

    @ApiModelProperty("investment Entity Name")
    private String entityName;

    @ApiModelProperty("Uc no")
    private String ucNo;

    @ApiModelProperty("address line")
    private String addressLine;

    @ApiModelProperty("suburb")
    private String suburb;

    @ApiModelProperty("state")
    private String state;

    @ApiModelProperty("post code")
    private String postCode;

    @ApiModelProperty(name = "application_form_signed")
    private String applicationFormSigned;
    @ApiModelProperty(name = "application_form_signed_two")
    private String applicationFormSignedTwo;
    @ApiModelProperty(name = "application_form_signed_three")
    private String applicationFormSignedThree;
    @ApiModelProperty(name = "application_form_signed_four")
    private String applicationFormSignedFour;
}
