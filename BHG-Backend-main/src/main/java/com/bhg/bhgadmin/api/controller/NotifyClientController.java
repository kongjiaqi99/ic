package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.INotifyClients;
import com.bhg.bhgadmin.api.dto.request.PageRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.notification.NotificationRequest;
import com.bhg.bhgadmin.dto.response.notification.NotificationResponse;
import com.bhg.bhgadmin.service.NotificationService;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: bhg-admin
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
