package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.response.audit.AuditResponse;
import com.ic.icadmin.dto.response.notification.NotificationResponse;
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
