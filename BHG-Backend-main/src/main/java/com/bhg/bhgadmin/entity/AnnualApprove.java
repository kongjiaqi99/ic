package com.bhg.bhgadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.bhg.bhgadmin.config.handler.ArrayTypeHandler;
import com.bhg.bhgadmin.config.handler.IntegerListHandler;
import com.bhg.bhgadmin.config.handler.JSONBTypeHandlerPg;
import com.bhg.bhgadmin.config.handler.StringListHandler;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * (annual_approve)实体类
 *
 * @author ljc
 * @since 2024-06-25 15:00:56
 * @description 由 Mybatisplus Code Generator 创建
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@TableName(value ="annual_approve", autoResultMap = true)
public class AnnualApprove extends Model<AnnualApprove> implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * id
     */
    @TableId(type = IdType.AUTO)
	private Long id;
    /**
     * fundId
     */
    private Long fundId;
    /**
     * clientId
     */
    private Long clientId;
    /**
     * entityId
     */
    private Long entityId;
    /**
     * entityId
     */
    @TableField(value = "year_list", typeHandler = IntegerListHandler.class)
    private List<Integer> yearList;


}