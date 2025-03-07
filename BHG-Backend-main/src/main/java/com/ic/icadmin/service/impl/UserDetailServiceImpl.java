package com.ic.icadmin.service.impl;

import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.dto.biz.BizPermissionsDTO;
import com.ic.icadmin.dto.response.permission.PermissionDTO;
import com.ic.icadmin.entity.*;
import com.ic.icadmin.mapper.AdminUsersMapper;
import com.ic.icadmin.mapper.AuthPermissionMapper;
import com.ic.icadmin.mapper.AuthRoleMapper;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.service.UserDetailService;
import com.ic.icadmin.share.constants.RedisConstants;
import com.ic.icadmin.share.enums.UserTypeEnum;
import com.ic.icadmin.share.error.AdminUserErrorEnum;
import com.ic.icadmin.share.error.ClientsErrorEnum;
import com.ic.icadmin.share.utils.RedisCache;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 01:20
 **/
@Slf4j
@Service
public class UserDetailServiceImpl implements UserDetailService {

    @Autowired
    private AdminUsersMapper adminUsersMapper;

    @Autowired
    private AuthPermissionMapper permissionMapper;

    @Autowired
    private ClientsMapper clientsMapper;

    @Resource
    private AuthRoleMapper roleMapper;

    @Resource
    private RedisCache redisCache;

    Pattern pattern = Pattern.compile("^04\\d{8}$");

    @Override
    public UserDetails loadUserByUsername(String adminUserEmail, Object detail) throws UsernameNotFoundException {
        UserTypeEnum typeEnum = (UserTypeEnum) detail;
        LoginUser loginUser = null;
        switch (typeEnum) {
            case ADMIN:
                AdminUsersEntity adminUser = adminUsersMapper.selectOne(Wrappers.<AdminUsersEntity>query()
                                                                            .eq("Lower(email)", adminUserEmail.toLowerCase()).lambda()
                                                                            .eq(AdminUsersEntity::getDelFlag, Boolean.FALSE).last( " limit 1"));
                if (Objects.isNull(adminUser)){
                    AdminUserErrorEnum.ADMIN_USER_NOT_EXIST.throwException();
                }
                if (Objects.isNull(adminUser.getRoleId())){
                    AdminUserErrorEnum.ADMIN_NO_ROLE.throwException();
                }
                // 查询权限
                List<BizPermissionsDTO> bizPermissions = permissionMapper.queryPermsByRoleId(adminUser.getRoleId());
                List<PermissionDTO> permissions = new ArrayList<>();
                if (!CollectionUtils.isEmpty(bizPermissions)) {
                    List<BizPermissionsDTO> permissionsLevel1 = bizPermissions.stream().filter(biz -> biz.getPermissionLevel() == 1).collect(Collectors.toList());
                    List<BizPermissionsDTO> permissionsLevel2 = bizPermissions.stream().filter(biz -> biz.getPermissionLevel() == 2).collect(Collectors.toList());

                    permissionsLevel1.forEach(permLevel1 -> {
                        List<String> subPermissions = permissionsLevel2.stream().filter(
                            biz -> biz.getUpperPermissionId().equals(permLevel1.getId())).map(BizPermissionsDTO::getPermissionCode).collect(Collectors.toList());
                        permissions.add(new PermissionDTO(permLevel1.getPermissionName(), permLevel1.getPermissionCode(), subPermissions
                        ));
                    });
                }
                AuthRoleEntity role = roleMapper.selectById(adminUser.getRoleId());
                loginUser = new LoginUser(adminUser, permissions, typeEnum, Lists.newArrayList(role.getRoleName()));
                break;
            case CLIENT:
                ClientsEntity client = clientsMapper.selectOne(Wrappers.<ClientsEntity>query()
                        .eq("Lower(email)", adminUserEmail.toLowerCase()).lambda()
                        .eq(ClientsEntity::getDelFlag, Boolean.FALSE).last( " limit 1"));
                if (ObjectUtil.isNull(client) && pattern.matcher(adminUserEmail).matches()) {
                    client = clientsMapper.selectOne(Wrappers.<ClientsEntity>query()
                            .eq("mobile", adminUserEmail).lambda()
                            .eq(ClientsEntity::getDelFlag, Boolean.FALSE).last(" limit 1"));
                }
                if (ObjectUtil.isNull(client)) {
                    ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
                }
                loginUser = new LoginUser(client, typeEnum);
                break;
            case VISITOR:
                String securityCode = redisCache.getCacheObject(RedisConstants.CLIENT_VISITOR_TOKEN + adminUserEmail);
                if (CharSequenceUtil.isNotBlank(securityCode)) {
                    VisitorLog visitorLog = new VisitorLog().setEmail(adminUserEmail).setEncryptedPassword(securityCode);
                    return new LoginUser(visitorLog);
                }
                ClientsErrorEnum.VERIFICATION_CODE_EXPIRED.throwException();
                break;
            default:
                ClientsErrorEnum.CLIENT_NOT_EXIST.throwException();
                break;
        }
        return loginUser;
    }
}
