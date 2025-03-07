package com.bhg.bhgadmin.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * (notify_client)实体类
 *
 * @author ljc
 * @since 2024-06-14 14:32:20
 * @description 由 Mybatisplus Code Generator 创建
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@TableName("notify_client")
public class NotifyClient extends Model<NotifyClient> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
	private Long id;
    /**
     * notifyId
     */
    private Long notifyId;
    /**
     * clientId
     */
    private Long clientId;

    public NotifyClient(Long notifyId, Long clientId) {
        this.clientId = clientId;
        this.notifyId = notifyId;
    }
}