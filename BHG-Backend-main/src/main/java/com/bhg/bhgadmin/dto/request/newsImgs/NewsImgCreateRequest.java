package com.bhg.bhgadmin.dto.request.newsImgs;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "NewsImgCreateRequest", description = "News Img Create Request")
public class NewsImgCreateRequest {

    @NotNull
    @ApiModelProperty("news Id")
    private Long newsId;

    @ApiModelProperty("display order")
    private Integer displayOrder;

}
