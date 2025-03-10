package com.ic.icadmin.dto.request.newsImgs;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "NewsImgsQueryRequest", description = "News Imgs Query Request")
public class NewsImgsQueryRequest {

    @ApiModelProperty("news Id")
    private Long id;

}
