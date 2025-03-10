package com.ic.icadmin.dto.response.financings;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.ic.icadmin.entity.FinancingsEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-03 23:00
 **/
@Data
@XmlRootElement
@NoArgsConstructor
public class FinancingsExportDTO {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Financing amount")
    private BigDecimal financingAmount;

    @Excel(name = "Commission rate")
    private BigDecimal commissionRate;

    @Excel(name = "Commission Amount")
    private BigDecimal commissionAmount;

    @Excel(name = "Currency")
    private String currency;

    @Excel(name = "Create at")
    private Date createAt;

    @Excel(name = "Update at")
    private Date updateAt;

    @Excel(name = "Referral agreement")
    private String referralAgreement;

    @Excel(name = "target Amount")
    private BigDecimal targetAmount;

    @Excel(name = "target Date")
    private Date targetDate;

    @Excel(name = "achieve Target")
    private Boolean achieveTarget;

    public FinancingsExportDTO(FinancingsEntity entity) {
        this.id = entity.getId();
        this.financingAmount = entity.getFinancingAmount();
        this.commissionRate = entity.getCommissionRate();
        this.commissionAmount = entity.getCommissionAmount();
        this.currency = entity.getCurrency();
        this.createAt = entity.getCreatedAt();
        this.updateAt = entity.getUpdatedAt();
        this.targetAmount = entity.getTargetAmount();
        this.targetDate = entity.getTargetDate();
        this.achieveTarget = entity.getAchieveTarget();
    }

    public FinancingsExportDTO(FinancingsResponse entity) {
        this.id = entity.getId();
        this.financingAmount = entity.getFinancingAmount();
        this.commissionRate = entity.getCommissionRate();
        this.commissionAmount = entity.getCommissionAmount();
        this.currency = entity.getCurrency();
        this.createAt = entity.getCreateAtDate();
        this.updateAt = entity.getUpdateAtDate();
        this.targetAmount = entity.getTargetAmount();
    }
}
