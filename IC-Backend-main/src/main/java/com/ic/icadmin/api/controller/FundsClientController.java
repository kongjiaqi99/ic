package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IFundsClients;
import com.ic.icadmin.api.client.IInfosClient;
import com.ic.icadmin.api.dto.request.PageRequest;
import com.ic.icadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.ic.icadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.ic.icadmin.api.dto.response.news.ApiNewsResponse;
import com.ic.icadmin.api.service.IApiInfosService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.funds.FundsQueryRequest;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.ic.icadmin.service.IFundsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class FundsClientController implements IFundsClients {

    @Autowired
    private IFundsService fundsService;

    @Override
    public CommonResponse<List<FundsResponse>> popular() {
        return fundsService.popular();
    }

    @Override
    public CommonResponse<PageInfo<FundsResponse>> page(PageRequest pageRequest) {
        FundsQueryRequest fundsQueryRequest = new FundsQueryRequest();
        if (pageRequest != null) {
            fundsQueryRequest.setFundCategory( pageRequest.getFundCategory());
            fundsQueryRequest.setFundStatusList(pageRequest.getFundStatusList());
            fundsQueryRequest.setFundStatus(pageRequest.getFundStatus());
            fundsQueryRequest.setHistory(pageRequest.getHistory());
            fundsQueryRequest.setEntityId(pageRequest.getEntityId());
            fundsQueryRequest.setStateId(pageRequest.getStateId());
            fundsQueryRequest.setCompany(pageRequest.getCompany());
        }
        return fundsService.queryFunds(fundsQueryRequest, pageRequest != null ? pageRequest.getPageNum() : 1,
                pageRequest != null ? pageRequest.getPageSize() : 10);
    }

    @Override
    public CommonResponse<FundDetailResponse> detail(QueryByIdRequest pageRequest) {
        return fundsService.queryFundById(pageRequest);
    }
}
