package com.ic.icadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum KycStatusEnum implements CodeEnum {

    WAITING(0,"waiting"),
    APPROVED(1,"approved"),
    NOT_MATCH(2,"not_match"),
    NOT_VERIFIED(3, "not_verified")
    ;

    private Integer code;
    private String message;
}
