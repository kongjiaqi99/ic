package com.bhg.bhgadmin.share.error;

public enum NewsImgsErrorEnum implements ErrorEnum {

    NEWS_IMG_NOT_EXIST("8001", "News img not exist"),

    NEWS_IMG_CREATE_FAIL("8002", "News img create fail"),

    FILE_UPLOAD_FAIL("8003", "File:{} upload fail"),

    NEWS_IMG_UPDATE_FAIL("8004", "News img update fail"),

    NEWS_IMG_DELETE_FAIL("8005", "News img delete fail"),


    ;

    private String errorCode;

    private String errorMessage;

    NewsImgsErrorEnum(String errorCode, String errorMessage) {
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
