package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/funds")
@Api(tags = "API-funds")
public interface IFundsClients {

    @GetMapping("/popular")
    @ApiOperation(value = "popular", notes = "popular")
    CommonResponse<List<FundsResponse>> popular();

    @GetMapping("/page")
    @ApiOperation(value = "page", notes = "page")
    CommonResponse<PageInfo<FundsResponse>> page(PageRequest pageRequest);

    @GetMapping("/detail")
    @ApiOperation(value = "detail", notes = "detail")
    CommonResponse<FundDetailResponse> detail(QueryByIdRequest pageRequest);
}
