package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.ReInvestmentRequest;
import com.ic.icadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.ic.icadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.ic.icadmin.api.dto.response.news.ApiNewsResponse;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.response.DictionaryResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@RequestMapping(path = "api/v1/info")
@Api(tags = "API-infos-noToken")
public interface IInfosClient {

    @GetMapping("/new")
    @ApiOperation(value = "Home-New", notes = "查询新闻列表（newsType：新闻类型；language：新闻语言；limitNum：查询数量）")
    CommonResponse<List<ApiNewsResponse>> queryNews(@ApiParam(required = true, value = "0:beaver_news, 1:last_insights, 2:global_weekly_wrap") @RequestParam(required = true) Integer newsType,
                                                    @ApiParam(required = true, value = "0:cn, 1:en")@RequestParam(required = true) Integer language,
                                                    @ApiParam(required = false, value = "limitNum")@RequestParam(required = false)Integer limitNum);

    @GetMapping("/news-detail")
    @ApiModelProperty(value = "Home-News-Detail", notes = "根据Id查询新闻详情")
    CommonResponse<ApiNewsDetailResponse> queryNewsDetail(@ApiParam(required = true, value = "新闻Id")@RequestParam(required = true) Long id);

    @PostMapping("/submit-enquiry")
    @ApiOperation(value = "submitEnquiry", notes = "提交咨询申请")
    CommonResponse<String> submitEnquiry(
//                                         @RequestParam(value = "intentionFile", required = false) MultipartFile intentionFile,
//                                         @RequestParam(value = "valuationFile", required = false) MultipartFile valuationFile,
//                                         @RequestParam(value = "borrowFile", required = false) MultipartFile borrowFile,
//                                         @RequestParam(value = "asicFile", required = false) MultipartFile asicFile,
//                                         @RequestParam(value = "idFile", required = false) MultipartFile idFile,
//                                         @RequestParam(value = "houseFile", required = false) MultipartFile houseFile,
//                                         @RequestParam(value = "investFile", required = false) MultipartFile investFile,
//                                         @RequestParam(value = "carFile", required = false) MultipartFile carFile,
//                                         @RequestParam(value = "loanFile", required = false) MultipartFile loanFile,
//                                         @RequestParam(value = "leaseFile", required = false) MultipartFile leaseFile,
//                                         @RequestParam(value = "cardFile", required = false) MultipartFile cardFile,
                                         @RequestBody ClientSubmitEnquiryRequest request);

    @GetMapping("/dictionary")
    @ApiModelProperty(value = "dictionary", notes = "字典")
    CommonResponse<List<DictionaryResponse>> queryDictionary(@ApiParam(required = true, value = "字典类型") @RequestParam(required = true) String dictType);

    @PostMapping("/upload")
    @ApiOperation(value = "upload", notes = "upload")
    CommonResponse<String> upload(@RequestParam("file") MultipartFile files, HttpServletRequest httpServletRequest) throws IOException;
}
