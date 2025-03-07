package com.bhg.bhgadmin.dto.response.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-10 23:39
 **/
@Data
@ApiModel(value = "NewsImgsUrl", description = "News Imgs Url in News Detail")
public class NewsImgsUrl {

    @ApiModelProperty("News img id")
    private Long id;

    @ApiModelProperty("Img")
    private String img;
}
