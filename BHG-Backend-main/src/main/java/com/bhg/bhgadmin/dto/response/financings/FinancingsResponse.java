package com.bhg.bhgadmin.dto.response.financings;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.FinancingsEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "FinancingsResponse", description = "Financings Response")
public class FinancingsResponse {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("client Id")
    private Long clientId;

    @ApiModelProperty("client name")
    private String clientName;

    @ApiModelProperty("fund Id")
    private Long fundId;

    @ApiModelProperty("fund name")
    private String fundName;

    @ApiModelProperty("fund name CN")
    private String fundNameCN;

    @ApiModelProperty("commission rate")
    private BigDecimal commissionRate;

    @ApiModelProperty("commission Amount")
    private BigDecimal commissionAmount;

    @ApiModelProperty("target Amount")
    private BigDecimal targetAmount;

    @ApiModelProperty("total financing amount")
    private BigDecimal financingAmount;

    @ApiModelProperty("currency")
    private String currency;

    private Date createAtDate;
    private Date updateAtDate;

    @ApiModelProperty("create at")
    private String createAt;

    private BigDecimal bYearlyReturnRate;

    @ApiModelProperty(value = "gst")
    private Boolean gst = Boolean.FALSE;

    @ApiModelProperty(value = "refResponseList")
    private List<FinanceRefResponse> refResponseList;

    @ApiModelProperty("entity Id")
    private Long entityId;

    @ApiModelProperty("entity name")
    private String entityName;


    public void setCreateAt(Date createAt) {
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public FinancingsResponse(FinancingsEntity entity) {
        this.id = entity.getId();
        this.clientId = entity.getClientId();
        this.fundId = entity.getFundId();
        this.commissionRate = entity.getCommissionRate();
        this.commissionAmount = entity.getCommissionAmount();
        this.targetAmount = entity.getTargetAmount();
        this.financingAmount = entity.getFinancingAmount();
        this.currency = entity.getCurrency();
        this.gst = entity.getGst();
        this.entityId = entity.getEntityId();
        setCreateAt(entity.getCreatedAt());
    }
}
