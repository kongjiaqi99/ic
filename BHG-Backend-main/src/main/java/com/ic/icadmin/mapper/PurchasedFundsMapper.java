package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.request.audit.AuditQueryRequest;
import com.ic.icadmin.dto.request.investment.InvestmentRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.ic.icadmin.dto.response.client.InvestmentEntityResponse;
import com.ic.icadmin.dto.response.investment.InvestmentResponse;
import com.ic.icadmin.entity.PurchasedFundsEntity;
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