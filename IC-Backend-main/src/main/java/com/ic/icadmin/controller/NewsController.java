package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.news.NewsCreateRequest;
import com.ic.icadmin.dto.request.news.NewsEditRequest;
import com.ic.icadmin.dto.request.news.NewsQueryRequest;
import com.ic.icadmin.dto.response.news.ListNewsExportDTO;
import com.ic.icadmin.dto.response.news.NewsDetailResponse;
import com.ic.icadmin.dto.response.news.NewsEditDetailResponse;
import com.ic.icadmin.dto.response.news.NewsResponse;
import com.ic.icadmin.service.INewsService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-10 14:35
 **/
@RestController
@RequestMapping(path = "beaver-admin/news")
@Api(tags = "news")
public class NewsController {

    @Autowired
    private INewsService newsService;

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/queryNews")
    @ApiOperation(value = "queryNews", notes = "query News")
    CommonResponse<PageInfo<NewsResponse>> queryNews(@RequestBody NewsQueryRequest request,
                                                     int pageNum,
                                                     int pageSize){
        return newsService.queryNews(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/queryNewsById")
    @ApiOperation(value = "queryNewsById", notes = "query News By Id")
    CommonResponse<NewsDetailResponse> queryNewsById(@RequestBody QueryByIdRequest request){
        return newsService.queryNewsById(request);
    }

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/createNews")
    @ApiOperation(value = "createNews", notes = "create News")
    CommonResponse<Long> createNews(@RequestParam(value = "mainPic", required = false) MultipartFile mainPic,
                                    NewsCreateRequest request){
        return newsService.createNews(mainPic, request);
    }

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/queryNewsByIdWhenEdit")
    @ApiOperation(value = "queryNewsByIdWhenEdit", notes = "query News By Id When edit")
    CommonResponse<NewsEditDetailResponse> queryNewsByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return newsService.queryNewsByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/editNews")
    @ApiOperation(value = "editNews", notes = "edit News")
    CommonResponse<Long> editNews(@RequestParam(value = "mainPic", required = false) MultipartFile mainPic,
                                  NewsEditRequest request){
        return newsService.editNews(mainPic, request);
    }

    @PreAuthorize("hasAuthority('news')")
    @PostMapping("/delNews")
    @ApiOperation(value = "delNews", notes = "delete News")
    CommonResponse<Long> delNews(@RequestBody QueryByIdRequest request){
        return newsService.delNews(request);
    }

    @PreAuthorize("hasAuthority('news')")
    @GetMapping("/exportCsv")
    @ApiOperation(value = "exportCsv", notes = "export Csv")
    void exportCsv(@RequestParam(required = false, value = "title") String title,
                   @RequestParam(required = false, value = "newsType") Integer newsType,
                   @RequestParam(required = false, value = "language") Integer language,
                   @RequestParam(required = false, value = "showToWeb") Boolean showToWeb,
                   HttpServletResponse response) throws IOException {
        NewsQueryRequest request = new NewsQueryRequest();
        request.setTitle(title);
        request.setNewsType(newsType);
        request.setLanguage(language);
        request.setShowToWeb(showToWeb);
        newsService.exportCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportXml", notes = "export News Xml")
    ListNewsExportDTO exportXml(@RequestParam(required = false, value = "title") String title,
                                @RequestParam(required = false, value = "newsType") Integer newsType,
                                @RequestParam(required = false, value = "language") Integer language,
                                @RequestParam(required = false, value = "showToWeb") Boolean showToWeb){
        NewsQueryRequest request = new NewsQueryRequest();
        request.setTitle(title);
        request.setNewsType(newsType);
        request.setLanguage(language);
        request.setShowToWeb(showToWeb);
        return new ListNewsExportDTO(newsService.exportXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportJson", notes = "export News Json")
    ListNewsExportDTO exportJson(@RequestParam(required = false, value = "title") String title,
                                @RequestParam(required = false, value = "newsType") Integer newsType,
                                @RequestParam(required = false, value = "language") Integer language,
                                @RequestParam(required = false, value = "showToWeb") Boolean showToWeb){
        NewsQueryRequest request = new NewsQueryRequest();
        request.setTitle(title);
        request.setNewsType(newsType);
        request.setLanguage(language);
        request.setShowToWeb(showToWeb);
        return new ListNewsExportDTO(newsService.exportXml(request));
    }
}
