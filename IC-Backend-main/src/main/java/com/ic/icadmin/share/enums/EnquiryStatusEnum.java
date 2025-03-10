package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnquiryStatusEnum implements CodeEnum {

    NORMAL(0,"NORMAL"),
    LOCKED(1,"LOCKED"),
    ;

    private Integer code;
    private String message;
}
