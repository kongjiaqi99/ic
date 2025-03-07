package com.bhg.bhgadmin.dto.response.events;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "EventEditDetailResponse", description = "Event Detail Response when edit")
public class EventEditDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("startTime")
    private Date startTime;

    @ApiModelProperty("city")
    private String city;

    @ApiModelProperty("location")
    private String location;

    @ApiModelProperty("brief Introduction")
    private String briefIntroduction;

    @ApiModelProperty("main img")
    private String mainImg;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("trans")
    private Long transId;

    @ApiModelProperty("status")
    private String status;

    @ApiModelProperty("file_url")
    private String fileUrl;

    @ApiModelProperty("type")
    private String type;

    @ApiModelProperty("link")
    private String link;
}
