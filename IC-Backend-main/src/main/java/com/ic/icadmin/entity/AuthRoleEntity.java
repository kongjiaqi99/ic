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
@TableName(value = "auth_role")
public class AuthRoleEntity implements Serializable {
    /**
     * role_id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * name of role
     */
    @TableField(value = "role_name")
    private String roleName;

    /**
     * role active flag
     */
    @TableField(value = "active_flag")
    private Boolean activeFlag;

    /**
     * role del flag
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