package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.funds.FundCreateRequest;
import com.bhg.bhgadmin.dto.request.funds.FundEditRequest;
import com.bhg.bhgadmin.dto.request.funds.FundsQueryRequest;
import com.bhg.bhgadmin.dto.response.funds.FundDetailResponse;
import com.bhg.bhgadmin.dto.response.funds.FundEditDetailResponse;
import com.bhg.bhgadmin.dto.response.funds.FundsExportDTO;
import com.bhg.bhgadmin.dto.response.funds.FundsResponse;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface IFundsService {

    CommonResponse<PageInfo<FundsResponse>> queryFunds(FundsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<FundDetailResponse> queryFundById(QueryByIdRequest request);

    Long createFund(MultipartFile imFilePath, MultipartFile subImFilePath, MultipartFile introduceFilePath,
                    MultipartFile eoiFilePath, MultipartFile reportFilePath, MultipartFile additionalInvestmentFile,
                    MultipartFile constitutionFile, MultipartFile applicationForm, MultipartFile applicationFormTwo,
                    MultipartFile applicationFormThree, MultipartFile applicationFormFour,
                    MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree, MultipartFile coverFour,
                    MultipartFile coverCn, MultipartFile coverCnTwo, MultipartFile coverCnThree, MultipartFile coverCnFour, FundCreateRequest request);

    CommonResponse<FundEditDetailResponse> queryFundByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> editFund(MultipartFile imFilePath, MultipartFile subImFilePath, MultipartFile introduceFilePath,
                                  MultipartFile eoiFilePath, MultipartFile reportFilePath, MultipartFile additionalInvestmentFile,
                                  MultipartFile constitutionFile, MultipartFile applicationForm, MultipartFile applicationFormTwo,
                                  MultipartFile applicationFormThree, MultipartFile applicationFormFour,
                                  MultipartFile cover, MultipartFile coverTwo, MultipartFile coverThree, MultipartFile coverFour,
                                  MultipartFile coverCn, MultipartFile coverCnTwo, MultipartFile coverCnThree, MultipartFile coverCnFour, FundEditRequest request);

    CommonResponse<Long> delFund(QueryByIdRequest request);

    void exportFundsCsv(FundsQueryRequest request, HttpServletResponse response) throws IOException;

    List<FundsExportDTO> exportFundsXml(FundsQueryRequest request);

    String getFundFileFullPath(String fileType, Long fundId, String fileName);

    CommonResponse<List<FundsResponse>> popular();
    
}
