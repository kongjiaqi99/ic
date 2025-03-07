package com.bhg.bhgadmin.dto.response.purchasedFunds;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.annotation.TableField;
import com.bhg.bhgadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@XmlRootElement
@NoArgsConstructor
@ApiModel(value = "PurchasedFundsExportDTO", description = "Purchased Funds Export DTO")
public class PurchasedFundsExportDTO {

    @Excel(name = "Fund Name")
    private String fundName;

    @Excel(name = "BHG Id")
    private String bhgId;
    @Excel(name = "BSB")
    private String bsb;

    @Excel(name = "Account Number")
    private String accountNumber;

    @Excel(name = "Account Name")
    private String accountName;
    @Excel(name = "Unit certificate date")
    private LocalDate unitCertificateDate;

    @Excel(name = "Transaction date")
    private LocalDate transactionDate;

    @Excel(name = "Purchase end date")
    private LocalDate purchaseEndDate;

    @Excel(name = "Purchase amount")
    private BigDecimal purchasedAmount;

    @Excel(name = "Current Monthly Return")
    private BigDecimal currentReturn;


    @Excel(name = "Withholding Tax")
    private BigDecimal withholdingTax;
    @Excel(name = "Net Interest")
    private BigDecimal netInterest;
    @Excel(name = "Total Return")
    private BigDecimal currentTotalReturn;
    @Excel(name = "Unit certi")
    private String unitCerti;

    @Excel(name = "Application form")
    private String applicationForm;

    @Excel(name = "Entity name")
    private String entityName;

    @Excel(name = "Address line")
    private String addressLine;

    @Excel(name = "Suburb")
    private String suburb;

    @Excel(name = "State")
    private String state;

    @Excel(name = "Post code")
    private String postCode;

    @Excel(name = "days")
    private Integer days;
    @Excel(name = "month Start")
    private Date monthStart;
    @Excel(name = "month End")
    private Date monthEnd;




}
