package com.bhg.bhgadmin.dto;

import com.bhg.bhgadmin.share.error.ErrorEnum;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
public class CommonResponse<T> implements Serializable {

    private LocalDateTime timeStamp = LocalDateTime.now();

    private String requestId;

    private Boolean success;

    private String errorCode = "0";

    private String errorMessage;

    private T data;

    private CommonResponse(String errorCode, String errorMessage) {
        this.requestId=UUID.randomUUID().toString();
        this.success=false;
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

    private CommonResponse(String errorCode, String errorMessage, T results) {
        this.requestId=UUID.randomUUID().toString();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
        this.data = results;
    }

    private CommonResponse(boolean success, T results) {
        this.requestId=UUID.randomUUID().toString();
        this.success = success;
        this.data = results;
    }

    private CommonResponse(boolean success, String errorCode, String errorMessage, T results) {
        this.requestId=UUID.randomUUID().toString();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
        this.data = results;
        this.success = success;
    }

    public static <T> CommonResponse<T> success() {
        CommonResponse<T> commonResponse = new CommonResponse("0", "");
        commonResponse.setSuccess(Boolean.TRUE);
        return commonResponse;
    }
    public static <T> CommonResponse<T> success(T t) {
        CommonResponse<T> commonResponse = new CommonResponse("0", "", t);
        commonResponse.setSuccess(Boolean.TRUE);
        return commonResponse;
    }

    public static <T> CommonResponse<T> success(T t, String errorCode, String errorMsg) {
        CommonResponse<T> commonResponse = new CommonResponse(errorCode, errorMsg, t);
        commonResponse.setSuccess(Boolean.TRUE);
        return commonResponse;
    }
    public static <T> CommonResponse<T> error(String errorMsg) {
        CommonResponse<T> commonResponse = new CommonResponse("1", errorMsg);
        commonResponse.setSuccess(Boolean.FALSE);
        return commonResponse;
    }
    public static <T> CommonResponse<T> error(ErrorEnum errorEnum) {
        CommonResponse<T> commonResponse = new CommonResponse(errorEnum.getErrorCode(), errorEnum.getErrorMessage());
        commonResponse.setSuccess(Boolean.FALSE);
        return commonResponse;
    }

    public static <T> CommonResponse<T> error(ErrorEnum errorEnum,T t) {
        CommonResponse<T> commonResponse = new CommonResponse(errorEnum.getErrorCode(), errorEnum.getErrorMessage(), t);
        commonResponse.setSuccess(Boolean.FALSE);
        return commonResponse;
    }
    public static <T> CommonResponse<T> error(String errorCode, String errorMsg) {
        CommonResponse<T> commonResponse = new CommonResponse(errorCode, errorMsg);
        commonResponse.setSuccess(Boolean.FALSE);
        return commonResponse;
    }

    public static <T> CommonResponse<T> error(String errorCode, String errorMsg, T t) {
        CommonResponse<T> commonResponse = new CommonResponse(errorCode, errorMsg, t);
        commonResponse.setSuccess(Boolean.FALSE);
        return commonResponse;
    }
}
