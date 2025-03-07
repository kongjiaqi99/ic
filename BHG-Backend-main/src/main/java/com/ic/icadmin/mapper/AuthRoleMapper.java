package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.response.admin.RoleResponse;
import com.ic.icadmin.entity.AuthRoleEntity;

import java.util.List;

public interface AuthRoleMapper extends BaseMapper<AuthRoleEntity> {

    List<RoleResponse> queryRoles();
}