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
@ApiModel(value = "NewsNamesResponse", description = "News Names Response")
public class NewsNamesResponse {

    @ApiModelProperty("news id")
    private Long id;

    @ApiModelProperty("news title")
    private String newsTitle;

}
