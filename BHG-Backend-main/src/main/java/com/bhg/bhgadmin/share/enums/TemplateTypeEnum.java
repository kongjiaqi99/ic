package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TemplateTypeEnum implements CodeEnum {

    MONTHLY(1,"Monthly"),
    ANNUAL(2,"Annual"),
    ;

    private Integer code;
    private String message;
}
