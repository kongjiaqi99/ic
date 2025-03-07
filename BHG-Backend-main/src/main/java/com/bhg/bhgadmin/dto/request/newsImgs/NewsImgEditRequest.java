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
@ApiModel(value = "NewsImgEditRequest", description = "News Img Edit Request")
public class NewsImgEditRequest extends NewsImgCreateRequest {

    @NotNull
    @ApiModelProperty("Id")
    private Long id;

}
