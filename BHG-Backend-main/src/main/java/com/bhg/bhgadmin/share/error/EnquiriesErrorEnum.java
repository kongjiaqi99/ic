package com.bhg.bhgadmin.share.error;

public enum EnquiriesErrorEnum implements ErrorEnum {

    /**
     * Enquiry not exist
     */
    ENQUIRY_NOT_EXIST("3001", "Enquiry not exist"),


    ;

    private String errorCode;

    private String errorMessage;

    EnquiriesErrorEnum(String errorCode, String errorMessage) {
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
