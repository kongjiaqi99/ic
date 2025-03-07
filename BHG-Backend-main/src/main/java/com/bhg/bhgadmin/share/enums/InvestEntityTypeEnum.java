package com.bhg.bhgadmin.share.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum InvestEntityTypeEnum implements CodeEnum {

    INDIVIDUAL(0, "Individual"),
    COMPANY(1, "Company"),
    SUPERANNUATION_I(7, "Superannuation Fund (Individual)"),
    JOINT(8, "Joint Holding"),
    FAMILY_TRUST_I(9, "Family Trust (Individual)"),
    FAMILY_TRUST_C(10, "Family Trust (Corporate Trustee)"),
    SUPERANNUATION_T(11, "Superannuation Fund (Corporate Trustee)"),
    TRUST_I(12, "Trust (Individual)"),
    TRUST_C(13, "Trust (Corporate)"),
    ;

    private Integer code;
    private String message;
}
