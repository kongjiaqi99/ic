package com.bhg.bhgadmin.dto.response.enquiries;

import lombok.Data;
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
public class BorrowResponse implements Serializable {

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
