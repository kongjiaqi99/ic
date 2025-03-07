package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.newsImgs.NewsImgCreateRequest;
import com.bhg.bhgadmin.dto.request.newsImgs.NewsImgEditRequest;
import com.bhg.bhgadmin.dto.request.newsImgs.NewsImgsQueryRequest;
import com.bhg.bhgadmin.dto.response.news.NewsImgsUrl;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgsExportDTO;
import com.bhg.bhgadmin.dto.response.newsImgs.NewsImgsResponse;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface INewsImgsService {


    CommonResponse<PageInfo<NewsImgsResponse>> queryNewsImgs(NewsImgsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<NewsImgDetailResponse> queryNewsImgById(QueryByIdRequest request);

    CommonResponse<Long> createNewsImg(MultipartFile img, NewsImgCreateRequest request);

    CommonResponse<Long> editNewsImg(MultipartFile img, NewsImgEditRequest request);

    CommonResponse<Long> delNewsImg(QueryByIdRequest request);

    void exportCsv(Long newsId, HttpServletResponse response) throws IOException;

    List<NewsImgsExportDTO> exportXml(Long newsId);

    List<NewsImgsUrl> queryNewsImgsUrls(Long newsId);

    String getNewsImgFileFullPath(String fileType, Long newsImgId, String fileName);
}
