package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsNamesResponse;
import com.bhg.bhgadmin.entity.NewsEntity;

import java.util.List;

public interface NewsMapper extends BaseMapper<NewsEntity> {

    List<NewsNamesResponse> queryNewsNames();
}