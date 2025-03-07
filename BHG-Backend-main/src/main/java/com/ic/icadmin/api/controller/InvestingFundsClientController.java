package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IInvestingFundsClient;
import com.ic.icadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.ic.icadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.ic.icadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.ic.icadmin.api.service.IInvestingFundsService;
import com.ic.icadmin.controller.BaseController;
import com.ic.icadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: ic-admin
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
