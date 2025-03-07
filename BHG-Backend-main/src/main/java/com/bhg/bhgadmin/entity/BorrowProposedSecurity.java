package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-11-02
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("borrow_proposed_security")
@ApiModel(value="BorrowProposedSecurity对象", description="")
public class BorrowProposedSecurity implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Long enquiryId;

    private String ownerName;

    private String houseType;

    private String loanPurpose;

    private String landArea;

    private String estValue;

    private Date valuationDate;

    private String valuationEntity;

    private String securityStatus;

    private String borrowAmount;

    private String lenderName;

    private String inArrears;

    private String reason;


}
