package com.bhg.bhgadmin.dto.request.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "NewsQueryRequest", description = "News Query Request")
public class NewsQueryRequest {

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("news type")
    private Integer newsType;

    @ApiModelProperty("language")
    private Integer language;

    @ApiModelProperty("show to web")
    private Boolean showToWeb;

}
