package com.bhg.bhgadmin.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.bhg.bhgadmin.DAO.TagDAO;
import com.bhg.bhgadmin.dto.request.TagCreateRequestDTO;
import com.bhg.bhgadmin.dto.request.TagRequestDTO;
import com.bhg.bhgadmin.entity.Tags;
import com.bhg.bhgadmin.service.TagService;

import lombok.AllArgsConstructor;
import lombok.Data;


@Service
@Data
@AllArgsConstructor
@Transactional
public class TagServiceImpl implements TagService {

    private TagDAO tagDAO;
    
    @Override
    public void saveTag(TagCreateRequestDTO requestBody) {
        Tags tag = new Tags();
        tag.setName(requestBody.getName());
        tag.setAbn(requestBody.getAbn());
        tagDAO.save(tag);
    }

    @Override
    public void updateTag(TagRequestDTO requestBody) {
        Tags tag = tagDAO.findById(requestBody.getId());
        if(tag != null) {
            tag.setName(requestBody.getName());
            tag.setAbn(requestBody.getAbn());
            tagDAO.update(tag);
        }
    }

    @Override
    public List<Tags> findAll() {
        // There is tag response DTO, if there are more info needed then use DTO instead
        return tagDAO.findAll();
    }

    @Override
    public Tags getTagById(Long id) {
        return tagDAO.findById(id);
    }

    @Override
    public void deleteTagById(Long id) {
        tagDAO.delete(id);
    }


}
