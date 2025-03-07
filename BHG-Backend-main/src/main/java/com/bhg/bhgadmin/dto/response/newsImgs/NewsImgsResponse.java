package com.bhg.bhgadmin.dto.response.newsImgs;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "NewsImgsResponse", description = "News Imgs Response")
public class NewsImgsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("news id")
    private Long newsId;

    @ApiModelProperty("news title")
    private String newsTitle;

    @ApiModelProperty("display Order")
    private Integer displayOrder;

    @ApiModelProperty("img")
    private String img;

}
