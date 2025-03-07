package com.bhg.bhgadmin.api.service;

import com.bhg.bhgadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;

import java.util.List;

public interface IApiWealthClientService {

    CommonResponse<List<ApiCommissionOverviewResponse>> queryCommissionOverview(ClientsEntity client);
}
