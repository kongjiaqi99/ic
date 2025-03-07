package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.PushByIdRequest;
import com.bhg.bhgadmin.dto.request.events.EventCreateRequest;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.events.EventEditRequest;
import com.bhg.bhgadmin.dto.request.events.EventQueryRequest;
import com.bhg.bhgadmin.dto.response.events.EventDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventEditDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventTransResponse;
import com.bhg.bhgadmin.dto.response.events.EventsExportDTO;
import com.bhg.bhgadmin.dto.response.events.EventsResponse;
import com.bhg.bhgadmin.entity.EventsEntity;
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
