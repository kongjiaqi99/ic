package com.ic.icadmin.dto.response.news;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.ic.icadmin.entity.NewsEntity;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.enums.NewsTypeEnum;
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
@ApiModel(value = "ApiNewsDetailResponse", description = "News Response")
public class NewsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("publish Date")
    private String publishDate;

    @ApiModelProperty("content")
    private String content;

    @ApiModelProperty("mainPic")
    private String mainPic;

    @ApiModelProperty("showToWeb")
    private Boolean showToWeb;

    @ApiModelProperty("news Type")
    private String newsType;

    @ApiModelProperty("language")
    private String language;

    private String getMMMddyyyy(Date date) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy";
        return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public NewsResponse(NewsEntity entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.publishDate = ObjectUtils.isNull(entity.getPublishDate()) ? null : getMMMddyyyy(entity.getPublishDate());
        this.content = entity.getContent();
        this.showToWeb = entity.getShowToWeb();
        this.newsType = EnumUtil.getEnumMessageByCode(NewsTypeEnum.class, entity.getNewsType());
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
    }

}
