package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.bhg.bhgadmin.share.utils.OperationLog;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "financings")
public class FinancingsEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "client_id")
    private Long clientId;

    @TableField(value = "fund_id")
    private Long fundId;

    @TableField(value = "financing_amount")
    @OperationLog(name = "financing_amount")
    private BigDecimal financingAmount;

    @TableField(value = "commission_rate")
    @OperationLog(name = "commission_rate")
    private BigDecimal commissionRate;

    @TableField(value = "commission_amount")
    @OperationLog(name = "commission_amount")
    private BigDecimal commissionAmount;

    @TableField(value = "currency")
    @OperationLog(name = "currency")
    private String currency;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "referral_agreement")
    @OperationLog(name = "referral_agreement")
    private String referralAgreement;

    @TableField(value = "target_amount")
    @OperationLog(name = "target_amount")
    private BigDecimal targetAmount;

    @TableField(value = "target_date")
    @OperationLog(name = "target_date")
    private Date targetDate;

    @TableField(value = "achieve_target")
    @OperationLog(name = "achieve_target")
    private Boolean achieveTarget;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "gst")
    @OperationLog(name = "gst")
    private Boolean gst = Boolean.FALSE;

    @TableField(value = "entity_id")
    private Long entityId;

    @TableField(exist = false)
    @OperationLog(name = "entity")
    private String entity;

    @TableField(exist = false)
    @OperationLog(name = "client")
    private String client;

    @TableField(exist = false)
    @OperationLog(name = "fund")
    private String fund;
    private static final long serialVersionUID = 1L;

}