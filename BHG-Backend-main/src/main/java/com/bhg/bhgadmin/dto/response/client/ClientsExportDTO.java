package com.bhg.bhgadmin.dto.response.client;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.share.enums.ClientTypeEnum;
import com.bhg.bhgadmin.share.enums.InvestEntityTypeEnum;
import com.bhg.bhgadmin.share.enums.InvestStatusEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@XmlRootElement
@NoArgsConstructor
public class ClientsExportDTO implements Serializable {
    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Email")
    private String email;

    @Excel(name = "Reset password token")
    private String resetPasswordToken;

    @Excel(name = "Reset password sent at")
    private Date resetPasswordSentAt;

    @Excel(name = "Current sign in at")
    private Date currentSignInAt;

    @Excel(name = "Last sign in at")
    private Date lastSignInAt;

    @Excel(name = "Current sign in ip")
    private String currentSignInIp;

    @Excel(name = "Last sign in ip")
    private String lastSignInIp;

    @Excel(name = "Name")
    private String name;

    @Excel(name = "Client type")
    private String clientType;

    @Excel(name = "Country code")
    private String countryCode;

    @Excel(name = "Mobile")
    private String mobile;

    @Excel(name = "Birth")
    private Date birth;

    @Excel(name = "Created at")
    private Date createdAt;

    @Excel(name = "Updated at")
    private Date updatedAt;

    @Excel(name = "Bsb")
    private String bsb;

    @Excel(name = "Account name")
    private String accountName;

    @Excel(name = "Account number")
    private String accountNumber;

    @Excel(name = "Interested fund")
    private String interestedFund;

    @Excel(name = "Link to valueup")
    private Boolean linkToValueup;

    @Excel(name = "Target amount")
    private BigDecimal targetAmount;

    private static final long serialVersionUID = 1L;

    public ClientsExportDTO(ClientsEntity entity) {
        this.id = entity.getId();
        this.email = entity.getEmail();
        this.resetPasswordToken = entity.getResetPasswordToken();
        this.resetPasswordSentAt = entity.getResetPasswordSentAt();
        this.currentSignInAt = entity.getCurrentSignInAt();
        this.lastSignInAt = entity.getLastSignInAt();
        this.currentSignInIp = entity.getCurrentSignInIp();
        this.lastSignInIp = entity.getLastSignInIp();
        this.name = entity.getName();
        this.clientType = EnumUtil.getEnumMessageByCode(ClientTypeEnum.class, entity.getClientType());
        this.countryCode = entity.getCountryCode();
        this.mobile = entity.getMobile();
        this.birth = entity.getBirth();
        this.createdAt = entity.getCreatedAt();
        this.updatedAt = entity.getUpdatedAt();
        this.bsb = entity.getBsb();
        this.accountName = entity.getAccountName();
        this.accountNumber = entity.getAccountNumber();
        this.interestedFund = entity.getInterestedFund();
        this.linkToValueup = entity.getLinkToValueup();
        this.targetAmount = entity.getTargetAmount();
    }
}