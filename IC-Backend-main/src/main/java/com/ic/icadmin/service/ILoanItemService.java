package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemCreateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemUpdateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemsQueryRequest;
import com.ic.icadmin.dto.response.loanItems.LoanItemDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemEditDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemsExportDTO;
import com.ic.icadmin.dto.response.loanItems.LoanItemsResponse;
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
