package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.AuditEditRequest;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.entity.Audit;
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
