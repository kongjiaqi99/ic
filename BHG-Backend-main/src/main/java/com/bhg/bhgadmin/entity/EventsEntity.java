package com.bhg.bhgadmin.entity;

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
@TableName(value = "events")
public class EventsEntity implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "title")
    private String title;

    @TableField(value = "start_time")
    private Date startTime;

    @TableField(value = "city")
    private Integer city;

    @TableField(value = "\"location\"")
    private String location;

    @TableField(value = "brief_introduction")
    private String briefIntroduction;

    @TableField(value = "\"language\"")
    private Integer language;

    @TableField(value = "main_img")
    private String mainImg;

    @TableField(value = "trans_id")
    private Long transId;

    @TableField(value = "created_at")
    private Date createdAt;

    @TableField(value = "updated_at")
    private Date updatedAt;

    /**
     * true:deleted, false: not deleted
     */
    @TableField(value = "del_flag")
    private Boolean delFlag;

    private static final long serialVersionUID = 1L;

    @TableField(value = "status")
    private String status;

    @TableField(value = "file_url")
    private String fileUrl;

    @TableField(value = "type")
    private String type;

    @TableField(value = "link")
    private String link;
}
