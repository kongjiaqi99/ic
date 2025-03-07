package com.bhg.bhgadmin.api.dto.response.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:56
 **/
@Data
@ApiModel(description = "news detail response in Home news")
public class ApiNewsDetailResponse {

    @ApiModelProperty(value = "news id")
    private Long id;

    @ApiModelProperty(value = "news content")
    private String content;

    @ApiModelProperty(value = "create at")
    private String createAt;

    @ApiModelProperty(value = "language")
    private String language;

    @ApiModelProperty(value = "main pic")
    private String mainPic;

    @ApiModelProperty(value = "news Imgs")
    private List<String> newsImgs;

    @ApiModelProperty(value = "news type")
    private String newsType;

    @ApiModelProperty(value = "publish date")
    private String publishDate;

    @ApiModelProperty(value = "show to web flag")
    private Boolean showToWeb;

    @ApiModelProperty(value = "title")
    private String title;

    @ApiModelProperty(value = "update at")
    private String updateAt;
}
