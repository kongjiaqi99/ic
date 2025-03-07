package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.bhg.bhgadmin.share.utils.OperationLog;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "funds")
public class FundsEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "\"name\"")
    @OperationLog(name = "\"name\"")
    private String name;

    @TableField(value = "description")
    @OperationLog(name = "description")
    private String description;

    @TableField(value = "settlement_date")
    @OperationLog(name = "settlement_date")
    private Date settlementDate;

    @TableField(value = "interest_starts_date")
    @OperationLog(name = "interest_starts_date")
    private Date interestStartsDate;

    @TableField(value = "amount")
    @OperationLog(name = "amount")
    private BigDecimal amount;

    @TableField(value = "currency")
    @OperationLog(name = "currency")
    private String currency;

    @TableField(value = "fund_type")
    @OperationLog(name = "fund_type")
    private String fundType;

    @TableField(value = "investment_type")
    @OperationLog(name = "investment_type")
    private String investmentType;

    @TableField(value = "product_type")
    @OperationLog(name = "product_type")
    private String productType;

    @TableField(value = "purchase_min_amount")
    @OperationLog(name = "purchase_min_amount")
    private String purchaseMinAmount;

    @TableField(value = "investment_cycle")
    @OperationLog(name = "investment_cycle")
    private String investmentCycle;

    @TableField(value = "fix_net_return")
    @OperationLog(name = "fix_net_return")
    private String fixNetReturn;

    @TableField(value = "float_net_return")
    @OperationLog(name = "float_net_return")
    private String floatNetReturn;

    @TableField(value = "application_fee_rate")
    @OperationLog(name = "application_fee_rate")
    private String applicationFeeRate;

    @TableField(value = "management_fee_rate")
    @OperationLog(name = "management_fee_rate")
    private String managementFeeRate;

    @TableField(value = "im_file_path")
    @OperationLog(name = "im_file_path")
    private String imFilePath;

    @TableField(value = "introduce_file_path")
    @OperationLog(name = "introduce_file_path")
    private String introduceFilePath;

    @TableField(value = "eoi_file_path")
    @OperationLog(name = "eoi_file_path")
    private String eoiFilePath;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "net_return_a")
    @OperationLog(name = "net_return_a")
    private String netReturnA;

    @TableField(value = "net_return_b")
    @OperationLog(name = "net_return_b")
    private String netReturnB;

    @TableField(value = "cash_divided_cycle")
    @OperationLog(name = "cash_divided_cycle")
    private String cashDividedCycle;

    @TableField(value = "performance_fee_rate")
    @OperationLog(name = "performance_fee_rate")
    private String performanceFeeRate;

    @TableField(value = "investment_strategy")
    @OperationLog(name = "investment_strategy")
    private String investmentStrategy;

    @TableField(value = "nature_yearly_return")
    @OperationLog(name = "nature_yearly_return")
    private String natureYearlyReturn;

    @TableField(value = "value_yearly_return")
    @OperationLog(name = "value_yearly_return")
    private String valueYearlyReturn;

    @TableField(value = "subscription_fee_rate")
    @OperationLog(name = "subscription_fee_rate")
    private String subscriptionFeeRate;

    @TableField(value = "report_file_path")
    @OperationLog(name = "report_file_path")
    private String reportFilePath;

    @TableField(value = "\"language\"")
    @OperationLog(name = "\"language\"")
    private Integer language;

    @TableField(value = "trans_id")
    @OperationLog(name = "trans_id")
    private Long transId;

    @TableField(value = "additional_investment_file")
    @OperationLog(name = "additional_investment_file")
    private String additionalInvestmentFile;

    @TableField(value = "display_order")
    @OperationLog(name = "display_order")
    private Integer displayOrder;

    @TableField(value = "constitution_file")
    @OperationLog(name = "constitution_file")
    private String constitutionFile;

    @TableField(value = "b_fund_category")
    @OperationLog(name = "b_fund_category")
    private Integer bFundCategory;

    @TableField(value = "b_project_duration_month")
    @OperationLog(name = "b_project_duration_month")
    private Integer bProjectDurationMonth;

    @TableField(value = "b_yearly_return_rate")
    @OperationLog(name = "b_yearly_return_rate")
    private BigDecimal bYearlyReturnRate;

    @TableField(value = "b_delayed_growth_rate")
    @OperationLog(name = "b_delayed_growth_rate")
    private BigDecimal bDelayedGrowthRate;

    @TableField(value = "fully_subscription")
    @OperationLog(name = "fully_subscription")
    private Boolean fullySubscription;

    @TableField(value = "fund_status")
    @OperationLog(name = "fund_status")
    private Integer fundStatus;

    @TableField(value = "end_date")
    @OperationLog(name = "end_date")
    private Date endDate;

    @TableField(value = "sub_im_file_path")
    @OperationLog(name = "sub_im_file_path")
    private String subImFilePath;

    @TableField(value = "application_form")
    @OperationLog(name = "application_form")
    private String applicationForm;

    @TableField(value = "application_form_two")
    @OperationLog(name = "application_form_two")
    private String applicationFormTwo;
    @TableField(value = "application_form_three")
    @OperationLog(name = "application_form_three")
    private String applicationFormThree;
    @TableField(value = "application_form_four")
    @OperationLog(name = "application_form_four")
    private String applicationFormFour;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    private static final long serialVersionUID = 1L;

    /**
     * 国际化字段
     */
    @TableField(value = "description_cn")
    @OperationLog(name = "description_cn")
    private String descriptionCN;

    @TableField(value = "name_cn")
    @OperationLog(name = "name_cn")
    private String nameCN;

    @TableField(value = "fund_type_cn")
    @OperationLog(name = "fund_type_cn")
    private String fundTypeCN;

    @TableField(value = "investment_type_cn")
    @OperationLog(name = "investment_type_cn")
    private String investmentTypeCN;

    @TableField(value = "product_type_cn")
    @OperationLog(name = "product_type_cn")
    private String productTypeCN;

    @TableField(value = "cash_divided_cycle_cn")
    @OperationLog(name = "cash_divided_cycle_cn")
    private String cashDividedCycleCN;

    @TableField(value = "currency_cn")
    @OperationLog(name = "currency_cn")
    private String currencyCN;

    @TableField(value = "investment_cycle_cn")
    @OperationLog(name = "investment_cycle_cn")
    private String investmentCycleCN;

    @TableField(value = "fix_net_return_cn")
    @OperationLog(name = "fix_net_return_cn")
    private String fixNetReturnCN;

    @TableField(value = "float_net_return_cn")
    @OperationLog(name = "float_net_return_cn")
    private String floatNetReturnCN;

    @TableField(value = "application_fee_rate_cn")
    @OperationLog(name = "application_fee_rate_cn")
    private String applicationFeeRateCN;

    @TableField(value = "management_fee_rate_cn")
    @OperationLog(name = "management_fee_rate_cn")
    private String managementFeeRateCN;

    @TableField(value = "net_return_a_cn")
    @OperationLog(name = "net_return_a_cn")
    private String netReturnACN;

    @TableField(value = "net_return_b_cn")
    @OperationLog(name = "net_return_b_cn")
    private String netReturnBCN;

    @TableField(value = "performance_fee_rate_cn")
    @OperationLog(name = "performance_fee_rate_cn")
    private String performanceFeeRateCN;

    @TableField(value = "investment_strategy_cn")
    @OperationLog(name = "investment_strategy_cn")
    private String investmentStrategyCN;

    @TableField(value = "nature_yearly_return_cn")
    @OperationLog(name = "nature_yearly_return_cn")
    private String natureYearlyReturnCN;

    @TableField(value = "value_yearly_return_cn")
    @OperationLog(name = "value_yearly_return_cn")
    private String valueYearlyReturnCN;

    @TableField(value = "subscription_fee_rate_cn")
    @OperationLog(name = "subscription_fee_rate_cn")
    private String subscriptionFeeRateCN;

    @TableField(value = "sub_im_date")
    @OperationLog(name = "sub_im_date")
    private Date subImDate;

    @TableField(value = "deed_date")
    @OperationLog(name = "deed_date")
    private Date deedDate;

    @TableField(value = "cover")
    @OperationLog(name = "cover")
    private String cover;
    @TableField(value = "cover_two")
    @OperationLog(name = "cover_two")
    private String coverTwo;
    @TableField(value = "cover_three")
    @OperationLog(name = "cover_three")
    private String coverThree;
    @TableField(value = "cover_four")
    @OperationLog(name = "cover_four")
    private String coverFour;
    @TableField(value = "cover_cn")
    @OperationLog(name = "cover_cn")
    private String coverCn;
    @TableField(value = "cover_cn_two")
    @OperationLog(name = "cover_cn_two")
    private String coverCnTwo;
    @TableField(value = "cover_cn_Three")
    @OperationLog(name = "cover_cn_three")
    private String coverCnThree;
    @TableField(value = "cover_cn_four")
    @OperationLog(name = "cover_cn_four")
    private String coverCnFour;
    @TableField(value = "popular")
    @OperationLog(name = "popular")
    private Integer popular;

    @TableField(value = "state_id")
    @OperationLog(name = "state_id")
    private Long stateId;

    @TableField(value = "state_en")
    @OperationLog(name = "state_en")
    private String stateEn;

    @TableField(value = "state_cn")
    @OperationLog(name = "state_cn")
    private String stateCn;

    @TableField(value = "extend_start_date")
    @OperationLog(name = "extend_start_date")
    private Date extendStartDate;

    @TableField(value = "default_start_date")
    @OperationLog(name = "default_start_date")
    private Date defaultStartDate;

    @TableField(value = "company")
    @OperationLog(name = "company")
    private String company;
}
