package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.util.List;

import com.baomidou.mybatisplus.annotation.TableName;
import com.ic.icadmin.config.handler.LongListHandler;
import com.ic.icadmin.config.handler.ArrayTypeHandler;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-09-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(value="Notification对象", description="")
@TableName(value = "notification", autoResultMap = true)
public class Notification implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(typeHandler = LongListHandler.class)
    private List<Long> clientIdArr;
    @TableField(typeHandler = ArrayTypeHandler.StrListHandler.class)
    private List<String> clientNameArr;

    private Boolean isAll;

    private String title;

    private String message;

    private Date createdAt;

    private Date updatedAt;

    private String status;

    private Long creator;

    private String file;

    private String titleCn;

    private String messageCn;
}
