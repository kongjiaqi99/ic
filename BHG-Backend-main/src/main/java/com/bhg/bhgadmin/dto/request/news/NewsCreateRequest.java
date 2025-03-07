package com.bhg.bhgadmin.dto.request.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "NewsCreateRequest", description = "News Create Request")
public class NewsCreateRequest {

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("content")
    private String content;

    @ApiModelProperty("publish Date")
    private String publishDate;

    @ApiModelProperty("showToWeb")
    private Boolean showToWeb;

    @ApiModelProperty("news Type")
    private Integer newsType;

    @ApiModelProperty("language")
    private Integer language;


}
