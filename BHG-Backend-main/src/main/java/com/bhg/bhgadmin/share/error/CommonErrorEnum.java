package com.bhg.bhgadmin.share.error;

public enum CommonErrorEnum implements ErrorEnum {

    TIME_FORMAT_ERROR("001", "%s format error"),

    PARMS_ERROR("002", "Params error"),

    MAIL_FAIL_TO_SENT("003", "Fail to send mail, please retry!"),

    WRONG_DATA("004", "Wrong data"),


    ;

    private String errorCode;

    private String errorMessage;

    CommonErrorEnum(String errorCode, String errorMessage) {
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
