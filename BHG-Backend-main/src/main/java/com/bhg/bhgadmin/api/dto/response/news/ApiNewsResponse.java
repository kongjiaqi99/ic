package com.bhg.bhgadmin.api.dto.response.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:56
 **/
@Data
@ApiModel(description = "news response in Home news")
public class ApiNewsResponse {

    @ApiModelProperty(value = "news id")
    private Long id;

    @ApiModelProperty(value = "create at")
    private String createAt;

    @ApiModelProperty(value = "main pic")
    private String mainPic;

    @ApiModelProperty(value = "news type")
    private String newsType;

    @ApiModelProperty(value = "publish date")
    private String publishDate;

    @ApiModelProperty(value = "title")
    private String title;

    @ApiModelProperty(value = "update at")
    private String updateAt;
}
