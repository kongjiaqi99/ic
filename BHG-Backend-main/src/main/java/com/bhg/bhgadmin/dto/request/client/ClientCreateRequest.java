package com.bhg.bhgadmin.dto.request.client;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ClientCreateRequest", description = "Clients Create Request")
public class ClientCreateRequest {

    @Email
    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("password")
    private String password;

    @ApiModelProperty("password")
    private String confirmPassword;

    @ApiModelProperty("verification code")
    private String verificationCode;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("countryCode")
    private String countryCode;

    @ApiModelProperty("mobile")
    private String mobile;

    @ApiModelProperty("birth")
    private Date birth;

    @ApiModelProperty("Beaver Id")
    private String beaverId;

    @ApiModelProperty("client type")
    private Integer clientType;

    @ApiModelProperty("Upper client Id")
    private Long upperClient;

    @ApiModelProperty("Level 2 upper client id")
    private Long level2UpperClientId;

    @ApiModelProperty("BSB")
    private String bsb;

    @ApiModelProperty("Account Name")
    private String accountName;

    @ApiModelProperty("Account Number")
    private String accountNumber;

    @ApiModelProperty("Start Date")
    private Date startDate;

    @ApiModelProperty("End Date")
    private Date endDate;

    @ApiModelProperty("Target Amount")
    private BigDecimal targetAmount;

    @ApiModelProperty("Link to value up")
    private Boolean linkToValueup;

    @ApiModelProperty("investment Create RequestList")
    private List<InvestmentCreateRequest> investmentCreateRequestList;

    @ApiModelProperty(value = "withheld_tax")
    private Boolean withheldTax = Boolean.FALSE;

    @ApiModelProperty(value = "tf_num")
    private String tfNum;
}
