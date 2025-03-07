package com.bhg.bhgadmin.dto.request.notification;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-09-30
 */
@Data
@ApiModel(value="NotificationRequest", description="NotificationRequest")
public class NotificationRequest implements Serializable {

    private static final long serialVersionUID=1L;

    private Long id;

    private List<Long> clientIdArr;

    private List<String> clientNameArr;

    private Boolean isAll;

    private String title;

    private String message;

    private Date createdAt;

    private Date updatedAt;

    private String status;

    private Long creator;

    private Boolean readFlag;

    private Boolean readAll;

    private String titleCn;

    private String messageCn;
}
