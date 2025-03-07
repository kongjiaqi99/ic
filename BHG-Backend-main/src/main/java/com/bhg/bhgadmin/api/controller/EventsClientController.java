package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IEventsClients;
import com.bhg.bhgadmin.api.dto.request.EventPageRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.response.events.EventDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventsResponse;
import com.bhg.bhgadmin.service.IEventsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class EventsClientController implements IEventsClients {

    @Autowired
    private IEventsService eventsService;

    @Override
    public CommonResponse<PageInfo<EventsResponse>> page(EventPageRequest pageRequest) {
        return eventsService.queryEvents(pageRequest, pageRequest.getPageNum(), pageRequest.getPageSize());
    }

    @Override
    public CommonResponse<EventDetailResponse> detail(QueryByIdRequest idRequest) {
        return eventsService.queryEventById(idRequest);
    }

    @Override
    public CommonResponse<String> readAll(QueryByIdRequest request) {
        return eventsService.readAll(request);
    }
}
