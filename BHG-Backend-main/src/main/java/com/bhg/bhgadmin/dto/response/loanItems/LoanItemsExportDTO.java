package com.bhg.bhgadmin.dto.response.loanItems;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.LoanItemsEntity;
import com.bhg.bhgadmin.share.enums.FundsStatusEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@XmlRootElement
@NoArgsConstructor
@ApiModel(value = "LoanItemsExportDTO", description = "Loan Items ExportDTO Response")
public class LoanItemsExportDTO {

    @Excel(name = "Id")
    @ApiModelProperty("id")
    private Long id;

    @Excel(name = "Address")
    @ApiModelProperty("address")
    private String address;

    @Excel(name = "Project date")
    @ApiModelProperty("project date")
    private String projectDate;

    @Excel(name = "Loan status")
    @ApiModelProperty("loan status")
    private String loanStatus;

    @Excel(name = "Description")
    @ApiModelProperty("description")
    private String description;

    @Excel(name = "Value")
    @ApiModelProperty("value")
    private String value;

    @Excel(name = "CreateAt")
    @ApiModelProperty("createAt")
    private Date createAt;

    @Excel(name = "UpdateAt")
    @ApiModelProperty("updateAt")
    private Date updateAt;


    private String getyyyyMMdd(LocalDate date) {
        String DATE_FORMAT_PATTERN = "yyyy-MM-dd";
        return DateUtil.format(Date.from(date.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant()), FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public LoanItemsExportDTO(LoanItemsEntity entity) {
        this.id = entity.getId();
        this.address = entity.getAddress();
        this.projectDate = ObjectUtils.isNull(entity.getProjectDate()) ? null : getyyyyMMdd(entity.getProjectDate());
        this.loanStatus = EnumUtil.getEnumMessageByCode(FundsStatusEnum.class, entity.getLoanStatus());
        this.description = entity.getDescription();
        this.value = entity.getValue();
        this.createAt = ObjectUtils.isNull(entity.getCreatedAt()) ? null : entity.getCreatedAt();
        this.updateAt = ObjectUtils.isNull(entity.getUpdatedAt()) ? null : entity.getUpdatedAt();
    }

}
