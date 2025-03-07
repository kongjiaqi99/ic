package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnvironmentTypeEnum implements CodeEnum {

    PROD(0,"prod"),
    DEV(1,"dev"),
    LOCAL(2,"local"),
    ;

    private Integer code;
    private String message;
}
