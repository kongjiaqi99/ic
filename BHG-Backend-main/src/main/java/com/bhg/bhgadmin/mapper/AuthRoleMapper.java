package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.response.admin.RoleResponse;
import com.bhg.bhgadmin.entity.AuthRoleEntity;

import java.util.List;

public interface AuthRoleMapper extends BaseMapper<AuthRoleEntity> {

    List<RoleResponse> queryRoles();
}