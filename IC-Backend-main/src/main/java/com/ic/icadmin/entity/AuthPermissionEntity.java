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
@TableName(value = "auth_permission")
public class AuthPermissionEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "permission_name")
    private String permissionName;

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

    @TableField(value = "permission_code")
    private String permissionCode;

    /**
     * 1:menu
     */
    @TableField(value = "permission_level")
    private Integer permissionLevel;

    @TableField(value = "upper_permission_id")
    private Long upperPermissionId;

    private static final long serialVersionUID = 1L;
}