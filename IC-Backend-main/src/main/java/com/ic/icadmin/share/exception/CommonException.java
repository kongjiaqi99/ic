package com.ic.icadmin.share.exception;

import com.ic.icadmin.share.error.ErrorEnum;

public class CommonException extends RuntimeException {

    private String errorCode;

    private String errorMessage;

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public CommonException(String errorCode, String errorMessage) {
        super(errorMessage);
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

    public CommonException(ErrorEnum errorEnum) {
        super(errorEnum.getErrorMessage());
        this.errorCode = errorEnum.getErrorCode();
        this.errorMessage = errorEnum.getErrorMessage();
    }

    public CommonException(ErrorEnum errorEnum, Object[] msgArgs) {
        super(errorEnum.getErrorMessage());
        this.errorCode = errorEnum.getErrorCode();
        this.errorMessage = String.format(errorEnum.getErrorMessage(), msgArgs);
    }

    public static CommonException error(ErrorEnum errorEnum){
        return new CommonException(errorEnum);
    }
}