package com.bhg.bhgadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ReInvestmentRequest", description = "ReInvestmentRequest")
public class ReInvestmentRequest{

    @ApiModelProperty(value = "fundId")
    Long fundId;
    @ApiModelProperty(value = "entityId")
    Long entityId;
    @ApiModelProperty(value = "clientId")
    Long clientId;

    @ApiModelProperty(value = "email")
    String email;

    String fundName;
    String entityName;
    String clientName;
    @ApiModelProperty(value = "fileUrl")
    List<String> fileUrl;
}
