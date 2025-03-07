package com.ic.icadmin.share.error;

public enum FundsErrorEnum implements ErrorEnum {

    FUND_NOT_EXIST("5001", "Fund not exist"),

    FUND_CREATE_FAIL("5002", "Fund create fail"),

    FILE_UPLOAD_FAIL("5003", "File:{} upload fail"),

    FUND_UPDATE_FAIL("5004", "Fund update fail"),

    FUND_DELETE_FAIL("5005", "Fund delete fail"),


    ;

    private String errorCode;

    private String errorMessage;

    FundsErrorEnum(String errorCode, String errorMessage) {
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
