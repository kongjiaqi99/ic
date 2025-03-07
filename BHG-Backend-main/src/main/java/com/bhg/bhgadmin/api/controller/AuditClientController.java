package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IAuditClients;
import com.bhg.bhgadmin.api.client.IFundsClients;
import com.bhg.bhgadmin.api.dto.request.PageRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.request.funds.FundsQueryRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.dto.response.funds.FundDetailResponse;
import com.bhg.bhgadmin.dto.response.funds.FundsResponse;
import com.bhg.bhgadmin.service.AnnualApproveService;
import com.bhg.bhgadmin.service.AuditService;
import com.bhg.bhgadmin.service.IFundsService;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: bhg-admin
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
