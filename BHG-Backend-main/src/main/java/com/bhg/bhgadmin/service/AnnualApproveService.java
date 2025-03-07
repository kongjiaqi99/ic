package com.bhg.bhgadmin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.VisitorQueryRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.entity.AnnualApprove;
import com.bhg.bhgadmin.entity.VisitorLog;
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
