package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IInfosClient;
import com.bhg.bhgadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.bhg.bhgadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.bhg.bhgadmin.api.dto.response.news.ApiNewsResponse;
import com.bhg.bhgadmin.api.service.IApiInfosService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.DictionaryQueryRequest;
import com.bhg.bhgadmin.dto.response.DictionaryResponse;
import com.bhg.bhgadmin.service.IDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@RestController
public class InfosClientController implements IInfosClient {

    @Autowired
    private IApiInfosService infosService;
    @Resource
    private IDictionaryService dictionaryService;

    @Override
    public CommonResponse<List<ApiNewsResponse>> queryNews(Integer newsType, Integer language, Integer limitNum) {
        return infosService.queryNews(newsType, language, limitNum);
    }

    @Override
    public CommonResponse<ApiNewsDetailResponse> queryNewsDetail(Long id) {
        return infosService.queryNewsDetail(id);
    }

    @Override
    public CommonResponse<String> submitEnquiry(/*MultipartFile intentionFile, MultipartFile valuationFile, MultipartFile borrowFile, MultipartFile asicFile, MultipartFile idFile, MultipartFile houseFile, MultipartFile investFile, MultipartFile carFile, MultipartFile loanFile, MultipartFile leaseFile, MultipartFile cardFile,*/ ClientSubmitEnquiryRequest request) {
//        return infosService.submitEnquiry(request, intentionFile, valuationFile, borrowFile, asicFile, idFile, houseFile, investFile, carFile, loanFile, leaseFile, cardFile);
        return infosService.submitEnquiry(request, null, null, null, null, null, null, null, null, null, null, null);
    }

    @Override
    public CommonResponse<List<DictionaryResponse>> queryDictionary(String dictType) {
        DictionaryQueryRequest dictionaryQueryRequest = new DictionaryQueryRequest();
        dictionaryQueryRequest.setType(dictType);
        return CommonResponse.success(dictionaryService.queryDictionaryByType(dictionaryQueryRequest));
    }

    @Override
    public CommonResponse<String> upload(MultipartFile files, HttpServletRequest httpServletRequest) throws IOException {
        return infosService.upload(files, httpServletRequest);
    }

}
