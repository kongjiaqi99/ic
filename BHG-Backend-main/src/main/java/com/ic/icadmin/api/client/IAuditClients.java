package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.ic.icadmin.dto.response.audit.AuditResponse;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/audit")
@Api(tags = "audit")
public interface IAuditClients {

    @PostMapping("/page")
    @ApiOperation(value = "audit page", notes = "audit page")
    CommonResponse<PageInfo<AuditResponse>> page(@RequestBody PageRequest pageRequest);

    @PostMapping("/detail")
    @ApiOperation(value = "audit detail", notes = "audit detail")
    CommonResponse<AuditResponse> detail(@RequestBody QueryByIdRequest pageRequest);

    @PostMapping("/queryAnnualApprove")
    @ApiOperation(value = "queryAnnualApprove", notes = "queryAnnualApprove")
    CommonResponse<List<AnnualApproveDto>> queryAnnualApprove(@RequestBody AnnualApproveDto dto);

}
