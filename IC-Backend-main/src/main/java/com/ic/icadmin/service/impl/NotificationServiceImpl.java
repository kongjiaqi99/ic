package com.ic.icadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.ic.icadmin.api.service.IApiClientService;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.PushByIdRequest;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.notification.NotificationRequest;
import com.ic.icadmin.dto.response.notification.NotificationResponse;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.Notification;
import com.ic.icadmin.entity.NotifyClient;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.mapper.NotificationMapper;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.service.NotificationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ic.icadmin.service.NotifyClientService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.error.FinancingsErrorEnum;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ljc
 * @since 2023-09-30
 */
@Service
public class NotificationServiceImpl extends ServiceImpl<NotificationMapper, Notification> implements NotificationService {
    @Resource
    ClientsMapper clientsMapper;
    @Resource
    private IStorageProcessor storageProcessor;
    private static final String NOTIFY = "notify";
    private static final String FILE = "file";
    @Autowired
    private ThreadPoolTaskExecutor executor;
    @Autowired
    private OssClientConfig ossClientConfig;
    @Resource
    IApiClientService apiClientService;
    @Resource
    NotifyClientService notifyClientService;
    @Override
    public CommonResponse<PageInfo<NotificationResponse>> queryNotification(NotificationRequest request, int pageNum, int pageSize) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClientNormal();
        List<Long> readNotifyList;
        if (loginClient != null) {
            List<NotifyClient> list = notifyClientService.list(new LambdaQueryWrapper<NotifyClient>().eq(NotifyClient::getClientId, loginClient.getId()));
            readNotifyList = list.stream().map(NotifyClient::getNotifyId).collect(Collectors.toList());
        } else {
            readNotifyList = null;
        }
        LambdaQueryWrapper<Notification> wrapper = new LambdaQueryWrapper<Notification>()
                .isNotNull(Notification::getId)
                .like(CharSequenceUtil.isNotBlank(request.getTitle()), Notification::getTitle, request.getTitle())
                .eq(CharSequenceUtil.isNotBlank(request.getStatus()), Notification::getStatus, request.getStatus())
                .in(ObjectUtil.equals(Boolean.TRUE,request.getReadFlag()) && CollUtil.isNotEmpty(readNotifyList),
                        Notification::getId, readNotifyList)
                .notIn(ObjectUtil.equals(Boolean.FALSE, request.getReadFlag()) && CollUtil.isNotEmpty(readNotifyList),
                        Notification::getId, readNotifyList);
        String last = " order by id desc";
        if (request.getClientIdArr() != null) {
            last = "and (" + request.getClientIdArr().get(0) + " = any(client_id_arr) or is_all = true)" + last;
        } else if (loginClient != null) {
            last = "and (" + loginClient.getId() + " = any(client_id_arr) or is_all = true)" + last;
        }
        wrapper.last(last);
        PageInfo<Notification> page =
                PageHelper.startPage(pageNum, pageSize)
                        .doSelectPageInfo(() ->
                                baseMapper.selectList(wrapper)
                        );
        PageInfo<NotificationResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(page, responses, "list");
        List<NotificationResponse> list = BeanUtil.copyToList(page.getList(), NotificationResponse.class);
        if (readNotifyList != null) {
            list.forEach(n-> n.setReadFlag(readNotifyList.contains(n.getId())));
        }
        responses.setList(list);
        if (Boolean.TRUE.equals(request.getReadAll()) && loginClient != null) {
            clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                    .set(ClientsEntity::getReadTime, new Date()).eq(ClientsEntity::getId, loginClient.getId()));
        }
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<NotificationResponse> queryById(QueryByIdRequest request) {
        Notification notification = baseMapper.selectById(request.getId());
        if (notification.getFile() != null) {
            notification.setFile(getFundFileFullPath(NOTIFY, FILE, request.getId(), notification.getFile()));
        }
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient != null) {
            int count = notifyClientService.count(new LambdaQueryWrapper<NotifyClient>()
                    .eq(NotifyClient::getClientId, loginClient.getId())
                    .eq(NotifyClient::getNotifyId, request.getId()));
            if (count == 0) {
                notifyClientService.save(new NotifyClient(request.getId(), loginClient.getId()));
            }
        }
        return CommonResponse.success(BeanUtil.copyProperties(notification, NotificationResponse.class));
    }
    private String getFundFileFullPath(String module, String fileType, Long fundId, String fileName) {
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
                .append(ossClientConfig.getBucketName())
                .append(FileUtil.POINT_STR)
                .append(ossClientConfig.getEndpoint())
                .append(FileUtil.SLASH)
                .append(storageProcessor.getFilePathWithoutFileName(module, fileType, fundId.toString()))
                .append(fileName)
                .toString();
        return fundFileAllPath;
    }
    @Override
    public CommonResponse<Long> create(NotificationRequest request, MultipartFile file) {
        if (CollUtil.isNotEmpty(request.getClientIdArr())) {
            List<ClientsEntity> clientsEntities = clientsMapper.selectList(new LambdaQueryWrapper<ClientsEntity>().in(ClientsEntity::getId, request.getClientIdArr()));
            request.setClientIdArr(clientsEntities.stream().map(ClientsEntity::getId).collect(Collectors.toList()));
            request.setClientNameArr(clientsEntities.stream().map(ClientsEntity::getName).collect(Collectors.toList()));
        }

        Notification notification = BeanUtil.copyProperties(request, Notification.class);
        if (ObjectUtil.isNotNull(file)){
            notification.setFile(storageProcessor.generateUploadFileName(
                    file.getOriginalFilename()));
        }
        save(notification);
        if (ObjectUtil.isNotNull(file)) {
            saveFileInOss(file, notification);
        }
        apiClientService.pushMsg(notification);
        return CommonResponse.success(notification.getId());
    }

    private void saveFileInOss(MultipartFile referralAgreement, Notification entity) {
        try {
            storageProcessor.store(referralAgreement.getInputStream(), NOTIFY, FILE,
                    entity.getId().toString(), entity.getFile()
            );
        } catch (IOException e) {
            e.printStackTrace();
            FinancingsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[] {FILE});
        }
    }
    @Override
    public CommonResponse<Long> edit(NotificationRequest request) {
        if (CollUtil.isNotEmpty(request.getClientIdArr())) {
            List<ClientsEntity> clientsEntities = clientsMapper.selectList(new LambdaQueryWrapper<ClientsEntity>().in(ClientsEntity::getId, request.getClientIdArr()));
            request.setClientIdArr(clientsEntities.stream().map(ClientsEntity::getId).collect(Collectors.toList()));
            request.setClientNameArr(clientsEntities.stream().map(ClientsEntity::getName).collect(Collectors.toList()));
        }
        Notification notification = BeanUtil.copyProperties(request, Notification.class);
        updateById(notification);
        return CommonResponse.success(notification.getId());
    }

    @Override
    public CommonResponse<Long> deleteById(QueryByIdRequest request) {
        baseMapper.deleteById(request.getId());
        return CommonResponse.success(request.getId());
    }

    @Override
    public CommonResponse<String> readAll(QueryByIdRequest request) {
        ClientsEntity loginClient = LoginUserUtil.getLoginClient();
        if (loginClient != null && request != null && CollUtil.isNotEmpty(request.getIdList())) {
            List<NotifyClient> list = notifyClientService.list(new LambdaQueryWrapper<NotifyClient>()
                    .eq(NotifyClient::getClientId, loginClient.getId())
                    .in(NotifyClient::getNotifyId, request.getIdList()));
            Set<Long> notifySet = list.stream().map(NotifyClient::getNotifyId).collect(Collectors.toSet());
            List<NotifyClient> collect = request.getIdList().stream().filter(i -> !notifySet.contains(i))
                    .map(i -> new NotifyClient(i, loginClient.getId())).collect(Collectors.toList());
            notifyClientService.saveBatch(collect);
        }
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<Long> push(PushByIdRequest request) {
        if (request != null && request.getMsgId() != null) {
            Notification notification = baseMapper.selectById(request.getMsgId());
            if (notification != null) {
                notifyClientService.remove(new LambdaQueryWrapper<NotifyClient>()
                        .eq(NotifyClient::getNotifyId, request.getMsgId()));
            }
            apiClientService.pushMsg(notification);
        }
        return CommonResponse.success();
    }
}
