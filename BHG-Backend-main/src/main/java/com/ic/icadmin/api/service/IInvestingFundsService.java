package com.ic.icadmin.api.service;

import com.ic.icadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.ic.icadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.ic.icadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.ic.icadmin.dto.CommonResponse;

import java.util.List;

public interface IInvestingFundsService {

    CommonResponse<List<ApiInvestingFundsResponse>> queryInvestmentProject(Long loginUserId, OtherFundsQueryRequest request);

    CommonResponse<List<ApiOtherFundsResponse>> queryOtherFunds(OtherFundsQueryRequest request, Long loginUserId);
}
