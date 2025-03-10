package com.ic.icadmin.share.error;

public enum AdminUserErrorEnum implements ErrorEnum {

    /**
     * Admin User not exist
     */
    ADMIN_USER_NOT_EXIST("1001", "Admin User not exist in system"),

    /**
     * Password is wrong
     */
    PASSWORD_ERROR("1002", "Wrong password"),

    /**
     * token 不合法
     */
    TOKEN_INVALID("1003", "token invalid"),

    /**
     * 未登录
     */
    NOT_LOGIN("1004","not login"),

    /**
     * 无权限
     */
    NO_PERMISSION("1005","no permission"),

    /**
     * 登陆认证失败了，请重新登陆！
     */
    UNAUTHORIZED("1006","login failed, please retry"),

    /**
     * 重设密码token过期，请重新发送密码重置邮件
     */
    PWD_RESET_TOKEN_EXPIRED("1007","password reset Email expired, please resend"),


    /**
     * 重设密码token非法，请重新发送密码重置邮件
     */
    PWD_RESET_TOKEN_INVALID("1008","password reset Email invalid, please resend"),
    /**
     * 删除管理员失败
     */
    DEL_ADMIN_USER_FAIL("1009","delete admin-user fail"),

    EMAIL_EXIST("1010", "Email %s already exist"),

    GOOGLE_RECAPTCHA_FAIL("1011", "Google Recaptcha check failed"),

    NEED_GOOGLE_RECAPTCHA_RESPONSE("1012", "Need g-recaptcha-response"),

    ADMIN_NO_ROLE("1013", "this admin does not have a role to process"),

    ;

    private String errorCode;

    private String errorMessage;

    AdminUserErrorEnum(String errorCode, String errorMessage) {
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

    @Override
    public String getErrorCode() {
        return errorCode;
    }

    @Override
    public String getErrorMessage() {
        return errorMessage;
    }
}
