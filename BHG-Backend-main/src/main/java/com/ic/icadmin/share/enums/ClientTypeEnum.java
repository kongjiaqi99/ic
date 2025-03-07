package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ClientTypeEnum implements CodeEnum {

    DIRECT(0,"direct"),
    REFERED(1,"refered"),
    VALUE_UP(2,"value_up"),
    PARTNER(3,"partner"),
    ;

    private Integer code;
    private String message;
}
