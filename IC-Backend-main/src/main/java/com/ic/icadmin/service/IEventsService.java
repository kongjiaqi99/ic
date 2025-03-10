package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.PushByIdRequest;
import com.ic.icadmin.dto.request.events.EventCreateRequest;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.events.EventEditRequest;
import com.ic.icadmin.dto.request.events.EventQueryRequest;
import com.ic.icadmin.dto.response.events.EventDetailResponse;
import com.ic.icadmin.dto.response.events.EventEditDetailResponse;
import com.ic.icadmin.dto.response.events.EventTransResponse;
import com.ic.icadmin.dto.response.events.EventsExportDTO;
import com.ic.icadmin.dto.response.events.EventsResponse;
import com.ic.icadmin.entity.EventsEntity;
import com.github.pagehelper.PageInfo;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface IEventsService {

    CommonResponse<PageInfo<EventsResponse>> queryEvents(EventQueryRequest request, int pageNum, int pageSize);

    String getFileFullPath(EventsEntity e);

    CommonResponse<EventDetailResponse> queryEventById(QueryByIdRequest request);

    CommonResponse<List<EventTransResponse>> queryEventTrans();

    CommonResponse<Long> createEvent(EventCreateRequest request) throws IOException;

    CommonResponse<EventEditDetailResponse> queryEventByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> editEvent(EventEditRequest request);

    CommonResponse<Long> delEvent(QueryByIdRequest request);

    void exportEventsCsv(EventQueryRequest request, HttpServletResponse response) throws IOException;

    List<EventsExportDTO> exportEventsXml(EventQueryRequest request);

    String getMainImgFullPath(EventsEntity e);

    void editStatus();

    CommonResponse<String> readAll(QueryByIdRequest request);

    void push(PushByIdRequest request);
}
