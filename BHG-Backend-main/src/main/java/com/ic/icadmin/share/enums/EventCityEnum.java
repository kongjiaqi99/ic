package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EventCityEnum implements CodeEnum {

    ONLINE(0,"Online"),
    SYDNEY(1,"Sydney"),
    MELBOURNE(2,"Melbourne"),
    BRISBANE(3,"Brisbane"),
    ADELAIDE(4,"Adelaide"),
    PERTH(5,"Perth"),
    HOBART(6,"Hobart"),
    CANBERRA(7,"Canberra"),
    GOLD_COAST(8,"Gold Coast"),
    ;

    private Integer code;
    private String message;
}
