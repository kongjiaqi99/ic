package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IAuditClients;
import com.ic.icadmin.api.client.IFundsClients;
import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.audit.AuditQueryRequest;
import com.ic.icadmin.dto.request.funds.FundsQueryRequest;
import com.ic.icadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.ic.icadmin.dto.response.audit.AuditResponse;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.ic.icadmin.service.AnnualApproveService;
import com.ic.icadmin.service.AuditService;
import com.ic.icadmin.service.IFundsService;
import com.ic.icadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class AuditClientController implements IAuditClients {

    @Autowired
    private AuditService auditService;
    @Resource
    AnnualApproveService annualApproveService;

    @Override
    public CommonResponse<PageInfo<AuditResponse>> page(PageRequest pageRequest) {
        AuditQueryRequest request = new AuditQueryRequest();
        Long loginUserId = LoginUserUtil.getLoginUserId();
        if (loginUserId != null) {
            request.setCreator(loginUserId);
        } else {
            request.setEmail(LoginUserUtil.getLoginUserName());
        }
        return auditService.queryPage(request, pageRequest.getPageNum(), pageRequest.getPageSize());
    }

    @Override
    public CommonResponse<AuditResponse> detail(QueryByIdRequest request) {
        return auditService.queryById(request.getId());
    }

    @Override
    public CommonResponse<List<AnnualApproveDto>> queryAnnualApprove(AnnualApproveDto dto) {
        return annualApproveService.queryList(dto);
    }
}
