package com.ic.icadmin.dto.response;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TagsResponseDTO {
    private List<TagDetails> tags;
}
