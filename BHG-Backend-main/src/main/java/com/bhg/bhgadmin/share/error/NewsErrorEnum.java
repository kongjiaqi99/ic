package com.bhg.bhgadmin.share.error;

public enum NewsErrorEnum implements ErrorEnum {

    NEWS_NOT_EXIST("9001", "News not exist"),

    NEWS_CREATE_FAIL("9002", "News create fail"),

    FILE_UPLOAD_FAIL("9003", "File:{} upload fail"),

    NEWS_UPDATE_FAIL("9004", "News update fail"),

    NEWS_DELETE_FAIL("9005", "News delete fail"),


    ;

    private String errorCode;

    private String errorMessage;

    NewsErrorEnum(String errorCode, String errorMessage) {
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
