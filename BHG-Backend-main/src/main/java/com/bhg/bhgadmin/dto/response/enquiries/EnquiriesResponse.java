package com.bhg.bhgadmin.dto.response.enquiries;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.EnquiriesEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "EnquiriesResponse", description = "Enquiries Response")
public class EnquiriesResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("Name")
    private String name;

    @ApiModelProperty("Message")
    private String message;

    @ApiModelProperty("create at")
    private String createAt;

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

    private void setCreateAt(Date createAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public EnquiriesResponse(EnquiriesEntity enquiriesEntity) {
        this.id = enquiriesEntity.getId();
        this.email = enquiriesEntity.getEmail();
        this.name = enquiriesEntity.getName();
        this.message = enquiriesEntity.getMessage();
        this.type = enquiriesEntity.getType();
        this.broker = enquiriesEntity.getBroker();
        setCreateAt(enquiriesEntity.getCreatedAt());
    }

}
