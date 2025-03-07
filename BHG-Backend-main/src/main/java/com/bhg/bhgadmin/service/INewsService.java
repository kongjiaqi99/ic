package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.news.NewsCreateRequest;
import com.bhg.bhgadmin.dto.request.news.NewsEditRequest;
import com.bhg.bhgadmin.dto.request.news.NewsQueryRequest;
import com.bhg.bhgadmin.dto.response.news.NewsDetailResponse;
import com.bhg.bhgadmin.dto.response.news.NewsEditDetailResponse;
import com.bhg.bhgadmin.dto.response.news.NewsExportDTO;
import com.bhg.bhgadmin.dto.response.news.NewsResponse;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsNamesResponse;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface INewsService {


    CommonResponse<PageInfo<NewsResponse>> queryNews(NewsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<List<NewsNamesResponse>> queryNewsNames();

    CommonResponse<NewsDetailResponse> queryNewsById(QueryByIdRequest request);

    CommonResponse<Long> createNews(MultipartFile mainPic, NewsCreateRequest request);

    CommonResponse<NewsEditDetailResponse> queryNewsByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> editNews(MultipartFile mainPic, NewsEditRequest request);

    CommonResponse<Long> delNews(QueryByIdRequest request);

    void exportCsv(NewsQueryRequest request, HttpServletResponse response) throws IOException;

    List<NewsExportDTO> exportXml(NewsQueryRequest request);

    String getNewsFileFullPath(String fileType, Long newsId, String fileName);
}
