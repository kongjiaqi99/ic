package com.ic.icadmin.entity;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.annotation.JSONField;
import com.ic.icadmin.dto.response.permission.PermissionDTO;
import com.ic.icadmin.share.enums.UserTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:06
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LoginUser implements UserDetails {

    private AdminUsersEntity adminUsersEntity;

    private ClientsEntity clientsEntity;

    private VisitorLog visitor;

    private List<PermissionDTO> permissions;

    private UserTypeEnum userType;

    private List<String> roles;

    public LoginUser(AdminUsersEntity adminUsersEntity, List<PermissionDTO> permissions, UserTypeEnum userType, List<String> roles) {
        this.adminUsersEntity = adminUsersEntity;
        this.permissions = permissions;
        this.userType = userType;
        this.roles = roles;
    }

    public LoginUser(ClientsEntity clientsEntity, UserTypeEnum userType){
        this.clientsEntity = clientsEntity;
        this.userType = userType;
    }

    public LoginUser(VisitorLog visitor){
        this.visitor = visitor;
        this.userType = UserTypeEnum.VISITOR;
    }

    //不序列化，即不往redis存权限
    @JSONField(serialize = false)
    private List<SimpleGrantedAuthority> authorities;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (ObjectUtil.isNotNull(authorities)){
            return authorities;
        }
        if (CollectionUtils.isEmpty(permissions)){
            return authorities;
        }
        List<SimpleGrantedAuthority> simpleGrantedAuthorityList = new ArrayList<>();
        permissions.forEach(p -> {
            simpleGrantedAuthorityList.add(new SimpleGrantedAuthority(p.getPermissionCode()));
            simpleGrantedAuthorityList.addAll(p.getSubPermission().stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList()));
        });

        return simpleGrantedAuthorityList;
    }

    @Override
    public String getPassword() {
        String password = null;
        switch (this.userType){
            case ADMIN:
                password = adminUsersEntity.getEncryptedPassword();
                break;
            case CLIENT:
                password = clientsEntity.getEncryptedPassword();
                break;
            case VISITOR:
                password = visitor.getEncryptedPassword();
                break;
            default:
                break;
        }
        return password;
    }

    @Override
    public String getUsername() {
        String userName = null;
        switch (this.userType){
            case ADMIN:
                userName = adminUsersEntity.getEmail();
                break;
            case CLIENT:
                userName = clientsEntity.getEmail();
                break;
            case VISITOR:
                userName = visitor.getEmail();
                break;
            default:
                break;
        }
        return userName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
