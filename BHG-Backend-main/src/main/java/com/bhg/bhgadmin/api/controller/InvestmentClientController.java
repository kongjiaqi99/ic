package com.bhg.bhgadmin.api.controller;

import cn.hutool.core.collection.CollUtil;
import com.bhg.bhgadmin.api.client.IInvestmentClients;
import com.bhg.bhgadmin.api.dto.request.ApplicationFormRequest;
import com.bhg.bhgadmin.api.dto.request.InvestmentPageRequest;
import com.bhg.bhgadmin.api.dto.request.PurchasedFundsPageRequest;
import com.bhg.bhgadmin.api.dto.request.ReInvestmentRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.client.ClientAndEntityDetailQueryRequest;
import com.bhg.bhgadmin.dto.request.client.EntityQueryRequest;
import com.bhg.bhgadmin.dto.request.client.InvestmentCreateRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityEditResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityResponse;
import com.bhg.bhgadmin.dto.response.investment.InvestmentRecord;
import com.bhg.bhgadmin.dto.response.investment.InvestmentResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsDetailResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsResponse;
import com.bhg.bhgadmin.mapper.PurchasedFundsMapper;
import com.bhg.bhgadmin.service.IClientService;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.share.enums.FundCategoryEnum;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Maps;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class InvestmentClientController implements IInvestmentClients {

    @Resource
    IPurchasedFundsService purchasedFundsService;

    @Resource
    IClientService clientService;

    @Resource
    PurchasedFundsMapper purchasedFundsMapper;

    @Override
    public CommonResponse<List<InvestmentEntityResponse>> entityList(EntityQueryRequest request) {
        if (request == null) {
            request = new EntityQueryRequest();
        }
        Long loginUserId = LoginUserUtil.getLoginUserId();
        if (loginUserId == null) {
            return CommonResponse.success();
        }
        request.setClientId(loginUserId);
        CommonResponse<List<InvestmentEntityResponse>> listResponse = clientService.queryEntity(request);
        Map<Long, List<BizPurchasedFundsDTO>> entityPfMap;
        if (request.getClientId() != null) {
            PurchasedFundsQueryRequest pfRequest = new PurchasedFundsQueryRequest();
            pfRequest.setClientId(request.getClientId());
            List<BizPurchasedFundsDTO> pfList = purchasedFundsMapper.queryPurchasedFunds(pfRequest);
            entityPfMap = pfList.stream().collect(Collectors.groupingBy(BizPurchasedFundsDTO::getInvestmentEntityId));
        } else {
            entityPfMap = Maps.newHashMap();
        }
        Date date = new Date();
        if (CollUtil.isNotEmpty(listResponse.getData())) {
            List<Long> entityIdList = listResponse.getData().stream().map(InvestmentEntityResponse::getId).collect(Collectors.toList());
            List<InvestmentEntityResponse> countList = purchasedFundsService.getInvestmentCount(entityIdList);
            Map<Long, Integer> countMap = countList.stream().collect(Collectors.toMap(InvestmentEntityResponse::getId, InvestmentEntityResponse::getInvestmentCount));
            listResponse.getData().forEach(i -> {
                i.setInvestmentCount(countMap.get(i.getId()));
                List<BizPurchasedFundsDTO> list = entityPfMap.get(i.getId());
                if (CollUtil.isNotEmpty(list)) {
                    for (BizPurchasedFundsDTO dto : list) {
                        Date startReturnDay = purchasedFundsService.getStartReturnDay(dto);
                        Date endDay = purchasedFundsService.getEndDay(dto, EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory()));
                        if (startReturnDay != null && !startReturnDay.after(date) && (endDay == null || !endDay.before(date))) {
                            i.setActive(Boolean.TRUE);
                            break;
                        }
                    }
                }
            });
        }
        return listResponse;
    }

    @Override
    public CommonResponse<InvestmentEntityEditResponse> queryEntityById(ClientAndEntityDetailQueryRequest request) {
        CommonResponse<List<InvestmentEntityEditResponse>> listCommonResponse = clientService.queryInvestmentEntityByIdWhenEdit(request);
        if (CollUtil.isNotEmpty(listCommonResponse.getData())) {
            return CommonResponse.success(listCommonResponse.getData().get(0));
        }
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<Long> updateEntity(InvestmentCreateRequest request) {
        return clientService.editEntity(request, null, null, null, null);
    }

    @Override
    public CommonResponse<PageInfo<InvestmentResponse>> page(InvestmentPageRequest request) {
        return purchasedFundsService.queryInvestmentPage(request, request.getPageNum(), request.getPageSize());
    }

    @Override
    public CommonResponse<List<InvestmentRecord>> record(PurchasedFundsQueryRequest request) {
        return purchasedFundsService.investmentRecord(request);
    }

    @Override
    public CommonResponse<PageInfo<PurchasedFundsResponse>> purchasedFundPage(PurchasedFundsPageRequest request) {
        return CommonResponse.success(purchasedFundsService.queryPurchasedFunds(request, request.getPageNum(), request.getPageSize()));
    }

    @Override
    public CommonResponse<PurchasedFundsDetailResponse> purchasedFundDetail(QueryByIdRequest request) {
        return purchasedFundsService.queryPurchasedFundById(request.getId());
    }

    @Override
    public CommonResponse<Long> reInvestment(ReInvestmentRequest request) {
        return purchasedFundsService.reInvestment(request);
    }

    @Override
    public CommonResponse<String> upload(ReInvestmentRequest request, MultipartFile files, HttpServletRequest httpServletRequest) {
        return purchasedFundsService.upload(request, files, httpServletRequest);
    }

    @Override
    public CommonResponse<Long> sendApplicationForm(MultipartFile iSign,
                                                    MultipartFile iSignTwo,
                                                    MultipartFile iSignThree,
                                                    MultipartFile cSign,
                                                    MultipartFile cSignTwo,
                                                    MultipartFile tSign,
                                                    MultipartFile tSignTwo,
                                                    MultipartFile tSignThree,
                                                    MultipartFile tSignFour,
                                                    MultipartFile aSign,
                                                    MultipartFile aSignTwo,
                                                    ApplicationFormRequest request) {

        return purchasedFundsService.sendApplicationForm(iSign,
                iSignTwo,
                iSignThree,
                cSign,
                cSignTwo,
                tSign,
                tSignTwo,
                tSignThree,
                tSignFour,
                aSign,
                aSignTwo,request);
    }
}
