package com.bhg.bhgadmin.share.error;

public enum ClientsErrorEnum implements ErrorEnum {

    /**
     * Client not exist
     */
    CLIENT_NOT_EXIST("2001", "Client not exist"),

    CLIENT_DEL_FAIL("2002", "Client delete failed"),

    EMAIL_EXIST("2003", "Email %s already exist"),

    CLIENT_PASSWORD_CANNOT_BLANK("2004", "client password can not be blank"),

    WRONG_PASSWORD("2005", "wrong password"),

    UNAUTHORIZED("2006","login failed, please retry"),

    WRONG_VERIFICATION_CODE("2007","Wrong verification code"),

    NO_DELICATE_VERIFICATION_CODE("2008","Don't send verification code delicately, please retry in 15 minutes."),

    LOCKED("2009","%s LOCKED"),

    FILE_UPLOAD_FAIL("10003", "File:{} upload fail"),

    WRONG_CONFIRM_PASSWORD("2010","Wrong Confirm Password"),

    SAME_PASSWORD("2011","The new password must be different from the old one."),

    VERIFICATION_CODE_EXPIRED("2012", "Verification code expired "),

    ;

    private String errorCode;

    private String errorMessage;

    ClientsErrorEnum(String errorCode, String errorMessage) {
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
