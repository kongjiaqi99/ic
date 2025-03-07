package com.bhg.bhgadmin.api.client;

import com.bhg.bhgadmin.api.dto.request.ApplicationFormRequest;
import com.bhg.bhgadmin.api.dto.request.InvestmentPageRequest;
import com.bhg.bhgadmin.api.dto.request.PurchasedFundsPageRequest;
import com.bhg.bhgadmin.api.dto.request.ReInvestmentRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.client.ClientAndEntityDetailQueryRequest;
import com.bhg.bhgadmin.dto.request.client.EntityQueryRequest;
import com.bhg.bhgadmin.dto.request.client.InvestmentCreateRequest;
import com.bhg.bhgadmin.dto.request.investment.InvestmentRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundCreateRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityEditResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityResponse;
import com.bhg.bhgadmin.dto.response.events.EventDetailResponse;
import com.bhg.bhgadmin.dto.response.investment.InvestmentRecord;
import com.bhg.bhgadmin.dto.response.investment.InvestmentResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsDetailResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RequestMapping(path = "api/v1/investment")
@Api(tags = "investment")
public interface IInvestmentClients {

    @PostMapping("/entity/list")
    @ApiOperation(value = "entity list", notes = "entity page")
    CommonResponse<List<InvestmentEntityResponse>> entityList(@RequestBody EntityQueryRequest request);

    @PostMapping("/entity/detail")
    @ApiOperation(value = "entity detail", notes = "entity detail")
    CommonResponse<InvestmentEntityEditResponse> queryEntityById(@RequestBody ClientAndEntityDetailQueryRequest request);

    @PostMapping("/entity/update")
    @ApiOperation(value = "entity update", notes = "entity update")
    CommonResponse<Long> updateEntity(@RequestBody InvestmentCreateRequest request);

    @PostMapping("/page")
    @ApiOperation(value = "investment page", notes = "page")
    CommonResponse<PageInfo<InvestmentResponse>> page(@RequestBody InvestmentPageRequest request);

    @PostMapping("/record")
    @ApiOperation(value = "investment record", notes = "page")
    CommonResponse<List<InvestmentRecord>> record(@RequestBody PurchasedFundsQueryRequest request);

    @PostMapping("/purchasedFund/page")
    @ApiOperation(value = "purchasedFundPage", notes = "purchasedFundPage")
    CommonResponse<PageInfo<PurchasedFundsResponse>> purchasedFundPage(@RequestBody PurchasedFundsPageRequest request);

    @PostMapping("/purchasedFund/detail")
    @ApiOperation(value = "purchasedFund detail", notes = "purchasedFund detail")
    CommonResponse<PurchasedFundsDetailResponse> purchasedFundDetail(@RequestBody QueryByIdRequest request);

    @PostMapping("/reInvestment")
    @ApiOperation(value = "reInvestment", notes = "reInvestment")
    CommonResponse<Long> reInvestment(@RequestBody ReInvestmentRequest request);

    @PostMapping("/upload")
    @ApiOperation(value = "upload", notes = "upload")
    CommonResponse<String> upload(ReInvestmentRequest request, @RequestParam("file") MultipartFile files, HttpServletRequest httpServletRequest);

    @PostMapping("/sendApplicationForm")
    @ApiOperation(value = "sendApplicationForm", notes = "sendApplicationForm")
    CommonResponse<Long> sendApplicationForm(
            @RequestParam(value = "iSign", required = false) MultipartFile iSign,
            @RequestParam(value = "iSignTwo", required = false) MultipartFile iSignTwo,
            @RequestParam(value = "iSignThree", required = false) MultipartFile iSignThree,
            @RequestParam(value = "cSign", required = false) MultipartFile cSign,
            @RequestParam(value = "cSignTwo", required = false) MultipartFile cSignTwo,
            @RequestParam(value = "tSign", required = false) MultipartFile tSign,
            @RequestParam(value = "tSignTwo", required = false) MultipartFile tSignTwo,
            @RequestParam(value = "tSignThree", required = false) MultipartFile tSignThree,
            @RequestParam(value = "tSignFour", required = false) MultipartFile tSignFour,
            @RequestParam(value = "aSign", required = false) MultipartFile aSign,
            @RequestParam(value = "aSignTwo", required = false) MultipartFile aSignTwo,
            ApplicationFormRequest request);

}


