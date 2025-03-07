package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IWealthClient;
import com.ic.icadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.ic.icadmin.api.service.IApiWealthClientService;
import com.ic.icadmin.controller.BaseController;
import com.ic.icadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 16:24
 **/
@RestController
public class WealthClientController extends BaseController implements IWealthClient {

    @Autowired
    private IApiWealthClientService wealthClientService;

    @Override
    public CommonResponse<List<ApiCommissionOverviewResponse>> queryCommissionOverview() {
        return wealthClientService.queryCommissionOverview(getLoginClient());
    }
}
