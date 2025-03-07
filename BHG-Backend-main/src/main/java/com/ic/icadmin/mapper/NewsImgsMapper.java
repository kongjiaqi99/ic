package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.response.news.NewsImgsUrl;
import com.ic.icadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsExportDTO;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsResponse;
import com.ic.icadmin.entity.NewsImgsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsImgsMapper extends BaseMapper<NewsImgsEntity> {

    List<NewsImgsResponse> queryNewsImgs(@Param("newsId") Long newsId);

    NewsImgDetailResponse queryNewsImgById(@Param("id") Long id);

    List<NewsImgsExportDTO> queryExportData(@Param("newsId") Long newsId);

    List<NewsImgsUrl> queryNewsImgsUrls(@Param("newsId") Long newsId);
}