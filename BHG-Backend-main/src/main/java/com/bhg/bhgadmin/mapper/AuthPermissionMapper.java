package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.biz.BizPermissionsDTO;
import com.bhg.bhgadmin.entity.AuthPermissionEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthPermissionMapper extends BaseMapper<AuthPermissionEntity> {

    List<BizPermissionsDTO> queryPermsByRoleId(@Param("roleId") Long roleId);

    String querySubPermission(@Param("roleId") Long roleId, @Param("parentPermission") String parentPermission);
}