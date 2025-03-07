package com.bhg.bhgadmin.api.client;

import com.bhg.bhgadmin.api.dto.request.fund.OtherFundsQueryRequest;
import com.bhg.bhgadmin.api.dto.response.investing.ApiInvestingFundsResponse;
import com.bhg.bhgadmin.api.dto.response.investing.ApiOtherFundsResponse;
import com.bhg.bhgadmin.dto.CommonResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/investing")
@Api(tags = "API-infos-Investing-Funds")
public interface IInvestingFundsClient {

    @PostMapping("/funds")
    @ApiOperation(value = "Investing Funds", notes = "查询Investing Funds")
    CommonResponse<List<ApiInvestingFundsResponse>> queryInvestmentProject(@RequestBody OtherFundsQueryRequest request);

    @PostMapping("/other-funds")
    @ApiOperation(value = "Other Funds", notes = "查询Other Funds")
    CommonResponse<List<ApiOtherFundsResponse>> queryOtherFunds(@RequestBody OtherFundsQueryRequest request);

}
