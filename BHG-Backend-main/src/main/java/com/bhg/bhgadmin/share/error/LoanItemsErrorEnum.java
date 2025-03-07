package com.bhg.bhgadmin.share.error;

public enum LoanItemsErrorEnum implements ErrorEnum {

    LOAN_NOT_EXIST("7001", "Loan Item not exist"),

    LOAN_CREATE_FAIL("7002", "Loan Item create fail"),
//
//    FILE_UPLOAD_FAIL("5003", "File:{} upload fail"),
//
    LOAN_UPDATE_FAIL("7003", "Loan Item update fail"),
//
    LOAN_DELETE_FAIL("7004", "Loan Item delete fail"),


    ;

    private String errorCode;

    private String errorMessage;

    LoanItemsErrorEnum(String errorCode, String errorMessage) {
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
