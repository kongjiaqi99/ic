package com.bhg.bhgadmin.share.error;

import com.bhg.bhgadmin.share.exception.CommonException;


public interface ErrorEnum {
    String getErrorCode();

    String getErrorMessage();

    default void throwException() {
        throw new CommonException(this);
    }
    default void throwException(Object[] msgArgs) {
        throw new CommonException(this, msgArgs);
    }

}
