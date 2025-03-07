package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.ic.icadmin.dto.CommonResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/wealth")
@Api(tags = "API-infos-Wealth-appreciation")
public interface IWealthClient {

    @PostMapping("/commissions")
    @ApiOperation(value = "commissions", notes = "查询commissions overview")
    CommonResponse<List<ApiCommissionOverviewResponse>> queryCommissionOverview();

}
