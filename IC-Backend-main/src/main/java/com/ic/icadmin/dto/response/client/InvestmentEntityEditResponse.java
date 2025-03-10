package com.ic.icadmin.dto.response.client;

import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.ic.icadmin.entity.InvestmentEntities;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 11:21
 **/
@Data
@ApiModel(value = "InvestmentEntityEditResponse")
@AllArgsConstructor
@NoArgsConstructor
public class InvestmentEntityEditResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("Entity Type")
    private String entityType;

    @ApiModelProperty("Entity name")
    private String entityName;

    @ApiModelProperty("KYC Result")
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

    @ApiModelProperty("application_form_list")
    private List<String> applicationFormList;

    public InvestmentEntityEditResponse(InvestmentEntities entity) {

        this.id = entity.getId();
        this.entityType = ObjectUtils.isNull(entity.getEntityType()) ? null : entity.getEntityType().toString();
        this.entityName = entity.getEntityName();
        this.kycResult = entity.getKycResult();
    }

    public void setEntity(InvestmentEntities entity) {
        this.entityType = ObjectUtils.isNull(entity.getEntityType()) ? null : entity.getEntityType().toString();
    }
}
