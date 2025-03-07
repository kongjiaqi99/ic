package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizFinancingSubClientTotalReturn;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingCreateRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingUpdateRequest;
import com.bhg.bhgadmin.dto.request.financings.FinancingsQueryRequest;
import com.bhg.bhgadmin.dto.response.financings.ClientsNameResponse;
import com.bhg.bhgadmin.dto.response.financings.CurrentTotalReturnResponse;
import com.bhg.bhgadmin.dto.response.financings.FinancingDetailResponse;
import com.bhg.bhgadmin.dto.response.financings.FinancingEditDetailResponse;
import com.bhg.bhgadmin.dto.response.financings.FinancingsExportDTO;
import com.bhg.bhgadmin.dto.response.financings.FinancingsResponse;
import com.bhg.bhgadmin.dto.response.financings.FundsNameResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.entity.FinanceReference;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public interface IFinancingsService {


    List<ClientsNameResponse> getClientsNames();

    List<FundsNameResponse> getFundsNames();

    List<FundsNameResponse> getFundsNamesCN();

    CommonResponse<PageInfo<FinancingsResponse>> queryFinancings(FinancingsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<FinancingDetailResponse> queryFinancingById(QueryByIdRequest request);

    CommonResponse<Long> createFinancing(MultipartFile referralAgreement, FinancingCreateRequest request);

    CommonResponse<FinancingEditDetailResponse> queryFinancingByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> updateFinancing(MultipartFile referralAgreement, FinancingUpdateRequest request);

    CommonResponse<Long> delFinancing(QueryByIdRequest request);

    void exportFinancingsCsv(FinancingsQueryRequest request, HttpServletResponse response) throws IOException;

    List<FinancingsExportDTO> exportFinancingsXml(FinancingsQueryRequest request);

    CommonResponse<Long> subClientDelete(QueryByIdRequest request);

    List<CurrentTotalReturnResponse> getSubClientCurrentTotalReturnResponses(List<ClientsEntity> subClients,
                                                                             List<ClientsEntity> subSubClients,
                                                                             List<BizFinancingSubClientTotalReturn> subSubClientTotalReturns);

    List<BizFinancingSubClientTotalReturn> calculateFinancingSubClientTotalReturn(BigDecimal commissionRate,
                                                                                  BigDecimal bYearlyReturnRate, List<FinanceReference> referenceList, List<BizPurchasedFundsDTO> subClientPurchasedFunds, boolean clientTaxMap);

    void exportPdf(String date, Long id, HttpServletResponse response) throws Exception;

}
