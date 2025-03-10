package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.audit.AuditEditRequest;
import com.ic.icadmin.dto.request.audit.AuditQueryRequest;
import com.ic.icadmin.dto.response.audit.AuditResponse;
import com.ic.icadmin.entity.Audit;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
public interface AuditService extends IService<Audit> {

    CommonResponse<PageInfo<AuditResponse>> queryPage(AuditQueryRequest request, int pageNum, int pageSize);

    CommonResponse<Long> editAudit(AuditEditRequest request);

    CommonResponse<AuditResponse> queryById(Long id);
}
