package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AuditStatusEnum implements CodeEnum {

    PENDING_APPROVAL(0,"Pending approval"),
    APPROVED(1,"Approved"),
    REJECTED(2,"Rejected"),
    ;

    private Integer code;
    private String message;
}
