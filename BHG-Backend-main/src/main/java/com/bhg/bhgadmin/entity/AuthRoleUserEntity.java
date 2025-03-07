package com.bhg.bhgadmin.entity;

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
@TableName(value = "auth_role_user")
public class AuthRoleUserEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "user_id")
    private Long userId;

    /**
     * 1:admin; 2:client
     */
    @TableField(value = "user_type")
    private Integer userType;

    /**
     * active flag
     */
    @TableField(value = "active_flag")
    private Boolean activeFlag;

    /**
     * del flag
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    @TableField(value = "create_by")
    private String createBy;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(value = "update_by")
    private String updateBy;

    @TableField(value = "update_time")
    private Date updateTime;

    private static final long serialVersionUID = 1L;
}