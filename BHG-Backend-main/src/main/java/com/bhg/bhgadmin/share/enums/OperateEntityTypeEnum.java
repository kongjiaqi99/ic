package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OperateEntityTypeEnum implements CodeEnum {

    FUND(0,"Fund"),
    INVESTMENT(1,"Investment"),
    REFERRAL(2,"Referral"),
    CLIENT(3,"Client"),
    ENTITY(4,"Entity"),
    ;

    private Integer code;
    private String message;
}
