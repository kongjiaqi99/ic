package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.response.newsImgs.NewsNamesResponse;
import com.ic.icadmin.entity.NewsEntity;

import java.util.List;

public interface NewsMapper extends BaseMapper<NewsEntity> {

    List<NewsNamesResponse> queryNewsNames();
}