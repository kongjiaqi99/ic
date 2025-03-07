package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OperateTypeEnum implements CodeEnum {

    CREATE(0,"Create"),
    UPDATE(1,"Update"),
    DELETE(2,"Delete"),
    ;

    private Integer code;
    private String message;
}
