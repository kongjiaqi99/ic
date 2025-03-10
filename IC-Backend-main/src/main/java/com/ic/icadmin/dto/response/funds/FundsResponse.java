package com.ic.icadmin.dto.response.funds;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.ic.icadmin.entity.FundsEntity;
import com.ic.icadmin.share.enums.FundsStatusEnum;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.utils.DateFormatUtil;
import com.ic.icadmin.share.utils.EnumUtil;
import com.ic.icadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "FundsResponse", description = "Funds Response")
public class FundsResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("name")
    private String name;

    @ApiModelProperty("nameCN")
    private String nameCN;

    @ApiModelProperty("found Date")
    private String settlementDate;

    @ApiModelProperty("description")
    private String description;

    @ApiModelProperty("descriptionCN")
    private String descriptionCN;

    @ApiModelProperty("amount")
    private BigDecimal amount;

    @ApiModelProperty("currency")
    private String currency;

    @ApiModelProperty("currencyCN")
    private String currencyCN;

    @ApiModelProperty("fundType")
    private String fundType;

    @ApiModelProperty("fundTypeCN")
    private String fundTypeCN;

    @ApiModelProperty("investment Type")
    private String investmentType;

    @ApiModelProperty("investmentTypeCN")
    private String investmentTypeCN;

    @ApiModelProperty("product Type")
    private String productType;

    @ApiModelProperty("productTypeCN")
    private String productTypeCN;

    @ApiModelProperty("purchase Min Amount")
    private String purchaseMinAmount;

    @ApiModelProperty("language")
    private String language;

    @ApiModelProperty("fundStatus")
    private String fundStatus;

    @ApiModelProperty(value = "sub_im_date")
    private String subImDate;

    @ApiModelProperty(value = "deed_date")
    private String deedDate;

    @ApiModelProperty(value = "interest_starts_date")
    private String interestStartsDate;
    @ApiModelProperty(value = "cover")
    private String cover;
    @ApiModelProperty(name = "cover_two")
    private String coverTwo;
    @ApiModelProperty(name = "cover_three")
    private String coverThree;
    @ApiModelProperty(name = "cover_four")
    private String coverFour;
    @ApiModelProperty(value = "coverCn")
    private String coverCn;
    @ApiModelProperty(name = "cover_cn_two")
    private String coverCnTwo;
    @ApiModelProperty(name = "cover_cn_three")
    private String coverCnThree;
    @ApiModelProperty(name = "cover_cn_four")
    private String coverCnFour;
    @ApiModelProperty(value = "b_project_duration_month")
    private Integer bProjectDurationMonth;
    @ApiModelProperty(value = "b_yearly_return_rate")
    private BigDecimal bYearlyReturnRate;
    @ApiModelProperty("popular")
    private Integer popular;
    @ApiModelProperty("history")
    private boolean history;
    @ApiModelProperty("state_id")
    private Long stateId;

    @ApiModelProperty("state_en")
    private String stateEn;

    @ApiModelProperty("state_cn")
    private String stateCn;
    @ApiModelProperty("imFilePath")
    private String imFilePath;
    @ApiModelProperty("eoiFilePath")
    private String eoiFilePath;
    @ApiModelProperty(name = "company")
    private String company;
    public FundsResponse(FundsEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.nameCN = entity.getNameCN();
        this.settlementDate = DateFormatUtil.getMMMddyyyy(entity.getSettlementDate());
        this.interestStartsDate = DateFormatUtil.getMMMddyyyy(entity.getInterestStartsDate());
        this.description = entity.getDescription();
        this.descriptionCN = entity.getDescriptionCN();
        this.amount = entity.getAmount();
        this.currency = entity.getCurrency();
        this.currencyCN = entity.getCurrencyCN();
        this.fundType = entity.getFundType();
        this.fundTypeCN = entity.getFundTypeCN();
        this.investmentType = entity.getInvestmentType();
        this.investmentTypeCN = entity.getInvestmentTypeCN();
        this.productType = entity.getProductType();
        this.productTypeCN = entity.getProductTypeCN();
        this.purchaseMinAmount = entity.getPurchaseMinAmount();
        this.language = EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage());
        this.fundStatus = EnumUtil.getEnumMessageByCode(FundsStatusEnum.class, entity.getFundStatus());
        this.subImDate = DateUtil.formatDate(entity.getSubImDate());
        this.cover = entity.getCover();
        this.coverCn = entity.getCoverCn();
        this.bProjectDurationMonth = entity.getBProjectDurationMonth();
        this.bYearlyReturnRate = entity.getBYearlyReturnRate();
        this.popular = entity.getPopular();
        this.stateId = entity.getStateId();
        this.stateCn = entity.getStateCn();
        this.stateEn = entity.getStateEn();
        this.company = entity.getCompany();
    }

}
