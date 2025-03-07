package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-10-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("finance_reference")
@ApiModel(value="FinanceReference对象", description="")
public class FinanceReference implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Integer level;

    private Long financeId;

    private Long clientId;

    private Long entityId;

    private Long parentId = 0L;

    private Date createdAt;

    private Date updatedAt;

    @TableField(exist = false)
    private List<FinanceReference> children;
}
