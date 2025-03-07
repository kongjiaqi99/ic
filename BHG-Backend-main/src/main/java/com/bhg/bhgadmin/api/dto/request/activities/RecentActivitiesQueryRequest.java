package com.bhg.bhgadmin.api.dto.request.activities;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Recent Activities Query Request")
public class RecentActivitiesQueryRequest {

    @ApiModelProperty(value = "查询数据的条数")
    private Integer numLimit;

    @ApiModelProperty(value = "city 0:Online, 1:Sydney, 2:Melbourne, 3:Brisbane, 4:Adelaide, ！！Other不传此值")
    private Integer city;

    @ApiModelProperty(value = "0:cn, 1:en")
    private Integer language;
}
