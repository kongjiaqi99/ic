package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum LanguageEnum implements CodeEnum {

    CN(0,"cn"),
    EN(1,"en"),
    ;

    private Integer code;
    private String message;
}
