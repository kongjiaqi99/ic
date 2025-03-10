package com.ic.icadmin.dto.biz;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ic.icadmin.config.handler.ArrayTypeHandler;
import com.ic.icadmin.entity.PurchasedFundsEntity;
import com.ic.icadmin.share.utils.OperationLog;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-17 16:56
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@TableName(value = "purchased_funds", autoResultMap = true)
public class BizPurchasedFundsDTO extends PurchasedFundsEntity {

    private String clientEmail;

    private String fundNameCN;

    private Integer bFundCategory;

    private Integer bProjectDurationMonth;

    private BigDecimal bYearlyReturnRate;

    private Date endDate;

    private Date settlementDate;

    private Date interestStartDate;

    private BigDecimal commissionRate;

    private BigDecimal targetAmount;

    @TableField(typeHandler = ArrayTypeHandler.StrListHandler.class)
    private List<String> emailList;

    private String icId;

    private Date extendStartDate;

    private Date defaultStartDate;

    private BigDecimal bDelayedGrowthRate;

    private Date fundCreateAt;

    private Date monthStart;
    private Date monthEnd;
    private Integer days;
    private Boolean withheldTax = Boolean.FALSE;

    private String bsb;

    private String accountNumber;

    private String accountName;
}
