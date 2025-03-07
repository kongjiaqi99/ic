package com.bhg.bhgadmin.dto.response.client;

import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.share.enums.ClientTypeEnum;
import com.bhg.bhgadmin.share.enums.InvestStatusEnum;
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
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "ClientsResponse", description = "Clients Response")
public class ClientsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("Beaver Id")
    private String beaverId;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("country code")
    private String countryCode;

    @ApiModelProperty("mobile")
    private String mobile;

    @ApiModelProperty("birthStr")
    private String birth;

    @ApiModelProperty("upper client name")
    private String upperClient;

    @ApiModelProperty("upper client Id")
    private Long upperClientId;

    @ApiModelProperty("Level 2 upper client name")
    private String level2UpperClient;

    @ApiModelProperty("Level 2 upper client Id")
    private Long level2UpperClientId;

    @ApiModelProperty("client type")
    private String clientType;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("Invest Status")
    private String investStatus;

    @ApiModelProperty("End Date")
    private String endDate;

    @ApiModelProperty("total amount")
    private BigDecimal totalAmount = BigDecimal.ZERO;

    @ApiModelProperty("prev month return")
    private BigDecimal prevMonthReturn = BigDecimal.ZERO;

    @ApiModelProperty("current return")
    private BigDecimal currentReturn = BigDecimal.ZERO;

    public void addTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = this.totalAmount.add(totalAmount);
    }

    public void addPrevMonthReturn(BigDecimal prevMonthReturn) {
        this.prevMonthReturn = this.prevMonthReturn.add(prevMonthReturn);
    }

    public void addCurrentReturn(BigDecimal currentReturn) {
        this.currentReturn = this.currentReturn.add(currentReturn);
    }

    public ClientsResponse(ClientsEntity clientsEntity, String upperClientName, String level2UpperClientName) {
        this.id = clientsEntity.getId();
        this.beaverId = clientsEntity.getBeaverId();
        this.name = clientsEntity.getName();
        this.email = clientsEntity.getEmail();
        this.countryCode = clientsEntity.getCountryCode();
        this.mobile = clientsEntity.getMobile();
        this.birth = DateFormatUtil.getMMMddyyyy(clientsEntity.getBirth());
        this.upperClient = upperClientName;
        this.upperClientId = clientsEntity.getUpperClientId();
        this.level2UpperClient = level2UpperClientName;
        this.level2UpperClientId = clientsEntity.getLevel2UpperClientId();
        this.clientType = EnumUtil.getEnumMessageByCode(ClientTypeEnum.class, clientsEntity.getClientType());
        this.createAt = DateFormatUtil.getMHHmm(clientsEntity.getCreatedAt());
        this.investStatus = EnumUtil.getEnumMessageByCode(InvestStatusEnum.class, clientsEntity.getInvestStatus());
        this.endDate = DateFormatUtil.getMMMddyyyy(clientsEntity.getEndDate());
    }

}
