package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.DashboardInvestmentRequest;
import com.ic.icadmin.dto.response.DashboardClientsResponse;
import com.ic.icadmin.dto.response.DashboardInvestmentResponse;
import com.ic.icadmin.dto.response.DashboardNumResponse;

import java.util.List;

public interface IDashboardService {

    CommonResponse<List<DashboardClientsResponse>> queryDashboardClients();

    CommonResponse<DashboardNumResponse> queryDashboardNum();

    CommonResponse<List<DashboardInvestmentResponse>> queryInvestment(DashboardInvestmentRequest request);
}
