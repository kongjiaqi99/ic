package com.ic.icadmin.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgCreateRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgEditRequest;
import com.ic.icadmin.dto.request.newsImgs.NewsImgsQueryRequest;
import com.ic.icadmin.dto.response.news.NewsImgsUrl;
import com.ic.icadmin.dto.response.newsImgs.NewsImgDetailResponse;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsExportDTO;
import com.ic.icadmin.dto.response.newsImgs.NewsImgsResponse;
import com.ic.icadmin.entity.NewsImgsEntity;
import com.ic.icadmin.mapper.NewsImgsMapper;
import com.ic.icadmin.service.INewsImgsService;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.error.NewsImgsErrorEnum;
import com.ic.icadmin.share.utils.FileUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-10 17:37
 **/
@Slf4j
@Service
public class NewsImgsServiceImpl implements INewsImgsService {

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    private final static String NEWS_IMGS = "news_img";

    private final static String IMG = "img";

    @Autowired
    private NewsImgsMapper newsImgsMapper;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private ExportService exportService;

    @Override
    public CommonResponse<PageInfo<NewsImgsResponse>> queryNewsImgs(NewsImgsQueryRequest request, int pageNum, int pageSize) {
        PageInfo<NewsImgsResponse> response = PageHelper.startPage(pageNum, pageSize)
                    .doSelectPageInfo(()->newsImgsMapper.queryNewsImgs(request.getId()));
        response.getList().forEach(r->{
            if (StringUtils.hasText(r.getImg())) {
                r.setImg(getNewsImgFileFullPath(IMG, r.getId(), r.getImg()));
            }
        });
        return CommonResponse.success(response);
    }

    @Override
    public CommonResponse<NewsImgDetailResponse> queryNewsImgById(QueryByIdRequest request) {
        NewsImgDetailResponse response = newsImgsMapper.queryNewsImgById(request.getId());
        if (ObjectUtils.isNull(response)){
            NewsImgsErrorEnum.NEWS_IMG_NOT_EXIST.throwException();
        }
        if (StringUtils.hasText(response.getImg())){
            response.setImg(getNewsImgFileFullPath(IMG, response.getId(), response.getImg()));
        }
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createNewsImg(MultipartFile img, NewsImgCreateRequest request) {
        NewsImgsEntity entity = buildNewsImgEntity(img, request);
        int insert = newsImgsMapper.insert(entity);
        if (insert != 1){
            NewsImgsErrorEnum.NEWS_IMG_CREATE_FAIL.throwException();
        }
        if (ObjectUtils.isNotNull(img)){
            saveFileInOss(img, entity);
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editNewsImg(MultipartFile img, NewsImgEditRequest request) {
        NewsImgsEntity entityFromDB = getEntityFromDB(request.getId());
        NewsImgsEntity entity = buildNewsImgEntity(img, request);
        entity.setId(request.getId());
        entity.setCreatedAt(null);
        int update = newsImgsMapper.update(null, Wrappers.<NewsImgsEntity>update().lambda()
                                          .set(NewsImgsEntity::getImg, entity.getImg())
                                          .set(NewsImgsEntity::getNewsId, entity.getNewsId())
                                          .set(NewsImgsEntity::getDisplayOrder, entity.getDisplayOrder())
                                          .set(NewsImgsEntity::getUpdatedAt, entity.getUpdatedAt())
                                          .eq(NewsImgsEntity::getId, entity.getId()));
        if (update != 1){
            NewsImgsErrorEnum.NEWS_IMG_UPDATE_FAIL.throwException();
        }
        if (ObjectUtils.isNotNull(img)){
            saveFileInOss(img, entity);
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        return CommonResponse.success(entityFromDB.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delNewsImg(QueryByIdRequest request) {
        NewsImgsEntity entityFromDB = getEntityFromDB(request.getId());
        int del = newsImgsMapper.update(null, Wrappers.<NewsImgsEntity>update().lambda()
                             .set(NewsImgsEntity::getDelFlag, Boolean.TRUE)
                             .set(NewsImgsEntity::getUpdatedAt, new Date())
                             .eq(NewsImgsEntity::getId, request.getId())
                             .eq(NewsImgsEntity::getDelFlag, Boolean.FALSE));
        if (del != 1){
            NewsImgsErrorEnum.NEWS_IMG_DELETE_FAIL.throwException();
        }
        if (StringUtils.hasText(entityFromDB.getImg())){
            // del pre file in oss
            CompletableFuture.runAsync(() -> {
                delFileInOss(entityFromDB);
            }, executor);
        }
        return CommonResponse.success(entityFromDB.getId());
    }

    @Override
    public void exportCsv(Long newsId, HttpServletResponse response) throws IOException {
        List<NewsImgsExportDTO> exportDTOS = newsImgsMapper.queryExportData(newsId);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_NEWS_IMGS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, NewsImgsExportDTO.class);
    }

    @Override
    public List<NewsImgsExportDTO> exportXml(Long newsId) {
        return newsImgsMapper.queryExportData(newsId);
    }

    @Override
    public List<NewsImgsUrl> queryNewsImgsUrls(Long newsId) {
        return newsImgsMapper.queryNewsImgsUrls(newsId);
    }


    //    -------------------------------------------------------------------------------------------------------

    @Override
    public String getNewsImgFileFullPath(String fileType, Long newsImgId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName(NEWS_IMGS, fileType, newsImgId.toString()))
            .append(fileName)
            .toString();
        return fundFileAllPath;
    }
    private NewsImgsEntity buildNewsImgEntity(MultipartFile img, NewsImgCreateRequest request) {
        NewsImgsEntity entity = new NewsImgsEntity();
        if (ObjectUtils.isNotNull(img)){
            entity.setImg(storageProcessor.generateUploadFileName(img.getOriginalFilename()));
        }
        entity.setNewsId(request.getNewsId());
        entity.setDisplayOrder(request.getDisplayOrder());
        Date now = new Date();
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        return entity;
    }

    private void saveFileInOss(MultipartFile file, NewsImgsEntity newsImgEntity) {
        try {
            storageProcessor.store(file.getInputStream(), NEWS_IMGS, IMG,
                                   newsImgEntity.getId().toString(), newsImgEntity.getImg());
        } catch (IOException e) {
            e.printStackTrace();
            NewsImgsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {IMG});
        }
    }

    private void delFileInOss(NewsImgsEntity entityFromDB) {
        if (StringUtils.hasText(entityFromDB.getImg())){
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(NEWS_IMGS, IMG,
                                                                entityFromDB.getId().toString())).append(
                    entityFromDB.getImg()).toString());
            } catch (IOException delE) {
                log.error("====={}/{}/{}delete Oss failed=====", NEWS_IMGS, IMG, entityFromDB.getId());
            }
        }
    }

    private NewsImgsEntity getEntityFromDB(Long id) {
        NewsImgsEntity entityFromDB = newsImgsMapper.selectOne(Wrappers.<NewsImgsEntity>query().lambda()
                                                                   .eq(NewsImgsEntity::getId, id)
                                                                   .eq(NewsImgsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtils.isNull(entityFromDB)){
            NewsImgsErrorEnum.NEWS_IMG_NOT_EXIST.throwException();
        }
        return entityFromDB;
    }
}
