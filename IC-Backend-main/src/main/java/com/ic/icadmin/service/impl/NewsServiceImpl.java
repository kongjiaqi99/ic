package com.ic.icadmin.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.news.NewsCreateRequest;
import com.ic.icadmin.dto.request.news.NewsEditRequest;
import com.ic.icadmin.dto.request.news.NewsQueryRequest;
import com.ic.icadmin.dto.response.news.NewsDetailResponse;
import com.ic.icadmin.dto.response.news.NewsEditDetailResponse;
import com.ic.icadmin.dto.response.news.NewsExportDTO;
import com.ic.icadmin.dto.response.news.NewsImgsUrl;
import com.ic.icadmin.dto.response.news.NewsResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsNamesResponse;
import com.ic.icadmin.entity.NewsEntity;
import com.ic.icadmin.mapper.NewsMapper;
import com.ic.icadmin.service.INewsImgsService;
import com.ic.icadmin.service.INewsService;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.error.CommonErrorEnum;
import com.ic.icadmin.share.error.NewsErrorEnum;
import com.ic.icadmin.share.utils.FileUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-10 15:18
 **/
@Slf4j
@Service
public class NewsServiceImpl implements INewsService {

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    private final static String NEWS = "news";
    private final static String MAIN_PIC = "main_pic";

    private final static String NEWS_IMG = "news_img";
    private final static String NEWS_IMG_IMG = "img";

    @Autowired
    private NewsMapper newsMapper;

    @Autowired
    private INewsImgsService newsImgsService;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private ExportService exportService;

    @Override
    public CommonResponse<PageInfo<NewsResponse>> queryNews(NewsQueryRequest request, int pageNum, int pageSize) {
        PageInfo<NewsEntity> newsEntities = PageHelper.startPage(pageNum, pageSize)
                    .doSelectPageInfo(()->queryNewsEntities(request));
        PageInfo<NewsResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(newsEntities, responses, "list");

        List<NewsResponse> responseList = newsEntities.getList().stream().map((NewsEntity n)->{
            NewsResponse newsResponse = new NewsResponse(n);
            if (StringUtils.hasText(n.getMainPic())){
                newsResponse.setMainPic(getNewsFileFullPath(MAIN_PIC, n.getId(), n.getMainPic()));
            }
            return newsResponse;
        }).collect(Collectors.toList());
        responses.setList(responseList);
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<List<NewsNamesResponse>> queryNewsNames() {
        return CommonResponse.success(newsMapper.queryNewsNames());
    }

    @Override
    public CommonResponse<NewsDetailResponse> queryNewsById(QueryByIdRequest request) {
        NewsEntity entity = queryNewsEntity(request.getId());
        List<NewsImgsUrl> newsImgsUrls = newsImgsService.queryNewsImgsUrls(request.getId());
        // add prefix url
        newsImgsUrls.forEach(n -> {
            if (StringUtils.hasText(n.getImg())) {
                n.setImg(getNewsImgFileFullPath(NEWS_IMG_IMG, n.getId(), n.getImg()));
            }
        });
        NewsDetailResponse response = new NewsDetailResponse(entity, newsImgsUrls);
        response.setMainPic(StringUtils.hasText(entity.getMainPic()) ?
                                getNewsFileFullPath(MAIN_PIC, entity.getId(), entity.getMainPic()) : null);
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createNews(MultipartFile mainPic, NewsCreateRequest request) {
        NewsEntity entity = buildNewsEntity(mainPic, request);
        int insert = newsMapper.insert(entity);
        if (insert != 1){
            NewsErrorEnum.NEWS_CREATE_FAIL.throwException();
        }
        if (ObjectUtils.isNotNull(mainPic)){
            saveFileInOss(mainPic, entity);
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<NewsEditDetailResponse> queryNewsByIdWhenEdit(QueryByIdRequest request) {
        NewsEntity entity = queryNewsEntity(request.getId());
        return CommonResponse.success(new NewsEditDetailResponse(entity));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editNews(MultipartFile mainPic, NewsEditRequest request) {
        NewsEntity entityFromDB = queryNewsEntity(request.getId());
        NewsEntity entity = buildNewsEntity(mainPic, request);
        entity.setId(request.getId());
        entity.setCreatedAt(null);
        int update = newsMapper.update(null, Wrappers.<NewsEntity>update().lambda()
                                      .set(NewsEntity::getPublishDate, entity.getPublishDate())
                                      .set(NewsEntity::getTitle, entity.getTitle())
                                      .set(NewsEntity::getContent, entity.getContent())
                                      .set(NewsEntity::getMainPic, entity.getMainPic())
                                      .set(NewsEntity::getShowToWeb, entity.getShowToWeb())
                                      .set(NewsEntity::getUpdatedAt, entity.getUpdatedAt())
                                      .set(NewsEntity::getNewsType, entity.getNewsType())
                                      .set(NewsEntity::getLanguage, entity.getLanguage())
                                      .eq(NewsEntity::getId, entity.getId()));
        if (update != 1){
            NewsErrorEnum.NEWS_UPDATE_FAIL.throwException();
        }

        if (ObjectUtils.isNotNull(mainPic)){
            saveFileInOss(mainPic, entity);
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delNews(QueryByIdRequest request) {
        NewsEntity entityFromDB = queryNewsEntity(request.getId());
        int del = newsMapper.update(null, Wrappers.<NewsEntity>update().lambda()
                         .set(NewsEntity::getDelFlag, Boolean.TRUE)
                         .set(NewsEntity::getUpdatedAt, new Date())
                         .eq(NewsEntity::getId, request.getId())
                         .eq(NewsEntity::getDelFlag, Boolean.FALSE));
        if (del != 1){
            NewsErrorEnum.NEWS_DELETE_FAIL.throwException();
        }
        if (StringUtils.hasText(entityFromDB.getMainPic())){
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    public void exportCsv(NewsQueryRequest request, HttpServletResponse response) throws IOException {
        List<NewsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_NEWS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, NewsExportDTO.class);
    }

    @Override
    public List<NewsExportDTO> exportXml(NewsQueryRequest request) {
        return queryExportData(request);
    }


    //    -------------------------------------------------------------------------------------------------------

    @Override
    public String getNewsFileFullPath(String fileType, Long newsId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(NEWS, fileType, newsId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }

    private String getNewsImgFileFullPath(String fileType, Long newsId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(NEWS_IMG, fileType, newsId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }
    private NewsEntity buildNewsEntity(MultipartFile mainPic, NewsCreateRequest request) {
        NewsEntity entity = new NewsEntity();
        entity.setTitle(request.getTitle());
        if (StringUtils.hasText(request.getPublishDate())) {
            String format = "yyyy-MM-dd";
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(format);
                Date date = sdf.parse(request.getPublishDate());
                entity.setPublishDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
                CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[] {"Publish Date"});
            }
        }
        entity.setShowToWeb(request.getShowToWeb());
        entity.setNewsType(request.getNewsType());
        entity.setLanguage(request.getLanguage());
        if (ObjectUtils.isNotNull(mainPic)){
            entity.setMainPic(storageProcessor.generateUploadFileName(mainPic.getOriginalFilename()));
        }
        Date now = new Date();
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        return entity;
    }

    private List<NewsEntity> queryNewsEntities(NewsQueryRequest request) {
        QueryWrapper<NewsEntity> queryWrapper = Wrappers.<NewsEntity>query();
        if (ObjectUtil.isNotNull(request.getTitle()) && StringUtils.hasText(request.getTitle())){
            queryWrapper.like("LOWER(title)", request.getTitle().toLowerCase());
        }
        queryWrapper
            .eq(ObjectUtils.isNotNull(request.getNewsType()), "news_type", request.getNewsType())
            .eq(ObjectUtils.isNotNull(request.getLanguage()), "language", request.getLanguage())
            .eq(ObjectUtils.isNotNull(request.getShowToWeb()), "show_to_web", request.getShowToWeb())
            .eq("del_flag", Boolean.FALSE)
            .orderByDesc("id");
        List<NewsEntity> newsEntities = newsMapper.selectList(queryWrapper);
        return newsEntities;
    }

    private NewsEntity queryNewsEntity(Long id) {
        NewsEntity entity = newsMapper.selectOne(Wrappers.<NewsEntity>query().lambda()
                                                     .eq(NewsEntity::getId, id)
                                                     .eq(NewsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtils.isNull(entity)){
            NewsErrorEnum.NEWS_NOT_EXIST.throwException();
        }
        return entity;
    }

    private List<NewsExportDTO> queryExportData(NewsQueryRequest request) {
        List<NewsEntity> newsEntities = queryNewsEntities(request);
        List<NewsExportDTO> exportDTOS = newsEntities.stream().map((NewsEntity n)->{
            NewsExportDTO dto = new NewsExportDTO(n);
            if (StringUtils.hasText(n.getMainPic())){
                dto.setMainPic(getNewsFileFullPath(MAIN_PIC, n.getId(), n.getMainPic()));
            }
            return dto;
        }).collect(Collectors.toList());
        return exportDTOS;
    }

    private void saveFileInOss(MultipartFile file, NewsEntity entity) {
        try {
            storageProcessor.store(file.getInputStream(), NEWS, MAIN_PIC,
                                   entity.getId().toString(), entity.getMainPic());
        } catch (IOException e) {
            e.printStackTrace();
            NewsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {MAIN_PIC});
        }
    }

    private void delFileInOss(NewsEntity entityFromDB) {
        if (StringUtils.hasText(entityFromDB.getMainPic())){
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(NEWS, MAIN_PIC,
                                                                entityFromDB.getId().toString())).append(
                    entityFromDB.getMainPic()).toString());
            } catch (IOException delE) {
                log.error("====={}/{}/{}delete Oss failed=====", NEWS, MAIN_PIC, entityFromDB.getId());
            }
        }
    }
}
