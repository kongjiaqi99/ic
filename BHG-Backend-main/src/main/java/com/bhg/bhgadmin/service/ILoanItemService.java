package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.loanItems.LoanItemCreateRequest;
import com.bhg.bhgadmin.dto.request.loanItems.LoanItemUpdateRequest;
import com.bhg.bhgadmin.dto.request.loanItems.LoanItemsQueryRequest;
import com.bhg.bhgadmin.dto.response.loanItems.LoanItemDetailResponse;
import com.bhg.bhgadmin.dto.response.loanItems.LoanItemEditDetailResponse;
import com.bhg.bhgadmin.dto.response.loanItems.LoanItemsExportDTO;
import com.bhg.bhgadmin.dto.response.loanItems.LoanItemsResponse;
import com.github.pagehelper.PageInfo;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface ILoanItemService {

    CommonResponse<PageInfo<LoanItemsResponse>> queryLoanItems(LoanItemsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<LoanItemDetailResponse> queryLoanItemById(QueryByIdRequest request);

    CommonResponse<Long> createLoanItem(LoanItemCreateRequest request);

    CommonResponse<LoanItemEditDetailResponse> queryLoanItemByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> updateLoanItem(LoanItemUpdateRequest request);

    CommonResponse<Long> delLoanItem(QueryByIdRequest request);

    void exportLoansCsv(LoanItemsQueryRequest request, HttpServletResponse response) throws IOException;

    List<LoanItemsExportDTO> exportLoansXml(LoanItemsQueryRequest request);
}
