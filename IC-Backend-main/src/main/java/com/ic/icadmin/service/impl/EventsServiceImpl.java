package com.ic.icadmin.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.api.service.IApiClientService;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.PushByIdRequest;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.events.EventCreateRequest;
import com.ic.icadmin.dto.request.events.EventEditRequest;
import com.ic.icadmin.dto.request.events.EventQueryRequest;
import com.ic.icadmin.dto.response.events.*;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.EventClient;
import com.ic.icadmin.entity.EventsEntity;
import com.ic.icadmin.entity.EventClient;
import com.ic.icadmin.mapper.EventsMapper;
import com.ic.icadmin.service.EventClientService;
import com.ic.icadmin.service.IEventsService;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.enums.EventCityEnum;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.error.CommonErrorEnum;
import com.ic.icadmin.share.error.EventsErrorEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-30 17:48
 **/
@Slf4j
@Service
public class EventsServiceImpl implements IEventsService {

    @Autowired
    private EventsMapper eventsMapper;

    @Autowired
    private ExportService exportService;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Resource
    private IApiClientService apiClientService;

    @Resource
    EventClientService eventClientService;

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Override
    public CommonResponse<PageInfo<EventsResponse>> queryEvents(EventQueryRequest request, int pageNum, int pageSize) {
        if (request == null) {
            request = new EventQueryRequest();
        }
        ClientsEntity loginClient = LoginUserUtil.getLoginClientNormal();
        List<Long> eventIdList;
        if (loginClient != null) {
            List<EventClient> list = eventClientService.list(new LambdaQueryWrapper<EventClient>()
                    .eq(EventClient::getClientId, loginClient.getId()));
            eventIdList = list.stream().map(EventClient::getEventId).collect(Collectors.toList());
        } else {
            eventIdList = null;
        }
        EventQueryRequest finalRequest = request;
        PageInfo<EventsEntity> eventsEntities = PageHelper.startPage(pageNum, pageSize)
            .doSelectPageInfo(()->queryEventsEntities(finalRequest, eventIdList));
        PageInfo<EventsResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(eventsEntities, responses, "list");
        responses.setList(
            eventsEntities.getList().stream().map((EventsEntity e) -> {
                EventsResponse response = new EventsResponse(e);
                if (StringUtils.hasText(e.getMainImg())) {
                    //        https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com
                    String mainImgAllPath = getMainImgFullPath(e);
                    response.setMainImg(mainImgAllPath);
                }
                response.setReadFlag(eventIdList != null && eventIdList.contains(e.getId()));
                response.setFileUrl(getFileFullPath(e));
                return response;
            }).collect(
            Collectors.toList()));
        return CommonResponse.success(responses);
    }

    @Override
    public String getMainImgFullPath(EventsEntity e) {
        String mainImgAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
            .append(ossClientConfig.getBucketName())
            .append(FileUtil.POINT_STR)
            .append(ossClientConfig.getEndpoint())
            .append(FileUtil.SLASH)
            .append(storageProcessor.getFilePathWithoutFileName("event", "main_img", e.getId().toString()))
            .append(e.getMainImg())
            .toString();
        return mainImgAllPath;
    }

    @Override
    public void editStatus() {
        eventsMapper.update(null, new LambdaUpdateWrapper<EventsEntity>()
                .lt(EventsEntity::getStartTime, new Date())
                .set(EventsEntity::getStatus, "End"));
    }

    @Override
    public CommonResponse<String> readAll(QueryByIdRequest request) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient != null && request != null && CollUtil.isNotEmpty(request.getIdList())) {
            List<EventClient> list = eventClientService.list(new LambdaQueryWrapper<EventClient>()
                    .eq(EventClient::getClientId, loginClient.getId())
                    .in(EventClient::getEventId, request.getIdList()));
            Set<Long> notifySet = list.stream().map(EventClient::getEventId).collect(Collectors.toSet());
            List<EventClient> collect = request.getIdList().stream().filter(i -> !notifySet.contains(i))
                    .map(i -> new EventClient(i, loginClient.getId())).collect(Collectors.toList());
            eventClientService.saveBatch(collect);
        }
        return CommonResponse.success();
    }

    @Override
    public void push(PushByIdRequest request) {
        apiClientService.pushEventMsg(request.getClientIdList());
    }

    @Override
    public String getFileFullPath(EventsEntity e) {
        if (StrUtil.isNotBlank(e.getFileUrl())) {
            String mainImgAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
                    .append(ossClientConfig.getBucketName())
                    .append(FileUtil.POINT_STR)
                    .append(ossClientConfig.getEndpoint())
                    .append(FileUtil.SLASH)
                    .append(storageProcessor.getFilePathWithoutFileName("event", "file", e.getId().toString()))
                    .append(e.getFileUrl())
                    .toString();
            return mainImgAllPath;
        }
        return null;
    }

    @Override
    public CommonResponse<EventDetailResponse> queryEventById(QueryByIdRequest request) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient != null) {
            int count = eventClientService.count(new LambdaQueryWrapper<EventClient>()
                    .eq(EventClient::getClientId, loginClient.getId())
                    .eq(EventClient::getEventId, request.getId()));
            if (count == 0) {
                eventClientService.save(new EventClient(request.getId(), loginClient.getId()));
            }
        }
        EventsEntity eventsEntity = eventsMapper.selectOne(
            Wrappers.<EventsEntity>query().lambda().eq(EventsEntity::getId, request.getId()).eq(
                EventsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(eventsEntity)){
            EventsErrorEnum.EVENT_NOT_EXIST.throwException();
        }
        EventDetailResponse response = new EventDetailResponse(eventsEntity);
        if (StringUtils.hasText(eventsEntity.getMainImg())) {
            response.setMainImg(getMainImgFullPath(eventsEntity));
        }
        response.setFileUrl(getFileFullPath(eventsEntity));
        return CommonResponse.success(response);
    }

    @Override
    public CommonResponse<List<EventTransResponse>> queryEventTrans() {
        return CommonResponse.success(eventsMapper.queryEventTrans());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createEvent(EventCreateRequest request) {
        EventsEntity eventsEntity = buildEventEntity(request);
        if (ObjectUtil.isNotNull(request.getMainImg())) {
            eventsEntity.setMainImg(storageProcessor.generateUploadFileName(request.getMainImg().getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(request.getFileUrl())) {
            eventsEntity.setFileUrl(storageProcessor.generateUploadFileName(request.getFileUrl().getOriginalFilename()));
        }
        int insert = eventsMapper.insert(eventsEntity);
        if (insert != 1){
            EventsErrorEnum.EVENT_CREATE_FAIL.throwException();
        }
        if (ObjectUtil.isNotNull(request.getMainImg())) {
            try {
                String filePath = storageProcessor.store(request.getMainImg().getInputStream(), "event", "main_img",
                                                         eventsEntity.getId().toString(), eventsEntity.getMainImg());
            } catch (IOException e) {
                e.printStackTrace();
                EventsErrorEnum.MAIN_IMG_UPLOAD_FAIL.throwException();
            }
        }
        if (ObjectUtil.isNotNull(request.getFileUrl())) {
            try {
                String filePath = storageProcessor.store(request.getFileUrl().getInputStream(), "event", "file",
                        eventsEntity.getId().toString(), eventsEntity.getFileUrl());
            } catch (IOException e) {
                e.printStackTrace();
                EventsErrorEnum.MAIN_IMG_UPLOAD_FAIL.throwException();
            }
        }
        apiClientService.pushEventMsg(null);
        return CommonResponse.success(eventsEntity.getId());
    }

    @Override
    public CommonResponse<EventEditDetailResponse> queryEventByIdWhenEdit(QueryByIdRequest request) {
        EventsEntity entityFromDB = eventsMapper.selectOne(
            Wrappers.<EventsEntity>query().lambda().eq(EventsEntity::getId, request.getId()).eq(
                EventsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            EventsErrorEnum.EVENT_NOT_EXIST.throwException();
        }
        EventEditDetailResponse response = new EventEditDetailResponse();
        response.setId(entityFromDB.getId());
        response.setTitle(entityFromDB.getTitle());
        response.setStartTime(entityFromDB.getStartTime());
        response.setCity(EnumUtil.getEnumMessageByCode(EventCityEnum.class, entityFromDB.getCity()));
        response.setLocation(entityFromDB.getLocation());
        response.setBriefIntroduction(entityFromDB.getBriefIntroduction());
        response.setLanguage(EnumUtil.getEnumMessageByCode(LanguageEnum.class, entityFromDB.getLanguage()));
        response.setTransId(entityFromDB.getTransId());
        response.setStatus(entityFromDB.getStatus());
        response.setType(entityFromDB.getType());
        response.setLink(entityFromDB.getLink());
        return CommonResponse.success(response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> editEvent(EventEditRequest request) {
        EventsEntity entityFromDB = eventsMapper.selectOne(
            Wrappers.<EventsEntity>query().lambda().eq(EventsEntity::getId, request.getId()).eq(
                EventsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            EventsErrorEnum.EVENT_NOT_EXIST.throwException();
        }
        EventsEntity eventsEntity = buildEventEntity(request);
        eventsEntity.setId(request.getId());
        eventsEntity.setCreatedAt(null);
        if (ObjectUtil.isNotNull(request.getMainImg())){
            try {
                // upload main img to oss
                // set only file name in DB
                eventsEntity.setMainImg(storageProcessor.generateUploadFileName(request.getMainImg().getOriginalFilename()));
                String filePath = storageProcessor.store(request.getMainImg().getInputStream(), "event", "main_img",
                                                         eventsEntity.getId().toString(), eventsEntity.getMainImg());
            } catch (IOException e){
                EventsErrorEnum.MAIN_IMG_UPLOAD_FAIL.throwException();
            }
            try {
                // Delete main_img in from Oss
                storageProcessor.delete(
                    new StringBuffer(storageProcessor.getFilePathWithoutFileName("event", "main_img", eventsEntity.getId().toString()))
                        .append(entityFromDB.getMainImg()).toString());
            } catch (IOException e){
                log.error("=====Delete main_img in Event {} from Oss fail=====", request.getId());
            }
        }
        if (ObjectUtil.isNotNull(request.getFileUrl())){
            try {
                // upload main img to oss
                // set only file name in DB
                eventsEntity.setFileUrl(storageProcessor.generateUploadFileName(request.getFileUrl().getOriginalFilename()));
                String filePath = storageProcessor.store(request.getFileUrl().getInputStream(), "event", "file",
                        eventsEntity.getId().toString(), eventsEntity.getFileUrl());
            } catch (IOException e){
                EventsErrorEnum.MAIN_IMG_UPLOAD_FAIL.throwException();
            }
            try {
                // Delete main_img in from Oss
                storageProcessor.delete(
                        new StringBuffer(storageProcessor.getFilePathWithoutFileName("event", "file", eventsEntity.getId().toString()))
                                .append(entityFromDB.getFileUrl()).toString());
            } catch (IOException e){
                log.error("=====Delete main_img in Event {} from Oss fail=====", request.getId());
            }
        }
        int update = eventsMapper.update(null, Wrappers.<EventsEntity>update().lambda()
                                        .set(EventsEntity::getTitle, eventsEntity.getTitle())
                                        .set(EventsEntity::getStartTime, eventsEntity.getStartTime())
                                        .set(EventsEntity::getCity, eventsEntity.getCity())
                                        .set(EventsEntity::getLocation, eventsEntity.getLocation())
                                        .set(EventsEntity::getBriefIntroduction, eventsEntity.getBriefIntroduction())
                                        .set(EventsEntity::getLanguage, eventsEntity.getLanguage())
                                        .set(ObjectUtil.isNotNull(eventsEntity.getMainImg()), EventsEntity::getMainImg, eventsEntity.getMainImg())
                                        .set(ObjectUtil.isNotNull(eventsEntity.getFileUrl()), EventsEntity::getFileUrl, eventsEntity.getFileUrl())
                                        .set(EventsEntity::getTransId, eventsEntity.getTransId())
                                        .set(EventsEntity::getUpdatedAt, eventsEntity.getUpdatedAt())
                                        .set(EventsEntity::getType, eventsEntity.getType())
                                        .set(EventsEntity::getLink, eventsEntity.getLink())
                                        .eq(EventsEntity::getId, eventsEntity.getId()));
        if (update != 1){
            EventsErrorEnum.EVENT_UPDATE_FAIL.throwException();
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delEvent(QueryByIdRequest request) {
        EventsEntity entityFromDB = eventsMapper.selectOne(
            Wrappers.<EventsEntity>query().lambda().eq(EventsEntity::getId, request.getId()).eq(
                EventsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entityFromDB)){
            EventsErrorEnum.EVENT_NOT_EXIST.throwException();
        }
        int update = eventsMapper.update(null, Wrappers.<EventsEntity>update().lambda()
            .set(EventsEntity::getDelFlag,Boolean.TRUE)
            .set(EventsEntity::getUpdatedAt, new Date())
            .eq(EventsEntity::getId, request.getId()));
        if (update != 1) {
            EventsErrorEnum.EVENT_DELETE_FAIL.throwException();
        }
        try {
            // Delete main_img in from Oss
            storageProcessor.delete(
                new StringBuffer(storageProcessor.getFilePathWithoutFileName("event", "main_img", entityFromDB.getId().toString()))
                    .append(entityFromDB.getMainImg()).toString());
        } catch (IOException e){
            log.error("====oss:{} delete failed===", new StringBuffer(storageProcessor.getFilePathWithoutFileName("event", "main_img", entityFromDB.getId().toString()))
                .append(entityFromDB.getMainImg()));
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    public void exportEventsCsv(EventQueryRequest request, HttpServletResponse response) throws IOException {
        List<EventsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_EVENTS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, EventsExportDTO.class);
    }

    @Override
    public List<EventsExportDTO> exportEventsXml(EventQueryRequest request) {
        return queryExportData(request);
    }


    //    ----------------------------------------------------------------------------------------
    private List<EventsEntity> queryEventsEntities(EventQueryRequest request, List<Long> eventIdList) {
        LambdaQueryWrapper<EventsEntity> wrapper = Wrappers.<EventsEntity>query().lambda()
                .like(CharSequenceUtil.isNotBlank(request.getTitle()), EventsEntity::getTitle, request.getTitle())
                .eq(request.getLanguage() != null, EventsEntity::getLanguage, request.getLanguage())
                .eq(CharSequenceUtil.isNotBlank(request.getLocation()), EventsEntity::getLocation, request.getLocation())
                .eq(CharSequenceUtil.isNotBlank(request.getType()), EventsEntity::getType, request.getType())
                .eq(CharSequenceUtil.isNotBlank(request.getStatus()), EventsEntity::getStatus, request.getStatus())
                .eq(EventsEntity::getDelFlag, Boolean.FALSE)
                .in(ObjectUtil.equals(request.getReadFlag(), Boolean.TRUE) && CollUtil.isNotEmpty(eventIdList),
                        EventsEntity::getId, eventIdList)
                .notIn(ObjectUtil.equals(request.getReadFlag(), Boolean.FALSE) && CollUtil.isNotEmpty(eventIdList),
                        EventsEntity::getId, eventIdList)
                .orderByDesc(EventsEntity::getId);
        return eventsMapper.selectList(wrapper);
    }

    private EventsEntity buildEventEntity(EventCreateRequest request){
        EventsEntity eventsEntity = new EventsEntity();
        eventsEntity.setTitle(request.getTitle());
        String format = "yyyy-MM-dd HH:mm:ss";
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            Date startTime = sdf.parse(request.getStartTime());
            eventsEntity.setStartTime(startTime);
        } catch (ParseException e){
            e.printStackTrace();
            CommonErrorEnum.TIME_FORMAT_ERROR.throwException(new Object[]{"Start time"});
        }
        eventsEntity.setCity(request.getCity());
        eventsEntity.setLocation(request.getLocation());
        eventsEntity.setBriefIntroduction(request.getBriefIntroduction());
        eventsEntity.setLanguage(request.getLanguage());
        eventsEntity.setTransId(request.getTrans());
        eventsEntity.setStatus(eventsEntity.getStartTime() != null
                && eventsEntity.getStartTime().after(new Date()) ? "Upcoming" : "End");
        eventsEntity.setType(request.getType());
        eventsEntity.setLink(request.getLink());
        Date now = new Date();
        eventsEntity.setCreatedAt(now);
        eventsEntity.setUpdatedAt(now);
        return eventsEntity;
    }

    private List<EventsExportDTO> queryExportData(EventQueryRequest request) {
        List<EventsEntity> eventsEntities = queryEventsEntities(request, null);
        return eventsEntities.stream().map((EventsEntity e) -> {
            EventsExportDTO eventsExportDTO = new EventsExportDTO(e);
            if (StringUtils.hasText(e.getMainImg())) {
                eventsExportDTO.setMainImg(getMainImgFullPath(e));
            }
            return eventsExportDTO;
        }).collect(Collectors.toList());
    }


}
