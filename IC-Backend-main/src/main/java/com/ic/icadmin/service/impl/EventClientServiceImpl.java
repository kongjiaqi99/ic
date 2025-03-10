package com.ic.icadmin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ic.icadmin.entity.EventClient;
import com.ic.icadmin.mapper.EventClientMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.ic.icadmin.service.EventClientService;
import org.springframework.stereotype.Service;

/**
 * 服务接口实现
 *
 * @author ljc
 * @since 2024-06-14 14:32:16
 * @description 由 Mybatisplus Code Generator 创建
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class EventClientServiceImpl extends ServiceImpl<EventClientMapper, EventClient> implements EventClientService {
    private final EventClientMapper eventClientMapper;

}