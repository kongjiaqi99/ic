package com.ic.icadmin.dto.response.newsImgs;

import cn.afterturn.easypoi.excel.annotation.Excel;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@XmlRootElement
@NoArgsConstructor
@ApiModel(value = "NewsImgsExportDTO", description = "News Imgs Export DTO")
public class NewsImgsExportDTO {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "News title")
    private String newsTitle;

    @Excel(name = "Img")
    private String img;

    @Excel(name = "Display order")
    private Integer displayOrder;

    @Excel(name = "Create at")
    private Date createAt;

    @Excel(name = "Update at")
    private Date updateAt;
}
