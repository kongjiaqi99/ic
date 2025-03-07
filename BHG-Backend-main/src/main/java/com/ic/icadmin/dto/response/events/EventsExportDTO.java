package com.ic.icadmin.dto.response.events;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.ic.icadmin.entity.EventsEntity;
import com.ic.icadmin.share.enums.EventCityEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

@Data
@XmlRootElement
@NoArgsConstructor
public class EventsExportDTO implements Serializable {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Title")
    private String title;

    @Excel(name = "Start time")
    private Date startTime;

    @Excel(name = "City")
    private String city;

    @Excel(name = "Location")
    private String location;

    @Excel(name = "Brief introduction")
    private String briefIntroduction;

    @Excel(name = "Language")
    private String language;

    @Excel(name = "Main img")
    private String mainImg;

    @Excel(name = "status")
    private String status;

    @Excel(name = "file_url")
    private String fileUrl;

    @Excel(name = "type")
    private String type;

    @Excel(name = "link")
    private String link;

    @Excel(name = "Created at")
    private Date createdAt;

    @Excel(name = "Updated at")
    private Date updatedAt;

    private static final long serialVersionUID = 1L;

    public EventsExportDTO(EventsEntity entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.startTime = entity.getStartTime();
        this.city = EnumUtil.getEnumMessageByCode(EventCityEnum.class, entity.getCity());
        this.location = entity.getLocation();
        this.briefIntroduction = entity.getBriefIntroduction();
        this.language = EnumUtil.getEnumMessageByCode(EventCityEnum.class, entity.getLanguage());
        this.createdAt = entity.getCreatedAt();
        this.updatedAt = entity.getUpdatedAt();
    }
}