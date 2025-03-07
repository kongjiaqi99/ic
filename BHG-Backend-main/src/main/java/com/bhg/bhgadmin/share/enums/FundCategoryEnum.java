package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum FundCategoryEnum implements CodeEnum {

    POOL(0,"Pool"),
    DIRECT(1,"Direct"),
    ;

    private Integer code;
    private String message;
}
