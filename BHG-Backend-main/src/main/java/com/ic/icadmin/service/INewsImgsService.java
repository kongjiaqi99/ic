package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgCreateRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgEditRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgsQueryRequest;
import com.ic.icadmin.dto.response.news.NewsImgsUrl;
import com.ic.icadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsExportDTO;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsResponse;
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
