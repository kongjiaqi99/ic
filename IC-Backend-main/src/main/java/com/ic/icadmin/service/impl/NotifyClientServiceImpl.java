package com.ic.icadmin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ic.icadmin.entity.NotifyClient;
import com.ic.icadmin.mapper.NotifyClientMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.ic.icadmin.service.NotifyClientService;
import org.springframework.stereotype.Service;

/**
 * 服务接口实现
 *
 * @author ljc
 * @since 2024-06-14 14:32:20
 * @description 由 Mybatisplus Code Generator 创建
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class NotifyClientServiceImpl extends ServiceImpl<NotifyClientMapper, NotifyClient> implements NotifyClientService {
    private final NotifyClientMapper notifyClientMapper;

}