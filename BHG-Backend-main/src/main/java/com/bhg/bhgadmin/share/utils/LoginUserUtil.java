package com.bhg.bhgadmin.share.utils;

import cn.hutool.core.util.ObjectUtil;
import com.bhg.bhgadmin.entity.AdminUsersEntity;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.entity.LoginUser;
import com.bhg.bhgadmin.share.error.CommonErrorEnum;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-25 00:24
 **/
public class LoginUserUtil {

    public LoginUserUtil(){
    }

    public static Long getLoginUserId(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotNull(authentication)){
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            if (ObjectUtil.isNotNull(loginUser)) {
                if (ObjectUtil.isNotNull(loginUser.getAdminUsersEntity())) {
                    return loginUser.getAdminUsersEntity().getId();
                } else if (ObjectUtil.isNotNull(loginUser.getClientsEntity())){
                    return loginUser.getClientsEntity().getId();
                }  else if (ObjectUtil.isNotNull(loginUser.getVisitor())){
                    return null;
                }else {
                    CommonErrorEnum.PARMS_ERROR.throwException();
                }
            }
        }
        CommonErrorEnum.PARMS_ERROR.throwException();
        return null;
    }

    public static String getLoginUserName(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotNull(authentication)){
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            if (ObjectUtil.isNotNull(loginUser)) {
                if (ObjectUtil.isNotNull(loginUser.getAdminUsersEntity())) {
                    return loginUser.getAdminUsersEntity().getEmail();
                } else if (ObjectUtil.isNotNull(loginUser.getClientsEntity())){
                    return loginUser.getClientsEntity().getEmail();
                } else if (ObjectUtil.isNotNull(loginUser.getVisitor())){
                    return loginUser.getVisitor().getEmail();
                } else {
                    CommonErrorEnum.PARMS_ERROR.throwException();
                }
            }
        }
        CommonErrorEnum.PARMS_ERROR.throwException();
        return null;
    }

    public static AdminUsersEntity getLoginAdmin(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotNull(authentication)){
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            if (ObjectUtil.isNotNull(loginUser)) {
                AdminUsersEntity admin = loginUser.getAdminUsersEntity();
                return admin;
            }
        }
        CommonErrorEnum.PARMS_ERROR.throwException();
        return null;
    }

    public static ClientsEntity getLoginClient(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotNull(authentication)){
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            if (ObjectUtil.isNotNull(loginUser)) {
                ClientsEntity client = loginUser.getClientsEntity();
                return client;
            }
        }
        CommonErrorEnum.PARMS_ERROR.throwException();
        return null;
    }

    public static ClientsEntity getLoginClientNormal(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotNull(authentication) && authentication.getPrincipal() instanceof LoginUser){
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            if (ObjectUtil.isNotNull(loginUser)) {
                ClientsEntity client = loginUser.getClientsEntity();
                return client;
            }
        }
        return null;
    }
}
