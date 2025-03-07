package com.bhg.bhgadmin.api.service;

import com.bhg.bhgadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.bhg.bhgadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.bhg.bhgadmin.dto.CommonResponse;

import java.util.List;

public interface IInvestingFundsService {

    CommonResponse<List<ApiInvestingFundsResponse>> queryInvestmentProject(Long loginUserId, OtherFundsQueryRequest request);

    CommonResponse<List<ApiOtherFundsResponse>> queryOtherFunds(OtherFundsQueryRequest request, Long loginUserId);
}
