package com.ic.icadmin.api.service;

import com.ic.icadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.entity.ClientsEntity;

import java.util.List;

public interface IApiWealthClientService {

    CommonResponse<List<ApiCommissionOverviewResponse>> queryCommissionOverview(ClientsEntity client);
}
