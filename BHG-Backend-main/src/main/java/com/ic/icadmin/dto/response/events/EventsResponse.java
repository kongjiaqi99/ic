package com.ic.icadmin.dto.response.events;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.ic.icadmin.entity.EventsEntity;
import com.ic.icadmin.share.enums.EventCityEnum;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.Locale;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "EventsResponse", description = "Events Response")
public class EventsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("startTime")
    private String startTime;

    @ApiModelProperty("city")
    private String city;

    @ApiModelProperty("location")
    private String location;

    @ApiModelProperty("brief Introduction")
    private String briefIntroduction;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("main img")
    private String mainImg;

    @ApiModelProperty("trans")
    private Long transId;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("status")
    private String status;

    @ApiModelProperty("file_url")
    private String fileUrl;

    @ApiModelProperty("type")
    private String type;

    @ApiModelProperty("link")
    private String link;

    @ApiModelProperty("readFlag")
    private boolean readFlag;

    private void setCreateAt(Date createAt) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    private void setStartTime(Date endDate) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.startTime = ObjectUtils.isNull(endDate) ? null : DateUtil.format(endDate,FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public EventsResponse(EventsEntity entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        setStartTime(entity.getStartTime());
        this.city = EnumUtil.getEnumMessageByCode(EventCityEnum.class, entity.getCity());
        this.location = entity.getLocation();
        this.briefIntroduction = entity.getBriefIntroduction();
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
        this.transId = entity.getTransId();
        setCreateAt(entity.getCreatedAt());
        this.status = entity.getStatus();
        this.type = entity.getType();
        this.link = entity.getLink();
    }

}
