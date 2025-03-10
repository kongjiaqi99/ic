package com.ic.icadmin.share.error;

public enum FinancingsErrorEnum implements ErrorEnum {

    FINANCING_NOT_EXIST("6001", "Financing not exist"),

    FINANCING_CREATE_FAIL("6002", "Financing create fail"),

    FILE_UPLOAD_FAIL("6003", "File:{} upload fail"),

    FINANCING_UPDATE_FAIL("6004", "Financing update fail"),

    FINANCING_DELETE_FAIL("6005", "Financing delete fail"),

    MISSING_CLIENT_DATA("6006", "Missing client data in this financing"),

    ;

    private String errorCode;

    private String errorMessage;

    FinancingsErrorEnum(String errorCode, String errorMessage) {
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
