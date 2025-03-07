package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IWealthClient;
import com.bhg.bhgadmin.api.dto.response.wealth.ApiCommissionOverviewResponse;
import com.bhg.bhgadmin.api.service.IApiWealthClientService;
import com.bhg.bhgadmin.controller.BaseController;
import com.bhg.bhgadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: bhg-admin
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
