package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AuditTypeEnum implements CodeEnum {

    CLIENT(0,"Client Update"),
    ENTITY(1,"Entity Update"),
    INVESTMENT(2,"Re-Investment Request"),
    ;

    private Integer code;
    private String message;
}
