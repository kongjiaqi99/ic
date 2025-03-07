package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.LogQueryRequest;
import com.bhg.bhgadmin.entity.AdminUsersEntity;
import com.bhg.bhgadmin.entity.OperateLog;
import com.bhg.bhgadmin.mapper.OperateLogMapper;
import com.bhg.bhgadmin.service.OperateLogService;
import com.bhg.bhgadmin.share.enums.OperateTypeEnum;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.bhg.bhgadmin.share.utils.OperationLogUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 服务接口实现
 *
 * @author ljc
 * @since 2024-06-25 15:00:56
 * @description 由 Mybatisplus Code Generator 创建
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class OperateLogServiceImpl extends ServiceImpl<OperateLogMapper, OperateLog> implements OperateLogService {
    private final OperateLogMapper operateLogMapper;

    @Override
    public void saveLog(String message, Long id, String operType, String name) {
        AdminUsersEntity loginAdmin = LoginUserUtil.getLoginAdmin();
        if (loginAdmin != null) {
            OperateLog operateLog = new OperateLog();
            operateLog.setCreator(loginAdmin.getId());
            operateLog.setCreatorName(loginAdmin.getEmail());
            operateLog.setOperateType(OperateTypeEnum.CREATE.getMessage());
            operateLog.setEntityType(message);
            operateLog.setEntityId(id);
            operateLog.setEntityName(name);
            save(operateLog);
        }
    }

    @Override
    public void saveLog(String message, Long id, String operType, String name, String content) {
        AdminUsersEntity loginAdmin = LoginUserUtil.getLoginAdmin();
        if (loginAdmin != null) {
            OperateLog operateLog = new OperateLog();
            operateLog.setCreator(loginAdmin.getId());
            operateLog.setCreatorName(loginAdmin.getEmail());
            operateLog.setOperateType(OperateTypeEnum.CREATE.getMessage());
            operateLog.setEntityType(message);
            operateLog.setEntityId(id);
            operateLog.setEntityName(name);
            operateLog.setContent(content);
            save(operateLog);
        }
    }

    @Override
    public <T> void saveUpdateLog(String message, Long id, T newObj, T oldObj, String name) {
        Map<String, Pair<Object, Object>> stringPairMap = OperationLogUtil.operationLog(newObj, oldObj);
        AdminUsersEntity loginAdmin = LoginUserUtil.getLoginAdmin();
        if (loginAdmin != null && !MapUtil.isEmpty(stringPairMap)) {
            OperateLog operateLog = new OperateLog();
            operateLog.setContent(JSONUtil.toJsonStr(stringPairMap));
            operateLog.setCreator(loginAdmin.getId());
            operateLog.setCreatorName(loginAdmin.getEmail());
            operateLog.setOperateType(OperateTypeEnum.UPDATE.getMessage());
            operateLog.setEntityType(message);
            operateLog.setEntityId(id);
            operateLog.setEntityName(name);
            save(operateLog);
        }
    }

    @Override
    public CommonResponse<PageInfo<OperateLog>> queryPage(LogQueryRequest request, int pageNum, int pageSize) {
        QueryWrapper<OperateLog> wrapper = new QueryWrapper<>();
        if (CharSequenceUtil.isNotBlank(request.getCreatorName())) {
            wrapper.like( "LOWER(entity_name)", request.getEntityName().toLowerCase());
        }
        if (CharSequenceUtil.isNotBlank(request.getEntityName())) {
            wrapper.like( "LOWER(entity_name)", request.getEntityName().toLowerCase());
        }
        wrapper.lambda()
                .eq(CharSequenceUtil.isNotBlank(request.getOperateType()), OperateLog::getOperateType, request.getOperateType())
                .eq(CharSequenceUtil.isNotBlank(request.getEntityType()), OperateLog::getEntityType, request.getEntityType())
                .eq(ObjectUtil.isNotNull(request.getEntityId()), OperateLog::getEntityId, request.getEntityId())
                .eq(ObjectUtil.isNotNull(request.getCreator()), OperateLog::getCreator, request.getCreator())
                .orderByDesc(OperateLog::getId);
        PageInfo<OperateLog> page =
                PageHelper.startPage(pageNum, pageSize)
                        .doSelectPageInfo(() ->
                                baseMapper.selectList(wrapper)
                        );
        return CommonResponse.success(page);
    }
}