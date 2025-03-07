package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IInvestingFundsClient;
import com.bhg.bhgadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.bhg.bhgadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.bhg.bhgadmin.api.service.IInvestingFundsService;
import com.bhg.bhgadmin.controller.BaseController;
import com.bhg.bhgadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-22 14:31
 **/
@RestController
public class InvestingFundsClientController extends BaseController implements IInvestingFundsClient {

    @Autowired
    private IInvestingFundsService investingFundsService;

    @Override
    public CommonResponse<List<ApiInvestingFundsResponse>> queryInvestmentProject(OtherFundsQueryRequest request) {
        return investingFundsService.queryInvestmentProject(getLoginUserId(), request);
    }

    @Override
    public CommonResponse<List<ApiOtherFundsResponse>> queryOtherFunds(OtherFundsQueryRequest request) {
        return investingFundsService.queryOtherFunds(request, getLoginUserId());
    }
}
