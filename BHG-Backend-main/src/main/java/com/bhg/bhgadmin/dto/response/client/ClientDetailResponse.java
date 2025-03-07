package com.bhg.bhgadmin.dto.response.client;

import com.baomidou.mybatisplus.annotation.TableField;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.share.enums.ClientTypeEnum;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 11:21
 **/
@Data
@ApiModel(value = "ClientDetailResponse")
public class ClientDetailResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("Beaver Id")
    private String beaverId;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("Country Code")
    private String countryCode;

    @ApiModelProperty("mobile")
    private String mobile;

    @ApiModelProperty("birth")
    private String birth;

    @ApiModelProperty("Client Type")
    private String clientType;

    @ApiModelProperty("Upper Client")
    private String upperClient;

    @ApiModelProperty("level2UpperClient")
    private String level2UpperClient;

    @ApiModelProperty("BSB")
    private String bsb;

    @ApiModelProperty("Account Name")
    private String accountName;

    @ApiModelProperty("Account Number")
    private String accountNumber;

    @ApiModelProperty("CreateAt")
    private String createAt;

    @ApiModelProperty("Start Date")
    private String startDate;

    @ApiModelProperty("End Date")
    private String endDate;

    @ApiModelProperty("Target Amount")
    private BigDecimal targetAmount;

    @ApiModelProperty("Link To ValueUp")
    private Boolean linkToValueup;

    @ApiModelProperty(value = "withheld_tax")
    private Boolean withheldTax = Boolean.FALSE;

    @ApiModelProperty(value = "tf_num")
    private String tfNum;
    @ApiModelProperty(value = "kycStatus")
    private Integer kycStatus;

    public ClientDetailResponse(ClientsEntity clientsEntity, String upperClient, String level2UpperClient) {
        this.id = clientsEntity.getId();
        this.beaverId = clientsEntity.getBeaverId();
        this.name = clientsEntity.getName();
        this.email = clientsEntity.getEmail();
        this.countryCode = clientsEntity.getCountryCode();
        this.mobile = clientsEntity.getMobile();
        this.birth = DateFormatUtil.getMMMddyyyy(clientsEntity.getBirth());
        this.clientType = EnumUtil.getEnumMessageByCode(ClientTypeEnum.class, clientsEntity.getClientType());
        this.upperClient = upperClient;
        this.level2UpperClient = level2UpperClient;
        this.bsb = clientsEntity.getBsb();
        this.accountName = clientsEntity.getAccountName();
        this.accountNumber = clientsEntity.getAccountNumber();
        this.createAt = DateFormatUtil.getMHHmm(clientsEntity.getCreatedAt());
        this.startDate = DateFormatUtil.getMMMddyyyy(clientsEntity.getStartDate());
        this.endDate = DateFormatUtil.getMMMddyyyy(clientsEntity.getEndDate());
        this.targetAmount = clientsEntity.getTargetAmount();
        this.linkToValueup = clientsEntity.getLinkToValueup();
        this.withheldTax = clientsEntity.getWithheldTax();
        this.tfNum = clientsEntity.getTfNum();
    }
}
