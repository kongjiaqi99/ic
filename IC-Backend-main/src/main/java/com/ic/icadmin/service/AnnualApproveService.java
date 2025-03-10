package com.ic.icadmin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.audit.VisitorQueryRequest;
import com.ic.icadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.ic.icadmin.dto.response.audit.AuditResponse;
import com.ic.icadmin.entity.AnnualApprove;
import com.ic.icadmin.entity.VisitorLog;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 服务接口
 *
 * @author ljc
 * @since 2024-06-17 14:41:18
 * @description 由 Mybatisplus Code Generator 创建
 */
public interface AnnualApproveService extends IService<AnnualApprove> {

    CommonResponse<List<AnnualApproveDto>> queryList(AnnualApproveDto dto);
    CommonResponse<Long> addApprove(AnnualApproveDto dto);

}
