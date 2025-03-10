package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizFinancingSubClientTotalReturn;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.financings.FinancingCreateRequest;
import com.ic.icadmin.dto.request.financings.FinancingUpdateRequest;
import com.ic.icadmin.dto.request.financings.FinancingsQueryRequest;
import com.ic.icadmin.dto.response.financings.ClientsNameResponse;
import com.ic.icadmin.dto.response.financings.CurrentTotalReturnResponse;
import com.ic.icadmin.dto.response.financings.FinancingDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingEditDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingsExportDTO;
import com.ic.icadmin.dto.response.financings.FinancingsResponse;
import com.ic.icadmin.dto.response.financings.FundsNameResponse;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.FinanceReference;
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
