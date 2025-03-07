package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.response.news.NewsImgsUrl;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgsExportDTO;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgsResponse;
import com.bhg.bhgadmin.entity.NewsImgsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsImgsMapper extends BaseMapper<NewsImgsEntity> {

    List<NewsImgsResponse> queryNewsImgs(@Param("newsId") Long newsId);

    NewsImgDetailResponse queryNewsImgById(@Param("id") Long id);

    List<NewsImgsExportDTO> queryExportData(@Param("newsId") Long newsId);

    List<NewsImgsUrl> queryNewsImgsUrls(@Param("newsId") Long newsId);
}