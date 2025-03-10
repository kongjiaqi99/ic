package com.ic.icadmin.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import java.util.Date;

import com.ic.icadmin.config.handler.JSONBTypeHandlerPg;
import com.ic.icadmin.share.enums.AuditTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * (operate_log)实体类
 *
 * @author ljc
 * @since 2024-06-25 15:00:56
 * @description 由 Mybatisplus Code Generator 创建
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@TableName("operate_log")
public class OperateLog extends Model<OperateLog> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
	private Long id;
    /**
     * type
     * {@link com.ic.icadmin.share.enums.OperateEntityTypeEnum}
     */
    private String entityType;

    /**
     * type
     * {@link com.ic.icadmin.share.enums.OperateTypeEnum}
     */
    private String operateType;
    /**
     * content
     */
    @TableField(typeHandler = JSONBTypeHandlerPg.class)
    private String content;
    /**
     * entityId
     */
    private Long entityId;
    /**
     * entityName
     */
    private String entityName;
    /**
     * createdAt
     */
    private Date createdAt;
    /**
     * creator
     */
    private Long creator;
    /**
     * creatorName
     */
    private String creatorName;

}