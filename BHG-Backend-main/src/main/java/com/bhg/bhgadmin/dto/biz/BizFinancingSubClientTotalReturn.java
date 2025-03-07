package com.bhg.bhgadmin.dto.biz;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-03 15:13
 **/
@Data
public class BizFinancingSubClientTotalReturn {

    private Long clientId;

    private Long entityId;
    private Integer level;

    private String entityName;

    private String clientName;

    private Long pid;

    private Date purchasedDate;

    private BigDecimal purchasedAmount;

    private BigDecimal currentTotalReturn;

    private BigDecimal commissionRate;

    private BigDecimal commissionTotalReturn;

    private BigDecimal commissionTargetReturn;

    private BigDecimal commissionMonthReturn;

}
