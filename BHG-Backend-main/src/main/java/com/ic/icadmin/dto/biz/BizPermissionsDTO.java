package com.ic.icadmin.dto.biz;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-18 16:16
 **/
@Data
@ApiModel(value = "BizPermissionsDTO", description = "get all permissions when login")
public class BizPermissionsDTO {

    private Long id;

    private String permissionName;

    private String permissionCode;

    private Long upperPermissionId;

    private Integer permissionLevel;
}
