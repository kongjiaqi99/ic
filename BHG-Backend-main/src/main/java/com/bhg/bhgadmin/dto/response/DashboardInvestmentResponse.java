package com.bhg.bhgadmin.dto.response;

import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:33
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "DashboardInvestmentResponse", description = "Dashboard Investment response")
public class DashboardInvestmentResponse {

    @ApiModelProperty("total_investment")
    private BigDecimal totalInvestment = BigDecimal.ZERO;

    @ApiModelProperty("client_num")
    private Integer clientNum = 0;

    @ApiModelProperty("investment_return")
    private BigDecimal investmentReturn = BigDecimal.ZERO;
    //计算结束时间
    @ApiModelProperty("end_local_date")
    private LocalDate endLocalDate;

    //显示的月份 计算开始时间
    @ApiModelProperty("start_local_date")
    private LocalDate startLocalDate;

    @ApiModelProperty("date_str")
    private String dateStr;

    public void addTotalInvestment(BigDecimal investment) {
        this.totalInvestment = this.totalInvestment.add(investment);
    }

    public void addInvestmentReturn(BigDecimal investmentReturn) {
        this.investmentReturn = this.investmentReturn.add(investmentReturn);
    }

    public String getDateStr() {
        return DateFormatUtil.getMMMYyyy(startLocalDate);
    }

}
