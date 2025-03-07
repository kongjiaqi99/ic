package com.bhg.bhgadmin.dto.response.news;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.NewsEntity;
import com.bhg.bhgadmin.share.enums.LanguageEnum;
import com.bhg.bhgadmin.share.enums.NewsTypeEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@XmlRootElement
@NoArgsConstructor
@ApiModel(value = "NewsExportDTO", description = "News Export DTO")
public class NewsExportDTO {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Publish date")
    private LocalDate publishDate;

    @Excel(name = "Title")
    private String title;

    @Excel(name = "Content")
    private String content;

    @Excel(name = "Main pic")
    private String mainPic;

    @Excel(name = "Show to web")
    private Boolean showToWeb;

    @Excel(name = "Create at")
    private Date createAt;

    @Excel(name = "Update at")
    private Date updateAt;

    @Excel(name = "news Type")
    private String newsType;

    @Excel(name = "language")
    private String language;

    public NewsExportDTO(NewsEntity entity) {
        this.id = entity.getId();
        this.publishDate = ObjectUtils.isNotNull(entity.getPublishDate()) ?
            entity.getPublishDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate() : null;
        this.title = entity.getTitle();
        this.content = entity.getContent();
        this.showToWeb = entity.getShowToWeb();
        this.createAt = ObjectUtils.isNull(entity.getCreatedAt()) ? null : entity.getCreatedAt();
        this.updateAt = ObjectUtils.isNull(entity.getUpdatedAt()) ? null : entity.getUpdatedAt();
        this.newsType = EnumUtil.getEnumMessageByCode(NewsTypeEnum.class, entity.getNewsType());
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
    }

}
