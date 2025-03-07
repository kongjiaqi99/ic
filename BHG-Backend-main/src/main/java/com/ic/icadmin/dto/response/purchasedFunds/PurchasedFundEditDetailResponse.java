package com.ic.icadmin.dto.response.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "PurchasedFundCreateRequest", description = "Purchased Fund Create Request")
public class PurchasedFundEditDetailResponse {

    @ApiModelProperty("purchased fund id")
    private Long id;

    @ApiModelProperty("client id")
    private Long clientId;

    @ApiModelProperty("client")
    private String client;

    @ApiModelProperty("fund id")
    private Long fundId;

    @ApiModelProperty("fund")
    private String fund;

    @ApiModelProperty("Unit certificate date")
    private LocalDate unitCertificateDate;

    @ApiModelProperty("Transaction date")
    private LocalDate transactionDate;

    @ApiModelProperty("purchase end date")
    private LocalDate purchaseEndDate;

    @ApiModelProperty("purchased amount")
    private BigDecimal purchasedAmount;

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

    @ApiModelProperty("investment entity id")
    private Long investmentEntityId;
    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSigned;
    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedTwo;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedThree;

    @ApiModelProperty("application Form (Signed)")
    private String applicationFormSignedFour;

}
