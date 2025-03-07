package com.ic.icadmin.dto.response.admin;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.ic.icadmin.entity.AdminUsersEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.Locale;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "AdminUsersDetailResponse", description = "Admin Users Detail Response")
public class AdminUsersDetailResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("reset password token")
    private String resetPwdToken;

    @ApiModelProperty("reset password send at")
    private String resetPwdSendAt;

    @ApiModelProperty("create at")
    private String createAt;

    @ApiModelProperty("update at")
    private String updateAt;

    @ApiModelProperty("role")
    private String role;

    private void setResetPwdSendAt(Date sendAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.resetPwdSendAt = ObjectUtils.isNull(sendAt) ? null : DateUtil.format(sendAt,
                                                                             FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }
    private void setCreateAt(Date createAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    private void setUpdateAt(Date updateAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.updateAt = ObjectUtils.isNull(updateAt) ? null : DateUtil.format(updateAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public AdminUsersDetailResponse(AdminUsersEntity adminUsersEntity, String role) {
        this.id = adminUsersEntity.getId();
        this.email = adminUsersEntity.getEmail();
        this.resetPwdToken = adminUsersEntity.getResetPasswordToken();
        this.role = role;
        setResetPwdSendAt(adminUsersEntity.getResetPasswordSentAt());
        setCreateAt(adminUsersEntity.getCreatedAt());
        setUpdateAt(adminUsersEntity.getUpdatedAt());
    }

}
