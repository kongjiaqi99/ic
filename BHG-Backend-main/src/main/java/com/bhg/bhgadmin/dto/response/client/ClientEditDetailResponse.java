package com.bhg.bhgadmin.dto.response.client;

import com.bhg.bhgadmin.entity.ClientsEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 11:21
 **/
@Data
@ApiModel(value = "ClientEditDetailResponse")
public class ClientEditDetailResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("Country Code")
    private String countryCode;

    @ApiModelProperty("mobile")
    private String mobile;

    @ApiModelProperty("birth")
    private Date birth;

    @ApiModelProperty("Beaver Id")
    private String beaverId;

    @ApiModelProperty("Client Type")
    private Integer clientType;

    @ApiModelProperty("Upper Client")
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

    @ApiModelProperty("Link To ValueUp")
    private Boolean linkToValueup;

    @ApiModelProperty(value = "withheld_tax")
    private Boolean withheldTax = Boolean.FALSE;

    @ApiModelProperty(value = "tf_num")
    private String tfNum;

    public ClientEditDetailResponse(ClientsEntity clientsEntity) {
        this.id = clientsEntity.getId();
        this.email = clientsEntity.getEmail();
        this.name = clientsEntity.getName();
        this.countryCode = clientsEntity.getCountryCode();
        this.mobile = clientsEntity.getMobile();
        this.birth = clientsEntity.getBirth();
        this.beaverId = clientsEntity.getBeaverId();
        this.clientType = clientsEntity.getClientType();
        this.upperClient = clientsEntity.getUpperClientId();
        this.level2UpperClientId = clientsEntity.getLevel2UpperClientId();
        this.bsb = clientsEntity.getBsb();
        this.accountName = clientsEntity.getAccountName();
        this.accountNumber = clientsEntity.getAccountNumber();
        this.startDate = clientsEntity.getStartDate();
        this.endDate = clientsEntity.getEndDate();
        this.targetAmount = clientsEntity.getTargetAmount();
        this.linkToValueup = clientsEntity.getLinkToValueup();
        this.withheldTax = clientsEntity.getWithheldTax();
        this.tfNum = clientsEntity.getTfNum();

    }
}
