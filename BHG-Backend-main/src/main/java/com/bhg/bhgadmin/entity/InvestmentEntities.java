package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.bhg.bhgadmin.config.handler.ArrayTypeHandler;
import com.bhg.bhgadmin.share.enums.EntityStatusEnum;
import com.bhg.bhgadmin.share.utils.OperationLog;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@TableName(value = "investment_entities", autoResultMap = true)
public class InvestmentEntities implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "client_id")
    private Long clientId;

    @TableField(value = "entity_type")
    private Integer entityType;

    @TableField(value = "kyc_result")
    private Boolean kycResult;
    @OperationLog(name = "Entity Name")
    @TableField(value = "entity_name")
    private String entityName;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "bsb")
    @OperationLog(name = "BSB")
    private String bsb;

    @TableField(value = "account_number")
    @OperationLog(name = "Account Number")
    private String accountNumber;

    @TableField(value = "account_name")
    @OperationLog(name = "Account Name")
    private String accountName;

    @TableField(value = "file_1_front")
    private String file1Front;

    @TableField(value = "file_1_back")
    private String file1Back;

    @TableField(value = "file_2_front")
    private String file2Front;

    @TableField(value = "file_2_back")
    private String file2Back;

    @TableField(value = "detail_info")
    private Object detailInfo;

    @TableField(value = "kyc_status")
    private Integer kycStatus;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "transcation_id")
    private String transcationId;

    @OperationLog(name = "BHG ID")
    @TableField(value = "bhg_id")
    private String bhgId;

    @OperationLog(name = "Email")
    @TableField(value = "email_list", typeHandler = ArrayTypeHandler.StrListHandler.class)
    private List<String> emailList;
    @OperationLog(name = "Address Line")
    @TableField(value = "address_line")
    private String addressLine;
    @OperationLog(name = "Suburb")
    @TableField(value = "suburb")
    private String suburb;
    @OperationLog(name = "State")
    @TableField(value = "\"state\"")
    private String state;
    @OperationLog(name = "Postcode")
    @TableField(value = "postcode")
    private String postcode;

    @TableField(value = "application_form_signed")
    private String applicationFormSigned;

    @TableField(value = "application_form_signed_two")
    private String applicationFormSignedTwo;

    @TableField(value = "application_form_signed_three")
    private String applicationFormSignedThree;

    @TableField(value = "application_form_signed_four")
    private String applicationFormSignedFour;

    /**
     * NORMAL LOCKED
     * {@link EntityStatusEnum}
     */
    @TableField(value = "status")
    private String status;

    private static final long serialVersionUID = 1L;

    @TableField(value = "withheld_tax")
    @OperationLog(name = "Withheld tax")
    private Boolean withheldTax = Boolean.FALSE;

    @TableField(value = "tf_num")
    @OperationLog(name = "Tf num")
    private String tfNum;

    @OperationLog(name = "Application Form")
    @TableField(value = "application_form_list", typeHandler = ArrayTypeHandler.StrListHandler.class)
    private List<String> applicationFormList;


}