package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EventStatusEnum implements CodeEnum {

    NOT_OPEN(0,"Not Open"),
    OPEN(1,"Join Now"),
    ENDED(2,"Ended"),
    ;

    private Integer code;
    private String message;
}
