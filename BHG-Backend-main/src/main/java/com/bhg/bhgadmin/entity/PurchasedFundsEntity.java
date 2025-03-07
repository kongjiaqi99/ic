package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.bhg.bhgadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "purchased_funds", autoResultMap = true)
public class PurchasedFundsEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "client_id")
    private Long clientId;

    @TableField(value = "fund_id")
    private Long fundId;

    @TableField(value = "unit_certificate_date")
    @OperationLog(name = "unit_certificate_date")
    private Date unitCertificateDate = new Date();

    @TableField(value = "purchase_amount")
    @OperationLog(name = "purchase_amount")
    private BigDecimal purchaseAmount;

    @TableField(value = "current_return")
    @OperationLog(name = "current_return")
    private BigDecimal currentReturn;

    @TableField(value = "dividend_amount")
    @OperationLog(name = "dividend_amount")
    private BigDecimal dividendAmount;

    @TableField(value = "dividend_cycle")
    @OperationLog(name = "dividend_cycle")
    private String dividendCycle;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "unit_certi")
    @OperationLog(name = "unit_certi")
    private String unitCerti;

    @TableField(value = "entity_name")
    @OperationLog(name = "entity_name")
    private String entityName;

    @TableField(value = "address_line")
    @OperationLog(name = "address_line")
    private String addressLine;

    @TableField(value = "suburb")
    @OperationLog(name = "suburb")
    private String suburb;

    @TableField(value = "\"state\"")
    @OperationLog(name = "\"state\"")
    private String state;

    @TableField(value = "postcode")
    @OperationLog(name = "postcode")
    private String postcode;

    @TableField(value = "country")
    @OperationLog(name = "country")
    private String country;

    @TableField(value = "investment_entity_id")
    private Long investmentEntityId;

    @TableField(value = "uc_no")
    @OperationLog(name = "uc_no")
    private String ucNo;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "purchase_end_date")
    @OperationLog(name = "purchase_end_date")
    private Date purchaseEndDate;

    @TableField(value = "transaction_date")
    @OperationLog(name = "transaction_date")
    private Date transactionDate;

    @TableField(value = "application_form_signed")
    @OperationLog(name = "application_form_signed")
    private String applicationFormSigned;

    @TableField(exist = false)
    @OperationLog(name = "client")
    private String clientName;

    @TableField(exist = false)
    @OperationLog(name = "fund")
    private String fundName;

    @TableField(exist = false)
    @OperationLog(name = "investment")
    private String investmentEntityName;

    private static final long serialVersionUID = 1L;
    @TableField(value = "application_form_signed_two")
    @OperationLog(name = "application_form_signed_two")
    private String applicationFormSignedTwo;
    @TableField(value = "application_form_signed_three")
    @OperationLog(name = "application_form_signed_three")
    private String applicationFormSignedThree;
    @TableField(value = "application_form_signed_four")
    @OperationLog(name = "application_form_signed_four")
    private String applicationFormSignedFour;



}