package com.bhg.bhgadmin.dto.response.enquiries;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.EnquiriesEntity;
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
 * @create: 2022-11-21 20:34
 **/
@Data
@NoArgsConstructor
@ApiModel(value = "EnquiryDetailResponse", description = "Enquiries Detail Response")
public class EnquiryDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("Name")
    private String name;

    @ApiModelProperty("Message")
    private String message;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("update at")
    private String updateAt;

    @ApiModelProperty("phone")
    private String phone;

    @ApiModelProperty("interest")
    private String interest;

    @ApiModelProperty("suburb")
    private String suburb;

    @ApiModelProperty("state")
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

    private Date borrowDate;

    private String borrowPrimary;

    private String borrowSecondary;

    private String borrowTertiary;

    private String borrowAdditional;

    private String broker;

    private List<BorrowResponse> borrowList;

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

    public void setCreateAt(Date createAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public void setUpdateAt(Date updateAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(updateAt) ? null : DateUtil.format(updateAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }


}
