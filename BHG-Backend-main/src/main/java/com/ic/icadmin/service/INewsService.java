package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.news.NewsCreateRequest;
import com.ic.icadmin.dto.request.news.NewsEditRequest;
import com.ic.icadmin.dto.request.news.NewsQueryRequest;
import com.ic.icadmin.dto.response.news.NewsDetailResponse;
import com.ic.icadmin.dto.response.news.NewsEditDetailResponse;
import com.ic.icadmin.dto.response.news.NewsExportDTO;
import com.ic.icadmin.dto.response.news.NewsResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsNamesResponse;
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
