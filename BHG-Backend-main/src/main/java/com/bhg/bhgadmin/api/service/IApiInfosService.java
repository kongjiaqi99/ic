package com.bhg.bhgadmin.api.service;

import com.bhg.bhgadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.bhg.bhgadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.bhg.bhgadmin.api.dto.response.news.ApiNewsResponse;
import com.bhg.bhgadmin.dto.CommonResponse;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public interface IApiInfosService {

    CommonResponse<List<ApiNewsResponse>> queryNews(Integer newsType, Integer language, Integer limitNum);

    CommonResponse<ApiNewsDetailResponse> queryNewsDetail(Long id);

    CommonResponse<String> submitEnquiry(ClientSubmitEnquiryRequest request, MultipartFile intentionFile, MultipartFile valuationFile, MultipartFile borrowFile, MultipartFile asicFile, MultipartFile idFile, MultipartFile houseFile, MultipartFile investFile, MultipartFile carFile, MultipartFile loanFile, MultipartFile leaseFile, MultipartFile cardFile);

    CommonResponse<String> upload(MultipartFile files, HttpServletRequest httpServletRequest) throws IOException;
}
