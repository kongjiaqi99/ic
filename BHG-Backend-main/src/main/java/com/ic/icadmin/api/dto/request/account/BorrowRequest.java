package com.ic.icadmin.api.dto.request.account;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-11-02
 */
@Data
@Accessors(chain = true)
public class BorrowRequest implements Serializable {

    private static final long serialVersionUID=1L;

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
