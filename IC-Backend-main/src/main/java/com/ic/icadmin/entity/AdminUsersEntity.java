package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "admin_users")
public class AdminUsersEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "email")
    private String email;

    @TableField(value = "encrypted_password")
    private String encryptedPassword;

    @TableField(value = "reset_password_token")
    private String resetPasswordToken;

    @TableField(value = "reset_password_sent_at")
    private Date resetPasswordSentAt;

    @TableField(value = "remember_created_at")
    private Date rememberCreatedAt;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "role_id")
    private Long roleId;

    private static final long serialVersionUID = 1L;
}