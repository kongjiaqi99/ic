package com.bhg.bhgadmin.dto.response.loanItems;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.LoanItemsEntity;
import com.bhg.bhgadmin.share.enums.FundsStatusEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

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
@ApiModel(value = "LoanItemsResponse", description = "Loan Items Response")
public class LoanItemsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("address")
    private String address;

    @ApiModelProperty("project date")
    private String projectDate;

    @ApiModelProperty("loan status")
    private String loanStatus;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("value")
    private String value;

    @ApiModelProperty("createAt")
    private String createAt;

    @ApiModelProperty("updateAt")
    private String updateAt;


    private String getMMMddyyyy(LocalDate date) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy";
        return DateUtil.format(Date.from(date.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant()), FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    private String getHHmm(Date date) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public LoanItemsResponse(LoanItemsEntity entity) {
        this.id = entity.getId();
        this.address = entity.getAddress();
        this.projectDate = ObjectUtil.isNotNull(entity.getProjectDate()) ? getMMMddyyyy(entity.getProjectDate()) : null;
        this.loanStatus = EnumUtil.getEnumMessageByCode(FundsStatusEnum.class, entity.getLoanStatus());
        this.description = entity.getDescription();
        this.value = entity.getValue();
        this.createAt = ObjectUtils.isNull(entity.getCreatedAt()) ? null : getHHmm(entity.getCreatedAt());
        this.updateAt = ObjectUtils.isNull(entity.getUpdatedAt()) ? null : getHHmm(entity.getUpdatedAt());
    }

}
