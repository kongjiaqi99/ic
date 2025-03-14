package com.ic.icadmin.api.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.ic.icadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.ic.icadmin.api.service.IApiActivitiesService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.entity.EventsEntity;
import com.ic.icadmin.mapper.EventsMapper;
import com.ic.icadmin.service.IEventsService;
import com.ic.icadmin.share.enums.EventCityEnum;
import com.ic.icadmin.share.enums.EventStatusEnum;
import com.ic.icadmin.share.utils.DateFormatUtil;
import com.ic.icadmin.share.utils.EnumUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 13:37
 **/
@Slf4j
@Service
public class ApiActivitiesServiceImpl implements IApiActivitiesService {

    @Autowired
    private EventsMapper eventsMapper;

    @Autowired
    private IEventsService eventsService;

    @Override
    public CommonResponse<List<RecentActivitiesQueryResponse>> queryRecentActivities(RecentActivitiesQueryRequest request) {
        List<RecentActivitiesQueryResponse> responses = new ArrayList<>();
        List<EventsEntity> eventsEntities = eventsMapper.selectList(Wrappers.<EventsEntity>query().lambda()
                               .eq(ObjectUtil.isNotNull(request.getCity()), EventsEntity::getCity, request.getCity())
                               .eq(ObjectUtil.isNotNull(request.getLanguage()), EventsEntity::getLanguage, request.getLanguage())
                               .eq(EventsEntity::getDelFlag, Boolean.FALSE)
                               .orderByDesc(EventsEntity::getId)
                               .last(ObjectUtil.isNotNull(request.getNumLimit()), "limit " + request.getNumLimit()));

        if (CollectionUtil.isEmpty(eventsEntities)){
            return CommonResponse.success(responses);
        }
        Date now = new Date();
        for (EventsEntity event : eventsEntities){
            RecentActivitiesQueryResponse response = new RecentActivitiesQueryResponse();
            response.setId(event.getId());
            response.setTitle(event.getTitle());
            response.setTime(DateFormatUtil.getMHHmm(event.getStartTime()));
            response.setLocation(EnumUtil.getEnumMessageByCode(EventCityEnum.class, event.getCity()));
            response.setMainPic(eventsService.getMainImgFullPath(event));
            response.setDescription(event.getBriefIntroduction());
            responses.add(response);
            if (ObjectUtil.isNotNull(event.getStartTime()) && now.before(event.getStartTime())){
                response.setActivityStatus(EventStatusEnum.NOT_OPEN);
            } else if (ObjectUtil.isNotNull(event.getStartTime()) && now.after(event.getStartTime()) && DateUtil.isSameDay(now, event.getStartTime())){
                response.setActivityStatus(EventStatusEnum.OPEN);
            } else {
                response.setActivityStatus(EventStatusEnum.ENDED);
            }
        }
        return CommonResponse.success(responses);
    }
}
