package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.bhg.bhgadmin.share.utils.OperationLog;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "clients")
public class ClientsEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "email")
    @OperationLog(name = "Email")
    private String email;

    @TableField(value = "encrypted_password")
    private String encryptedPassword;

    @TableField(value = "reset_password_token")
    private String resetPasswordToken;

    @TableField(value = "reset_password_sent_at")
    private Date resetPasswordSentAt;

    @TableField(value = "sign_in_count")
    private Integer signInCount;

    @TableField(value = "current_sign_in_at")
    private Date currentSignInAt;

    @TableField(value = "last_sign_in_at")
    private Date lastSignInAt;

    @TableField(value = "current_sign_in_ip")
    private String currentSignInIp;

    @TableField(value = "last_sign_in_ip")
    private String lastSignInIp;

    // 1级client
    @TableField(value = "upper_client_id")
    @OperationLog(name = "Upper client id")
    private Long upperClientId;

    // 2级client
    @TableField(value = "level_two_upper_client_id")
    @OperationLog(name = "Level two upper client id")
    private Long level2UpperClientId;

    @TableField(value = "beaver_id")
    @OperationLog(name = "Beaver id")
    private String beaverId;

    @TableField(value = "\"name\"")
    @OperationLog(name = "Name")
    private String name;

    @TableField(value = "client_type")
    @OperationLog(name = "Client type")
    private Integer clientType;

    @TableField(value = "country_code")
    @OperationLog(name = "Country code")
    private String countryCode;

    @TableField(value = "mobile")
    @OperationLog(name = "mobile")
    private String mobile;

    @TableField(value = "salt")
    private String salt;

    @TableField(value = "birth")
    @OperationLog(name = "birth")
    private Date birth;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    @TableField(value = "bsb")
    @OperationLog(name = "bsb")
    private String bsb;

    @TableField(value = "account_name")
    @OperationLog(name = "Account name")
    private String accountName;

    @TableField(value = "account_number")
    @OperationLog(name = "Account number")
    private String accountNumber;

    @TableField(value = "start_date")
    @OperationLog(name = "Start date")
    private Date startDate;

    @TableField(value = "end_date")
    @OperationLog(name = "End date")
    private Date endDate;

    @TableField(value = "interested_fund")
    @OperationLog(name = "Interested fund")
    private String interestedFund;

    @TableField(value = "invest_entity")
    @OperationLog(name = "Invest entity")
    private Integer investEntity;

    @TableField(value = "invest_status")
    @OperationLog(name = "Invest status")
    private Integer investStatus;

    @TableField(value = "link_to_valueup")
    @OperationLog(name = "Link to valueup")
    private Boolean linkToValueup;

    @TableField(value = "target_amount")
    @OperationLog(name = "Target amount")
    private BigDecimal targetAmount;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "withheld_tax")
    @OperationLog(name = "Withheld tax")
    private Boolean withheldTax = Boolean.FALSE;

    @TableField(value = "tf_num")
    @OperationLog(name = "Tf num")
    private String tfNum;

    /**
     * {@link com.bhg.bhgadmin.share.enums.EntityStatusEnum}
     */
    @TableField(value = "status")
    private String status;

    @TableField(value = "read_time")
    private Date readTime;

    @TableField(value = "push_client_id")
    private String pushClientId;

    @TableField(value = "language")
    private Integer language;
    private static final long serialVersionUID = 1L;

    @TableField(value = "pin")
    private String pin;

}