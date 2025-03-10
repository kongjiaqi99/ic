package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.PushByIdRequest;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.notification.NotificationRequest;
import com.ic.icadmin.dto.response.notification.NotificationResponse;
import com.ic.icadmin.entity.Notification;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ljc
 * @since 2023-09-30
 */
public interface NotificationService extends IService<Notification> {

    CommonResponse<PageInfo<NotificationResponse>> queryNotification(NotificationRequest request, int pageNum, int pageSize);

    CommonResponse<NotificationResponse> queryById(QueryByIdRequest request);

    CommonResponse<Long> create(NotificationRequest request, MultipartFile file);

    CommonResponse<Long> edit(NotificationRequest request);

    CommonResponse<Long> deleteById(QueryByIdRequest request);

    CommonResponse<String> readAll(QueryByIdRequest request);

    CommonResponse<Long> push(PushByIdRequest request);
}
