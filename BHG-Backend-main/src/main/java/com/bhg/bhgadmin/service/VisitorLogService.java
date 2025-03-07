package com.bhg.bhgadmin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.VisitorQueryRequest;
import com.bhg.bhgadmin.entity.VisitorLog;
import com.github.pagehelper.PageInfo;

/**
 * 服务接口
 *
 * @author ljc
 * @since 2024-06-17 14:41:18
 * @description 由 Mybatisplus Code Generator 创建
 */
public interface VisitorLogService extends IService<VisitorLog> {

    CommonResponse<PageInfo<VisitorLog>> queryPage(VisitorQueryRequest request, int pageNum, int pageSize);

    CommonResponse<String> confirmVisitor(String email);
}
