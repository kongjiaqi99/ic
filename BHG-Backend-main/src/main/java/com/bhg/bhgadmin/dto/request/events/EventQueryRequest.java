package com.bhg.bhgadmin.dto.request.events;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "EventQueryRequest", description = "Event Query Request")
public class EventQueryRequest {

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("location")
    private String location;

    @ApiModelProperty("type")
    private String type;

    @ApiModelProperty("status")
    private String status;

    @ApiModelProperty("language")
    private Integer language;

    @ApiModelProperty("readFlag")
    private Boolean readFlag;
}
