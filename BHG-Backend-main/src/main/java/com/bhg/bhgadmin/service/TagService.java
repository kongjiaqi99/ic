package com.bhg.bhgadmin.service;

import java.util.List;

import com.bhg.bhgadmin.dto.request.TagCreateRequestDTO;
import com.bhg.bhgadmin.dto.request.TagRequestDTO;
import com.bhg.bhgadmin.entity.Tags;

public interface TagService {

    void saveTag(TagCreateRequestDTO requestBody);
    void updateTag(TagRequestDTO requestBody);
    List<Tags> findAll();
    Tags getTagById(Long id);
    void deleteTagById(Long id);

}
