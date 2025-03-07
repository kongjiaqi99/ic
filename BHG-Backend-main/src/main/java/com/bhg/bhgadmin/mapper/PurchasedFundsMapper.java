package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.request.investment.InvestmentRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityResponse;
import com.bhg.bhgadmin.dto.response.investment.InvestmentResponse;
import com.bhg.bhgadmin.entity.PurchasedFundsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PurchasedFundsMapper extends BaseMapper<PurchasedFundsEntity> {

    List<BizPurchasedFundsDTO> queryPurchasedFunds(@Param("request") PurchasedFundsQueryRequest request);

    BizPurchasedFundsDTO queryPurchasedFundById(@Param("id") Long id);

    List<BizPurchasedFundsDTO> queryPurchasedFundsForFinancings(
        @Param("clientIds") List<Long> clientIds, @Param("fundId") Long fundId, @Param("entityIds") List<Long> entityIds);

    List<BizPurchasedFundsDTO> queryPurchasedFundsForClientAPI(@Param("clientId") Long clientId);

    List<InvestmentResponse> selectInvestmentList(InvestmentRequest request);

    Integer selectInvestCount();

    List<Long> getPopularFundId();

    List<InvestmentEntityResponse> getInvestmentCount(@Param("entityIds") List<Long> entityIdList);
}