package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum NewsTypeEnum implements CodeEnum {

    BEAVER_NEWS(0,"beaver_news"),
    LAST_INSIGHTS(1,"last_insights"),
    GLOBAL_WEEKLY_WRAP(2,"global_weekly_wrap"),
    ;

    private Integer code;
    private String message;
}
