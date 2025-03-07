package com.bhg.bhgadmin.share.error;

public enum PurchasedFundsErrorEnum implements ErrorEnum {

    PURCHASED_NOT_EXIST("10001", "Purchased fund not exist"),

    PURCHASED_CREATE_FAIL("10002", "Purchased fund create fail"),

    FILE_UPLOAD_FAIL("10003", "File:{} upload fail"),

    PURCHASED_UPDATE_FAIL("10004", "Purchased fund update fail"),

    PURCHASED_DELETE_FAIL("10005", "Purchased fund delete fail"),

    CERTIFICATE_GENERATE_FAIL("10006", "Cannot generate certificate for this purchased fund"),

    WRONG_TRANSACTION_TIME("10007", "Transaction date can not after than now time"),

    NO_TRANSACTION_DATE("10008", "Need transaction date in purchased fund to calculate"),

    NO_INTEREST_START_DATE("10009", "Need interest start date in fund to calculate"),

    ;

    private String errorCode;

    private String errorMessage;

    PurchasedFundsErrorEnum(String errorCode, String errorMessage) {
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
