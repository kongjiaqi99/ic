package com.ic.icadmin.dto.request.news;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "NewsEditRequest", description = "News Edit Request")
public class NewsEditRequest extends NewsCreateRequest {

    @NotNull
    @ApiModelProperty("id")
    private Long id;
}
