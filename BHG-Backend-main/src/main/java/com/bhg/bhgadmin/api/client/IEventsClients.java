package com.bhg.bhgadmin.api.client;

import com.bhg.bhgadmin.api.dto.request.EventPageRequest;
import com.bhg.bhgadmin.api.dto.request.PageRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.response.events.EventDetailResponse;
import com.bhg.bhgadmin.dto.response.events.EventsResponse;
import com.bhg.bhgadmin.dto.response.funds.FundDetailResponse;
import com.bhg.bhgadmin.dto.response.funds.FundsResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/events")
@Api(tags = "events")
public interface IEventsClients {

    @GetMapping("/page")
    @ApiOperation(value = "events page", notes = "events page")
    CommonResponse<PageInfo<EventsResponse>> page(EventPageRequest pageRequest);

    @GetMapping("/detail")
    @ApiOperation(value = "events detail", notes = "events detail")
    CommonResponse<EventDetailResponse> detail(QueryByIdRequest pageRequest);

    @PostMapping("/readAll")
    @ApiOperation(value = "readAll", notes = "readAll")
    CommonResponse<String> readAll(@RequestBody QueryByIdRequest request);
}
