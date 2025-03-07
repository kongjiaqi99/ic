package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.INotifyClients;
import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.notification.NotificationRequest;
import com.ic.icadmin.dto.response.notification.NotificationResponse;
import com.ic.icadmin.service.NotificationService;
import com.ic.icadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class NotifyClientController implements INotifyClients {

    @Autowired
    private NotificationService notificationService;


    @Override
    public CommonResponse<PageInfo<NotificationResponse>> page(PageRequest pageRequest) {
        NotificationRequest notificationRequest = new NotificationRequest();
        notificationRequest.setClientIdArr(Lists.newArrayList(LoginUserUtil.getLoginUserId()));
        notificationRequest.setReadAll(pageRequest.getReadAll());
        notificationRequest.setReadFlag(pageRequest.getReadFlag());
        return notificationService.queryNotification(notificationRequest, pageRequest.getPageNum(), pageRequest.getPageSize());
    }

    @Override
    public CommonResponse<NotificationResponse> detail(QueryByIdRequest request) {
        return notificationService.queryById(request);
    }

    @Override
    public CommonResponse<String> readAll(QueryByIdRequest request) {
        return notificationService.readAll(request);
    }
}
