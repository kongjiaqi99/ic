package com.bhg.bhgadmin.api.client;

import com.bhg.bhgadmin.api.dto.request.PageRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.dto.response.notification.NotificationResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(path = "api/v1/notify")
@Api(tags = "notify")
public interface INotifyClients {

    @PostMapping("/page")
    @ApiOperation(value = "notify page", notes = "notify page")
    CommonResponse<PageInfo<NotificationResponse>> page(@RequestBody PageRequest pageRequest);

    @PostMapping("/detail")
    @ApiOperation(value = "notify detail", notes = "notify detail")
    CommonResponse<NotificationResponse> detail(@RequestBody QueryByIdRequest request);

    @PostMapping("/readAll")
    @ApiOperation(value = "readAll", notes = "readAll")
    CommonResponse<String> readAll(@RequestBody QueryByIdRequest request);
}
