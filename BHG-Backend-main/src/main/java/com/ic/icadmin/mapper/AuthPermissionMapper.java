package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.biz.BizPermissionsDTO;
import com.ic.icadmin.entity.AuthPermissionEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthPermissionMapper extends BaseMapper<AuthPermissionEntity> {

    List<BizPermissionsDTO> queryPermsByRoleId(@Param("roleId") Long roleId);

    String querySubPermission(@Param("roleId") Long roleId, @Param("parentPermission") String parentPermission);
}