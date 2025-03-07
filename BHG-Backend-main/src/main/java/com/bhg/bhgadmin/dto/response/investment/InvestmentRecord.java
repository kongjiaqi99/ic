package com.bhg.bhgadmin.dto.response.investment;

import com.google.common.collect.Lists;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
public class InvestmentRecord {
    @ApiModelProperty("payment Date")
    private LocalDate paymentDate;

    @ApiModelProperty("current Return")
    private BigDecimal currentReturn;

    @ApiModelProperty("Investment Amount")
    private BigDecimal investmentAmount;

    @ApiModelProperty("closing Balance")
    private BigDecimal closingBalance;

    @ApiModelProperty("id list")
    private List<Long> idList;

    @ApiModelProperty("month")
    private LocalDate month;

    private BigDecimal tax;

    //扣税前
    private BigDecimal beforeDivide;

    public void addCurrentReturn(BigDecimal account) {
        if (account != null) {
            if (currentReturn == null) {
                currentReturn = account;
            } else {
                currentReturn = currentReturn.add(account);
            }
        }
    }

    public void addInvestmentAmount(BigDecimal account) {
        if (account != null) {
            if (investmentAmount == null) {
                investmentAmount = account;
            } else {
                investmentAmount = investmentAmount.add(account);
            }
        }
    }

    public void addId(Long id) {
        if (id != null) {
            if (idList == null) {
                idList = Lists.newArrayList(id);
            } else {
                idList.add(id);
            }
        }
    }

    public void addClosingBalance(BigDecimal account) {
        if (account != null) {
            if (closingBalance == null) {
                closingBalance = account;
            } else {
                closingBalance = closingBalance.add(account);
            }
        }
    }

    public void addTax(BigDecimal tax) {
        if (tax != null) {
            if (this.tax == null) {
                this.tax = tax;
            } else {
                this.tax = this.tax.add(tax);
            }
        }
    }

    public void addBeforeDivide(BigDecimal beforeDivide) {
        if (beforeDivide != null) {
            if (this.beforeDivide == null) {
                this.beforeDivide = beforeDivide;
            } else {
                this.beforeDivide = this.beforeDivide.add(beforeDivide);
            }
        }
    }
}
