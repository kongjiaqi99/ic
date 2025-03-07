package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum FundsStatusEnum implements CodeEnum {

    COMING_SOON(0,"coming_soon"),
    NOW_OPEN(1,"now_open"),
    FULLY_INVESTED(2,"fully_invested"),
    COMPLETED(3,"completed"),
    ;

    private Integer code;
    private String message;
}
