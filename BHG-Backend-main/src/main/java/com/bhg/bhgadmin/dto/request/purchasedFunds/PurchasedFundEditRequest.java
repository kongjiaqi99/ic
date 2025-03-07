package com.bhg.bhgadmin.dto.request.purchasedFunds;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "PurchasedFundEditRequest", description = "Purchased fund Edit Request")
public class PurchasedFundEditRequest extends PurchasedFundCreateRequest{

    @NotNull
    @ApiModelProperty("Id")
    private Long id;

}
