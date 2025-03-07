package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.DashboardInvestmentRequest;
import com.bhg.bhgadmin.dto.response.DashboardClientsResponse;
import com.bhg.bhgadmin.dto.response.DashboardInvestmentResponse;
import com.bhg.bhgadmin.dto.response.DashboardNumResponse;

import java.util.List;

public interface IDashboardService {

    CommonResponse<List<DashboardClientsResponse>> queryDashboardClients();

    CommonResponse<DashboardNumResponse> queryDashboardNum();

    CommonResponse<List<DashboardInvestmentResponse>> queryInvestment(DashboardInvestmentRequest request);
}
