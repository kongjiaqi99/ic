package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.TableName;
import com.ic.icadmin.config.handler.JSONBTypeHandlerPg;
import com.ic.icadmin.share.enums.AuditStatusEnum;
import com.ic.icadmin.share.enums.AuditTypeEnum;
import com.ic.icadmin.share.enums.EntityStatusEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value="Audit对象", description="")
@TableName(value = "audit", autoResultMap = true)
public class Audit implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * {@link AuditTypeEnum}
     */
    private String auditType;

    @TableField(typeHandler = JSONBTypeHandlerPg.class)
    private String entityContent;

    private Long entityId;
    private String entityName;
    @TableField(typeHandler = JSONBTypeHandlerPg.class)
    private String newEntity;

    private Date createdAt;

    private Date updatedAt;

    /**
     * {@link AuditStatusEnum}
     */
    private String status;

    private Long creator;

    private String creatorName;

    private Long approver;

    private String approverName;


}
