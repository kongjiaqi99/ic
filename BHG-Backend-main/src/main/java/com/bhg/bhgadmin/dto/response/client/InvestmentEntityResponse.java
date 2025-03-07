package com.bhg.bhgadmin.dto.response.client;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.InvestmentEntities;
import com.bhg.bhgadmin.entity.InvestmentEntitiesKyc;
import com.bhg.bhgadmin.share.enums.InvestEntityTypeEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 11:21
 **/
@Data
@ApiModel(value = "InvestmentEntityResponse")
@AllArgsConstructor
@NoArgsConstructor
public class  InvestmentEntityResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("Entity Type")
    private String entityType;

    @ApiModelProperty("Entity name")
    private String entityName;

    @ApiModelProperty("KYC Result")
    private Boolean kycResult;

    @ApiModelProperty("Update At")
    private String updateAt;

    @ApiModelProperty("DOCUMENT 1 FRONT")
    private String file1Front;

    @ApiModelProperty("DOCUMENT 1 BACK")
    private String file1Back;

    @ApiModelProperty("DOCUMENT 2 FRONT")
    private String file2Front;

    @ApiModelProperty("DOCUMENT 2 BACK")
    private String file2Back;


    @ApiModelProperty("bhg id")
    private String bhgId;

    @ApiModelProperty("email_list")
    private Object emailList;

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
    @ApiModelProperty("investment_count")
    private Integer investmentCount;

    @ApiModelProperty("Account Number")
    private String accountNumber;

    @ApiModelProperty("Account Name")
    private String accountName;

    @ApiModelProperty("Withheld tax")
    private Boolean withheldTax = Boolean.FALSE;

    @ApiModelProperty("Tf num")
    private String tfNum;

    @ApiModelProperty("active")
    private boolean active;

    @ApiModelProperty("BSB")
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
    private Object applicationFormList;

    private void setEntityType(Integer entityType){
        this.entityType = EnumUtil.getEnumMessageByCode(InvestEntityTypeEnum.class, entityType);
    }

    private void setUpdateAt(Date updateAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.updateAt = ObjectUtils.isNull(updateAt) ? null : DateUtil.format(updateAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public void setEntity(InvestmentEntities entity) {
        setEntityType(entity.getEntityType());
        setUpdateAt(entity.getUpdatedAt());
    }

    public void setEntity(InvestmentEntitiesKyc entity) {
        setEntityType(entity.getEntityType());
        setUpdateAt(entity.getUpdatedAt());
    }
    public InvestmentEntityResponse(InvestmentEntities entity) {
        this.id = entity.getId();
        setEntityType(entity.getEntityType());
        this.entityName = entity.getEntityName();
        this.kycResult = entity.getKycResult();
        setUpdateAt(entity.getUpdatedAt());
    }
}
