package com.ic.icadmin.share.error;

public enum EventsErrorEnum implements ErrorEnum {

    /**
     * Events not exist
     */
    EVENT_NOT_EXIST("4001", "Event not exist"),

    MAIN_IMG_UPLOAD_FAIL("4002", "main img upload fail"),

    EVENT_CREATE_FAIL("4003", "event create fail"),

    EVENT_UPDATE_FAIL("4004", "event update fail"),

    EVENT_DELETE_FAIL("4005", "event delete fail"),

    ;

    private String errorCode;

    private String errorMessage;

    EventsErrorEnum(String errorCode, String errorMessage) {
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
