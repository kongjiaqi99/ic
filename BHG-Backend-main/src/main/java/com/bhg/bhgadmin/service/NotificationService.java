package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.PushByIdRequest;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.notification.NotificationRequest;
import com.bhg.bhgadmin.dto.response.notification.NotificationResponse;
import com.bhg.bhgadmin.entity.Notification;
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
