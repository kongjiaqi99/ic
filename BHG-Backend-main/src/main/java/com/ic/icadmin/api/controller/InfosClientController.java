package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IInfosClient;
import com.ic.icadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.ic.icadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.ic.icadmin.api.dto.response.news.ApiNewsResponse;
import com.ic.icadmin.api.service.IApiInfosService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.DictionaryQueryRequest;
import com.ic.icadmin.dto.response.DictionaryResponse;
import com.ic.icadmin.service.IDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * @program: ic-admin
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
