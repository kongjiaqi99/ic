package com.ic.icadmin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.dto.request.DictionaryQueryRequest;
import com.ic.icadmin.dto.response.DictionaryResponse;
import com.ic.icadmin.entity.DictionaryEntity;
import com.ic.icadmin.mapper.DictionaryMapper;
import com.ic.icadmin.service.IDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 19:27
 **/
@Service
public class DictionaryServiceImpl implements IDictionaryService {

    @Autowired
    private DictionaryMapper dictionaryMapper;

    @Override
    public List<DictionaryResponse> queryDictionaryByType(DictionaryQueryRequest request) {
        LambdaQueryWrapper<DictionaryEntity> queryWrapper = Wrappers.<DictionaryEntity>query().lambda().eq(
            DictionaryEntity::getType, request.getType()).eq(DictionaryEntity::getDelFlag, Boolean.FALSE).orderByAsc(DictionaryEntity::getSort);
        List<DictionaryEntity> dictionaryEntityList = dictionaryMapper.selectList(queryWrapper);
        List<DictionaryResponse> responses = dictionaryEntityList.stream().map(
            (DictionaryEntity t) -> new DictionaryResponse(t.getId(), t.getType(), t.getCode(), t.getValue(), t.getSort())).collect(
            Collectors.toList());
        return responses;
    }
}
