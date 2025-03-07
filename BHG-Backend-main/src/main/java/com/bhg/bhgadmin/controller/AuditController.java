package com.bhg.bhgadmin.controller;


import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.AuditEditRequest;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.request.audit.LogQueryRequest;
import com.bhg.bhgadmin.dto.request.audit.VisitorQueryRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.entity.OperateLog;
import com.bhg.bhgadmin.entity.VisitorLog;
import com.bhg.bhgadmin.service.AnnualApproveService;
import com.bhg.bhgadmin.service.AuditService;
import com.bhg.bhgadmin.service.OperateLogService;
import com.bhg.bhgadmin.service.VisitorLogService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
@RestController
@RequestMapping("beaver-admin/audit")
public class AuditController {

    @Resource
    AuditService auditService;

    @Resource
    OperateLogService logService;

    @Resource
    VisitorLogService visitorLogService;

    @Resource
    AnnualApproveService annualApproveService;

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/queryPage")
    @ApiOperation(value = "queryPage", notes = "queryAuditList")
    public CommonResponse<PageInfo<AuditResponse>> queryAuditList(@RequestBody AuditQueryRequest request,
                                                           int pageNum, int pageSize){
        return auditService.queryPage(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/queryById")
    @ApiOperation(value = "queryById", notes = "queryById")
    public CommonResponse<AuditResponse> queryById(@RequestBody AuditQueryRequest request){
        return auditService.queryById(request.getId());
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit-edit')")
    @PostMapping("/edit")
    @ApiOperation(value = "edit", notes = "editAudit")
    public CommonResponse<Long> editAudit(@RequestBody AuditEditRequest request){
        return auditService.editAudit(request);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/queryOperateLogPage")
    @ApiOperation(value = "queryOperateLogPage", notes = "queryOperateLogPage")
    public CommonResponse<PageInfo<OperateLog>> queryAuditList(@RequestBody LogQueryRequest request,
                                                               int pageNum, int pageSize){
        if (request == null) {
            request = new LogQueryRequest();
        }
        return logService.queryPage(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/queryVisitorLogPage")
    @ApiOperation(value = "queryVisitorLogPage", notes = "queryVisitorLogPage")
    public CommonResponse<PageInfo<VisitorLog>> queryVisitorLogPage(@RequestBody VisitorQueryRequest request,
                                                               int pageNum, int pageSize){
        if (request == null) {
            request = new VisitorQueryRequest();
        }
        return visitorLogService.queryPage(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/confirmVisitor")
    @ApiOperation(value = "queryVisitorLogPage", notes = "queryVisitorLogPage")
    public CommonResponse<String> confirmVisitor(@RequestBody VisitorQueryRequest request){
        return visitorLogService.confirmVisitor(request.getEmail());
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/queryAnnualApprove")
    @ApiOperation(value = "queryAnnualApprove", notes = "queryAnnualApprove")
    public CommonResponse<List<AnnualApproveDto>> queryAnnualApprove(@RequestBody AnnualApproveDto dto){
        return annualApproveService.queryList(dto);
    }

    @PreAuthorize("hasAnyAuthority('admin-users', 'audit')")
    @PostMapping("/addApprove")
    @ApiOperation(value = "addApprove", notes = "addApprove")
    public CommonResponse<Long> addApprove(@RequestBody AnnualApproveDto dto){
        return annualApproveService.addApprove(dto);
    }
}

