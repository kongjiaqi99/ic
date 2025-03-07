package com.bhg.bhgadmin.api.dto.request.account;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "ClientLoginRequest", description = "login parameter")
public class ClientSubmitEnquiryRequest {

    @ApiModelProperty(value = "name")
    @NotBlank
    private String name;

    @ApiModelProperty(value = "email")
    @Email
    private String email;

    @ApiModelProperty(value = "phone")
    @NotBlank
    private String phone;

    @ApiModelProperty(value = "message")
    private String message;

    @ApiModelProperty(value = "suburb")
    private String suburb;

    @ApiModelProperty(value = "state")
    private String state;

    @ApiModelProperty(value = "type", notes = "1 general, 2 investment, 3 borrow ")
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

    private String borrowDate;

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
    private List<BorrowRequest> borrowList;
}
