package com.bhg.bhgadmin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.LogQueryRequest;
import com.bhg.bhgadmin.entity.OperateLog;
import com.github.pagehelper.PageInfo;

/**
 * 服务接口
 *
 * @author ljc
 * @since 2024-06-25 15:00:56
 * @description 由 Mybatisplus Code Generator 创建
 */
public interface OperateLogService extends IService<OperateLog> {

    void saveLog(String message, Long id, String operType, String name);

    void saveLog(String message, Long id, String operType, String name, String content);

    <T> void saveUpdateLog(String message, Long id, T newObj, T oldObj, String name);

    CommonResponse<PageInfo<OperateLog>> queryPage(LogQueryRequest request, int pageNum, int pageSize);
}
