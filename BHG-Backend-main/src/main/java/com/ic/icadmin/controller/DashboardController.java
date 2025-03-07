package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.DashboardInvestmentRequest;
import com.ic.icadmin.dto.response.DashboardClientsResponse;
import com.ic.icadmin.dto.response.DashboardInvestmentResponse;
import com.ic.icadmin.dto.response.DashboardNumResponse;
import com.ic.icadmin.service.IDashboardService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/dashboard")
@PreAuthorize("hasAuthority('dashboard')")
@Api(tags = "Dashboard")
public class DashboardController {

    @Autowired
    private IDashboardService dashboardService;

    @PostMapping("/queryDashboardClients")
    @ApiOperation(value = "queryDashboardClients", notes = "queryDashboardClients")
    CommonResponse<List<DashboardClientsResponse>> queryDashboardClients(){
        return dashboardService.queryDashboardClients();
    }

    @PostMapping("/queryDashboardNum")
    @ApiOperation(value = "queryDashboardNum", notes = "queryDashboardNum")
    CommonResponse<DashboardNumResponse> queryDashboardNum(){
        return dashboardService.queryDashboardNum();
    }

    @PostMapping("/queryInvestment")
    @ApiOperation(value = "queryInvestment", notes = "queryInvestment")
    CommonResponse<List<DashboardInvestmentResponse>> queryInvestment(@RequestBody(required = false) DashboardInvestmentRequest request){
        return dashboardService.queryInvestment(request);
    }
}
