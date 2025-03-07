package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.ic.icadmin.share.enums.EnquiryStatusEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "enquiries")
public class EnquiriesEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "\"name\"")
    private String name;

    @TableField(value = "message")
    private String message;

    @TableField(value = "email")
    private String email;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "phone")
    private String phone;

    @TableField(value = "interest")
    private String interest;

    @TableField(value = "suburb")
    private String suburb;

    @TableField(value = "\"state\"")
    private String state;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    /**
     * NEW HANDLED
     * {@link EnquiryStatusEnum}
     */
    @TableField(value = "\"status\"")
    private String status;

    @TableField(value = "\"type\"")
    private Integer type;

    private Long fundId;

    private Integer investorType;

    private Integer investmentTerm;

    private BigDecimal investmentAmount;

    private String guarantor;

    private String acn;

    private String borrowType;

    private String borrowPurpose;

    private Integer borrowTerm;

    private String borrowAmount;

    private Date borrowDate;

    private String borrowPrimary;

    private String borrowSecondary;

    private String borrowTertiary;

    private String borrowAdditional;

    private String broker;

    private String intentionFile;
    private String valuationFile;
    private String borrowFile;
    private String asicFile;
    private String idFile;
    private String houseFile;
    private String investFile;
    private String carFile;
    private String loanFile;
    private String leaseFile;
    private String cardFile;
    private static final long serialVersionUID = 1L;
}

