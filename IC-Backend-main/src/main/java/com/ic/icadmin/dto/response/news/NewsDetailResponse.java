package com.ic.icadmin.dto.response.news;

import cn.hutool.core.collection.CollectionUtil;
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
import java.util.List;
import java.util.Locale;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "ApiNewsDetailResponse", description = "News Detail Response")
public class NewsDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("title")
    private String title;

    @ApiModelProperty("content")
    private String content;

    @ApiModelProperty("mainPic")
    private String mainPic;

    @ApiModelProperty("publish Date")
    private String publishDate;

    @ApiModelProperty("showToWeb")
    private Boolean showToWeb;

    @ApiModelProperty("news Type")
    private String newsType;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("news Imgs")
    private List<NewsImgsUrl> newsImgs;

    private String getMMMddyyyy(Date date) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy";
        return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public NewsDetailResponse(NewsEntity entity, List<NewsImgsUrl> newsImgs) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.publishDate = ObjectUtils.isNull(entity.getPublishDate()) ? null : getMMMddyyyy(entity.getPublishDate());
        this.content = entity.getContent();
        this.showToWeb = entity.getShowToWeb();
        this.newsType = EnumUtil.getEnumMessageByCode(NewsTypeEnum.class, entity.getNewsType());
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
        if (CollectionUtil.isNotEmpty(newsImgs)) {
            this.newsImgs = newsImgs;
        }
    }

}
