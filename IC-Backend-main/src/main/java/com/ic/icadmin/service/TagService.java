package com.ic.icadmin.service;

import java.util.List;

import com.ic.icadmin.dto.request.TagCreateRequestDTO;
import com.ic.icadmin.dto.request.TagRequestDTO;
import com.ic.icadmin.entity.Tags;

public interface TagService {

    void saveTag(TagCreateRequestDTO requestBody);
    void updateTag(TagRequestDTO requestBody);
    List<Tags> findAll();
    Tags getTagById(Long id);
    void deleteTagById(Long id);

}
