package com.bhg.bhgadmin.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TagDetails {
    private Long id;
    private String name;
    private String abn;
}

