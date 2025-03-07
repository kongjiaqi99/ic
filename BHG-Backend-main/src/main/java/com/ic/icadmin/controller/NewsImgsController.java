package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgCreateRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgEditRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgsQueryRequest;
import com.ic.icadmin.dto.response.newsImgs.ListNewsImgsExportDTO;
import com.ic.icadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsNamesResponse;
import com.ic.icadmin.service.INewsImgsService;
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
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-10 14:35
 **/
@RestController
@RequestMapping(path = "beaver-admin/news-imgs")
@Api(tags = "news-imgs")
public class NewsImgsController {

    @Autowired
    private INewsService newsService;

    @Autowired
    private INewsImgsService newsImgsService;

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/queryNewsNames")
    @ApiOperation(value = "queryNewsNames", notes = "query News Names")
    CommonResponse<List<NewsNamesResponse>> queryNewsNames(){
        return newsService.queryNewsNames();
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/queryNewsImgs")
    @ApiOperation(value = "queryNewsImgs", notes = "query News Imgs")
    CommonResponse<PageInfo<NewsImgsResponse>> queryNewsImgs(@RequestBody NewsImgsQueryRequest request,
                                                             @RequestParam int pageNum,
                                                             @RequestParam int pageSize){
        return newsImgsService.queryNewsImgs(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/queryNewsImgById")
    @ApiOperation(value = "queryNewsImgById", notes = "query News img By Id")
    CommonResponse<NewsImgDetailResponse> queryNewsImgById(@RequestBody QueryByIdRequest request){
        return newsImgsService.queryNewsImgById(request);
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/createNewsImg")
    @ApiOperation(value = "createNewsImg", notes = "create News Img")
    CommonResponse<Long> createNewsImg(@RequestParam(value = "img", required = false) MultipartFile img,
                                       NewsImgCreateRequest request){
        return newsImgsService.createNewsImg(img, request);
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/editNewsImg")
    @ApiOperation(value = "editNewsImg", notes = "edit News Img")
    CommonResponse<Long> editNewsImg(@RequestParam(value = "img", required = false) MultipartFile img,
                                     NewsImgEditRequest request){
        return newsImgsService.editNewsImg(img, request);
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @PostMapping("/delNewsImg")
    @ApiOperation(value = "delNewsImg", notes = "Delete News Img")
    CommonResponse<Long> delNewsImg(@RequestBody QueryByIdRequest request){
        return newsImgsService.delNewsImg(request);
    }

    @PreAuthorize("hasAuthority('news-imgs')")
    @GetMapping("/exportCsv")
    @ApiModelProperty(value = "exportCsv", notes = "export News Imgs Csv")
    void exportCsv(@RequestParam(required = false, value = "newsId") Long newsId,
                           HttpServletResponse response) throws IOException {
        newsImgsService.exportCsv(newsId, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportXml", notes = "export News Imgs Xml")
    ListNewsImgsExportDTO exportXml(@RequestParam(required = false, value = "newsId") Long newsId){
        return new ListNewsImgsExportDTO(newsImgsService.exportXml(newsId));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportJson", notes = "export News Imgs Json")
    ListNewsImgsExportDTO exportJson(@RequestParam(required = false, value = "newsId") Long newsId){
        return new ListNewsImgsExportDTO(newsImgsService.exportXml(newsId));
    }

}
