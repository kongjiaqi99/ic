package com.ic.icadmin.dto.response;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class FundDetails {
    private Long id;
    private String name;
    private String endDate;
}
