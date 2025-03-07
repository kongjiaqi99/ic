package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum FilterTypeEnum implements CodeEnum {

    CONTAINS(0,"contains"),
    EQUALS(1,"equals"),
    STARTS_WITH(2,"startsWith"),
    ENDS_WITH(3,"endsWith"),
    ;

    private Integer code;
    private String message;
}
