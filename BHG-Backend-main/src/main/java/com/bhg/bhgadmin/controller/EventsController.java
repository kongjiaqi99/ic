package com.bhg.bhgadmin.controller;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.PushByIdRequest;
import com.bhg.bhgadmin.dto.request.events.EventCreateRequest;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.events.EventEditRequest;
import com.bhg.bhgadmin.dto.request.events.EventQueryRequest;
import com.bhg.bhgadmin.dto.response.events.EventDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventEditDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventTransResponse;
import com.bhg.bhgadmin.dto.response.events.EventsResponse;
import com.bhg.bhgadmin.dto.response.events.ListEventsExportDTO;
import com.bhg.bhgadmin.service.IEventsService;
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
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/events")
@Api(tags = "Events")
public class EventsController extends BaseController {

    @Autowired
    private IEventsService eventsService;

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/queryEvents")
    @ApiOperation(value = "queryEvents", notes = "query Events")
    public CommonResponse<PageInfo<EventsResponse>> queryEvents(@RequestBody(required = false) EventQueryRequest request, int pageNum, int pageSize){
        return eventsService.queryEvents(request, pageNum, pageSize);
    };

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/queryEventById")
    @ApiModelProperty(value = "queryEventById", notes = "query Event By Id")
    public CommonResponse<EventDetailResponse> queryEventById(@RequestBody QueryByIdRequest request){
        return eventsService.queryEventById(request);
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/queryEventTrans")
    @ApiModelProperty(value = "queryEventTrans", notes = "query Event Trans")
    public CommonResponse<List<EventTransResponse>> queryEventTrans(){
        return eventsService.queryEventTrans();
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/createEvent")
    @ApiModelProperty(value = "createEvent", notes = "create Event")
    public CommonResponse<Long> createEvent(EventCreateRequest request, @RequestParam(value = "mainImg", required = false)
        MultipartFile mainImg, @RequestParam(value = "file", required = false)
                                     MultipartFile file) throws IOException {
        request.setMainImg(mainImg);
        request.setFileUrl(file);
        return eventsService.createEvent(request);
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/queryEventByIdWhenEdit")
    @ApiModelProperty(value = "queryEventByIdWhenEdit", notes = "query Event By Id When Edit")
    public CommonResponse<EventEditDetailResponse> queryEventByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return eventsService.queryEventByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/editEvent")
    @ApiModelProperty(value = "editEvent", notes = "edit Event")
    public CommonResponse<Long> editEvent(EventEditRequest request, @RequestParam(value = "mainImg", required = false)
        MultipartFile mainImg, @RequestParam(value = "file", required = false)
                                   MultipartFile file){
        request.setMainImg(mainImg);
        request.setFileUrl(file);
        return eventsService.editEvent(request);
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/delEvent")
    @ApiModelProperty(value = "delEvent", notes = "edl Event")
    public CommonResponse<Long> delEvent(@RequestBody QueryByIdRequest request){
        return eventsService.delEvent(request);
    }

    @PreAuthorize("hasAuthority('events')")
    @GetMapping("/exportEventsCsv")
    @ApiModelProperty(value = "exportEventsCsv", notes = "export Events Csv")
    void exportEventsCsv(EventQueryRequest request, HttpServletResponse response) throws IOException {
        eventsService.exportEventsCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportEventsXml", notes = "export Events Xml")
    ListEventsExportDTO exportEventsXml(EventQueryRequest request){
        return new ListEventsExportDTO(eventsService.exportEventsXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportEventsJson", notes = "export Events Json")
    ListEventsExportDTO exportEventsJson(EventQueryRequest request){
        return new ListEventsExportDTO(eventsService.exportEventsXml(request));
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/editStatus")
    @ApiModelProperty(value = "editStatus", notes = "timed edit status")
    public CommonResponse<Long> editStatus(){
        eventsService.editStatus();
        return CommonResponse.success();
    }

    @PreAuthorize("hasAuthority('events')")
    @PostMapping("/push")
    @ApiModelProperty(value = "push", notes = "push")
    public CommonResponse<Long> editStatus(@RequestBody PushByIdRequest request){
        eventsService.push(request);
        return CommonResponse.success();
    }
}
