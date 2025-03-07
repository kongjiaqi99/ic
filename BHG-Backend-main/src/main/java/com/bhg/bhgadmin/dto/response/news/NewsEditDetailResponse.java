package com.bhg.bhgadmin.dto.response.news;

import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.NewsEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;
import java.time.ZoneId;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "NewsEditDetailResponse", description = "News Detail Response when edit")
public class NewsEditDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("content")
    private String content;

    @ApiModelProperty("publish Date")
    private LocalDate publishDate;

    @ApiModelProperty("showToWeb")
    private Boolean showToWeb;

    @ApiModelProperty("news Type")
    private String newsType;

    @ApiModelProperty("language")
    private String language;

    public NewsEditDetailResponse(NewsEntity entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.content = entity.getContent();
        this.publishDate = ObjectUtils.isNotNull(entity.getPublishDate()) ?
            entity.getPublishDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate() : null;
        this.showToWeb = entity.getShowToWeb();
        this.newsType = ObjectUtils.isNull(entity.getNewsType()) ? null : entity.getNewsType().toString();
        this.language = ObjectUtils.isNull(entity.getLanguage()) ? null : entity.getLanguage().toString();
    }
}
