package com.ic.icadmin.dto.response.funds;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.ic.icadmin.entity.FundsEntity;
import com.ic.icadmin.share.enums.FundCategoryEnum;
import com.ic.icadmin.share.enums.FundsStatusEnum;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@XmlRootElement
@NoArgsConstructor
public class FundsExportDTO {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Name")
    private String name;
    @Excel(name = "company")
    private String company;
    @Excel(name = "Description")
    private String description;

    @Excel(name = "Settlement date")
    private Date settlementDate;

    @Excel(name = "Interest starts date")
    private Date interestStartsDate;

    @Excel(name = "Amount")
    private BigDecimal amount;

    @Excel(name = "currency")
    private String currency;

    @Excel(name = "Fund type")
    private String fundType;

    @Excel(name = "Investment type")
    private String investmentType;

    @Excel(name = "Product type")
    private String productType;

    @Excel(name = "Purchase min amount")
    private String purchaseMinAmount;

    @Excel(name = "Application fee rate")
    private String applicationFeeRate;

    @Excel(name = "Management fee rate")
    private String managementFeeRate;

    @Excel(name = "Im file path")
    private String imFilePath;

    @Excel(name = "Introduce file path")
    private String introduceFilePath;

    @Excel(name = "Eoi file path")
    private String eoiFilePath;

    @Excel(name = "Create at")
    private String createAt;

    @Excel(name = "Update at")
    private String updateAt;

    @Excel(name = "Report file path")
    private String reportFilePath;

    @Excel(name = "Language")
    private String language;

    @Excel(name = "Additional investment file")
    private String additionalInvestmentFile;

    @Excel(name = "Constitution file")
    private String constitutionFile;

    @Excel(name = "B fund category")
    private String BFundCategory;

    @Excel(name = "B project duration month")
    private Integer BProjectDurationMonth;

    @Excel(name = "B yearly return rate")
    private BigDecimal BYearlyReturnRate;

    @Excel(name = "Fully subscription")
    private Boolean fullySubscription;

    @Excel(name = "Fund status")
    private String fundStatus;

    @Excel(name = "End date")
    private Date endDate;

    @Excel(name = "Sub im file path")
    private String subImFilePath;

    @Excel(name = "Application form")
    private String applicationForm;

    public FundsExportDTO(FundsEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.fundStatus = EnumUtil.getEnumMessageByCode(FundsStatusEnum.class, entity.getFundStatus());
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());;
        this.description = entity.getDescription();
        this.settlementDate = entity.getSettlementDate();
        this.interestStartsDate = entity.getInterestStartsDate();
        this.endDate = entity.getEndDate();
        this.amount = entity.getAmount();
        this.currency = entity.getCurrency();
        this.fundType = entity.getFundType();
        this.investmentType = entity.getInvestmentType();
        this.productType = entity.getProductType();
        this.purchaseMinAmount = entity.getPurchaseMinAmount();
        this.applicationFeeRate = entity.getApplicationFeeRate();
        this.managementFeeRate = entity.getManagementFeeRate();
        this.BFundCategory = EnumUtil.getEnumMessageByCode(FundCategoryEnum.class, entity.getBFundCategory());
        this.BYearlyReturnRate = entity.getBYearlyReturnRate();
        this.BProjectDurationMonth = entity.getBProjectDurationMonth();
        this.fullySubscription = entity.getFullySubscription();
        this.company = entity.getCompany();
    }
}
