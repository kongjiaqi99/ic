package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnquiryTypeEnum implements CodeEnum {
    //1 general, 2 investment, 3 borrow
    GENERAL(1, "general"),

    INVESTMENT(2,"investment"),
    BORROW(3,"borrow"),
    ;

    private Integer code;
    private String message;
}
