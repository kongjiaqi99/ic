package com.ic.icadmin.service.impl;

import cn.hutool.core.text.CharSequenceUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.audit.VisitorQueryRequest;
import com.ic.icadmin.dto.request.client.ClientCreateRequest;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.OperateLog;
import com.ic.icadmin.entity.VisitorLog;
import com.ic.icadmin.mapper.ClientsMapper;
import com.ic.icadmin.mapper.VisitorLogMapper;
import com.ic.icadmin.service.IClientService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.ic.icadmin.service.VisitorLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 服务接口实现
 *
 * @author ljc
 * @since 2024-06-17 14:41:18
 * @description 由 Mybatisplus Code Generator 创建
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class VisitorLogServiceImpl extends ServiceImpl<VisitorLogMapper, VisitorLog> implements VisitorLogService {
    private final VisitorLogMapper visitorLogMapper;
    @Resource
    private ClientsMapper clientsMapper;
    @Resource
    private IClientService clientService;

    @Override
    public CommonResponse<PageInfo<VisitorLog>> queryPage(VisitorQueryRequest request, int pageNum, int pageSize) {
        QueryWrapper<VisitorLog> wrapper = new QueryWrapper<>();
        if (CharSequenceUtil.isNotBlank(request.getEmail())) {
            wrapper.like( "LOWER(email)", request.getEmail().toLowerCase());
        }
        if (CharSequenceUtil.isNotBlank(request.getStatus())) {
            wrapper.like("LOWER(status)", request.getEmail().toLowerCase());
        }
        wrapper.lambda()
                .ge(CharSequenceUtil.isNotBlank(request.getStartDate()), VisitorLog::getLoginTime, request.getStartDate())
                .eq(CharSequenceUtil.isNotBlank(request.getEndDate()), VisitorLog::getLoginTime, request.getEndDate())
                .orderByDesc(VisitorLog::getId);
        PageInfo<VisitorLog> page =
                PageHelper.startPage(pageNum, pageSize)
                        .doSelectPageInfo(() ->
                                baseMapper.selectList(wrapper)
                        );
        return CommonResponse.success(page);
    }

    @Override
    public CommonResponse<String> confirmVisitor(String email) {
        if (CharSequenceUtil.isBlank(email)) {
            CommonResponse.error("missing email");
        }
        Integer integer = clientsMapper.selectCount(new LambdaQueryWrapper<ClientsEntity>()
                .eq(ClientsEntity::getEmail, email).eq(ClientsEntity::getDelFlag, Boolean.FALSE));
        if (integer == null || integer < 1) {
            ClientCreateRequest clientCreateRequest = new ClientCreateRequest();
            clientCreateRequest.setEmail(email);
            clientService.createClient(clientCreateRequest);
            update(new LambdaUpdateWrapper<VisitorLog>().set(VisitorLog::getStatus, "Confirmed")
                    .eq(VisitorLog::getEmail, email));
        }
        return CommonResponse.success(email);
    }
}