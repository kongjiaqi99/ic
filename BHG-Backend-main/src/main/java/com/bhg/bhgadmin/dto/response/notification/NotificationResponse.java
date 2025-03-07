package com.bhg.bhgadmin.dto.response.notification;

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
@ApiModel(value="NotificationResponse", description="NotificationResponse")
public class NotificationResponse implements Serializable {

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

    private Boolean readFlag = Boolean.FALSE;

    private String file;

    private String titleCn;

    private String messageCn;
}
