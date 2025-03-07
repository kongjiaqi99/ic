package com.bhg.bhgadmin.dto.response.admin;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.bhg.bhgadmin.entity.AdminUsersEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 20:34
 **/
@Data
@ApiModel(value = "AdminUsersResponse", description = "Admin Users Response")
public class AdminUsersResponse {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("Email")
    private String email;

    @ApiModelProperty("create at")
    private String createAt;

    private void setCreateAt(Date createAt){
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        this.createAt = ObjectUtils.isNull(createAt) ? null : DateUtil.format(createAt,
                                                                       FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
    }

    public AdminUsersResponse(AdminUsersEntity adminUsersEntity) {
        this.id = adminUsersEntity.getId();
        this.email = adminUsersEntity.getEmail();
        setCreateAt(adminUsersEntity.getCreatedAt());
    }

}
