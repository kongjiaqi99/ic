package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum LoanStatusFilterEnum implements CodeEnum {

    EQUALS(0,"Equals"),
    GREATER_THAN(1,"Greater than"),
    LESS_THAN(2,"Less than"),
    ;

    private Integer code;
    private String message;
}
