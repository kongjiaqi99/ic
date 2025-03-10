package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IEventsClients;
import com.ic.icadmin.api.dto.request.EventPageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.response.events.EventDetailResponse;
import com.ic.icadmin.dto.response.events.EventsResponse;
import com.ic.icadmin.service.IEventsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: ic-admin
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
