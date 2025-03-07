package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.permission.PermissionRequest;
import com.ic.icadmin.dto.response.permission.PermissionResponse;
import com.ic.icadmin.mapper.AuthPermissionMapper;
import com.ic.icadmin.share.error.AdminUserErrorEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/permissions")
@Api(tags = "Permissions")
public class PermissionController extends BaseController {

    @Autowired
    private AuthPermissionMapper permissionMapper;

    @PostMapping("/querySubPermissions")
    @ApiOperation(value = "querySubPermission", notes = "query Sub Permission")
    CommonResponse<PermissionResponse> querySubPermissions(@RequestBody PermissionRequest request){
        Boolean editPerm = Boolean.FALSE;
        Long roleId = getLoginAdmin().getRoleId();
        if (Objects.isNull(roleId)){
            AdminUserErrorEnum.ADMIN_NO_ROLE.throwException();
        }
        //todo only have edit permission now
        String subPermission = permissionMapper.querySubPermission(roleId, request.getParentPermission());
        if (StringUtils.hasText(subPermission)){
            editPerm = Boolean.TRUE;
        }
        return CommonResponse.success(new PermissionResponse(editPerm));
    }
}
