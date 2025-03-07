package com.bhg.bhgadmin.controller;


import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.PushByIdRequest;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.notification.NotificationRequest;
import com.bhg.bhgadmin.dto.response.notification.NotificationResponse;
import com.bhg.bhgadmin.service.NotificationService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ljc
 * @since 2023-09-30
 */
@RestController
@RequestMapping("beaver-admin/notification")
public class NotificationController {

    @Resource
    private NotificationService notificationService;

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification')")
    @PostMapping("/queryPage")
    @ApiOperation(value = "queryPage", notes = "query Notification")
    public CommonResponse<PageInfo<NotificationResponse>> queryNotification(@RequestBody NotificationRequest request, int pageNum, int pageSize){
        return notificationService.queryNotification(request, pageNum, pageSize);
    };

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification')")
    @PostMapping("/queryById")
    @ApiModelProperty(value = "queryById", notes = "query Notification By Id")
    public CommonResponse<NotificationResponse> queryById(@RequestBody QueryByIdRequest request){
        return notificationService.queryById(request);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification-edit')")
    @PostMapping("/create")
    @ApiModelProperty(value = "create", notes = "create Notification")
    public CommonResponse<Long> create(NotificationRequest request, @RequestParam(value = "file", required = false) MultipartFile file) throws IOException {
        return notificationService.create(request, file);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification-edit')")
    @PostMapping("/edit")
    @ApiModelProperty(value = "editNotification", notes = "edit Notification")
    public CommonResponse<Long> edit(NotificationRequest request){
        return notificationService.edit(request);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification-edit')")
    @PostMapping("/del")
    @ApiModelProperty(value = "del", notes = "del Notification")
    public CommonResponse<Long> delNotification(@RequestBody QueryByIdRequest request){
        return notificationService.deleteById(request);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'notification-edit')")
    @PostMapping("/push")
    @ApiModelProperty(value = "push", notes = "push")
    public CommonResponse<Long> push(@RequestBody PushByIdRequest request){
        return notificationService.push(request);
    }

}

