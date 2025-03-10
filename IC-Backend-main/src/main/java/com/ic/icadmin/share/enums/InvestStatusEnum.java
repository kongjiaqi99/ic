package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum InvestStatusEnum implements CodeEnum {

    INITIAL(0,"initial"),
    FINISH_FORM(1,"finish_form"),
    INVESTED(2,"invested"),
    ;

    private Integer code;
    private String message;
}
