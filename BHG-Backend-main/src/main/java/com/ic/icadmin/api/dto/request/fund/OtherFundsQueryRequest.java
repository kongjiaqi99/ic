package com.ic.icadmin.api.dto.request.fund;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 15:16
 **/
@Data
@ApiModel(description = "Other Fund Products Query Request")
public class OtherFundsQueryRequest {

    @ApiModelProperty(value = "查询数据的条数")
    private Integer numLimit;

    @ApiModelProperty(value = "fundCategory 0:BC Debt Income Opportuniities Fund, 1:ic Debt Income Master Fund")
    private Integer fundCategory;

    @ApiModelProperty(value = "fundStatus")
    private Integer fundStatus;

    @ApiModelProperty(value = "fundStatusNe")
    private Integer fundStatusNe;

    @ApiModelProperty(value = "fundId")
    private Long fundId;
    @ApiModelProperty(value = "purchasedId")
    private Long purchasedId;
}
