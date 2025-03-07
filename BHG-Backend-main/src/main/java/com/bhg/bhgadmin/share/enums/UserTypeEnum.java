package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserTypeEnum implements CodeEnum {

    ADMIN(0,"admin"),
    CLIENT(1,"client"),
    VISITOR(2,"visitor"),
    ;

    private Integer code;
    private String message;
}
