package com.ic.icadmin.api.dto.response.activities;

import com.ic.icadmin.share.enums.EventStatusEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 09:30
 **/
@Data
@ApiModel(description = "Recent Activities Query Response")
public class RecentActivitiesQueryResponse {

    @ApiModelProperty(value = "Event Id")
    private Long id;

    @ApiModelProperty(value = "Title")
    private String title;

    @ApiModelProperty(value = "Time")
    private String time;

    @ApiModelProperty(value = "Location")
    private String location;

    @ApiModelProperty(value = "Main Pic")
    private String mainPic;

    @ApiModelProperty(value = "Description")
    private String description;

    @ApiModelProperty(value = "ActivityStatus")
    private EventStatusEnum activityStatus;
}
