package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.account.ClientInfoEditRequest;
import com.ic.icadmin.api.dto.request.account.KycDocumentTypesRequest;
import com.ic.icadmin.api.dto.request.account.KycVerifyRequest;
import com.ic.icadmin.api.dto.response.account.ApiFinancingProjectsResponse;
import com.ic.icadmin.api.dto.response.account.ApiInvestmentProjectsResponse;
import com.ic.icadmin.api.dto.response.account.ApiPersonalInfoResponse;
import com.ic.icadmin.dto.CommonResponse;
import com.trulioo.normalizedapi.ApiException;
import com.trulioo.normalizedapi.model.VerifyResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@RequestMapping(path = "api/v1/account")
@Api(tags = "API-infos-account")
public interface IAccountClient {

    @PostMapping("/personal-info")
    @ApiOperation(value = "PersonalInfo", notes = "查询PersonalInfomation")
    CommonResponse<ApiPersonalInfoResponse> queryPersonalInfo();

//    @PostMapping("/investment-project")
//    @ApiOperation(value = "InvestmentProject", notes = "查询InvestmentProject")
//    CommonResponse<List<ApiInvestmentProjectsResponse>> queryInvestmentProject();

//    @PostMapping("/financing-project")
//    @ApiOperation(value = "FinancingProject", notes = "查询FinancingProject")
//    CommonResponse<List<ApiFinancingProjectsResponse>> queryFinancingProject();
//
//    @PostMapping("/edit")
//    @ApiOperation(value = "Edit client info", notes = "编辑个人信息")
//    CommonResponse<String> editClientInfo(@RequestBody @Validated ClientInfoEditRequest request);

    @PostMapping("/kyc-verify")
    @ApiOperation(value = "kyc verify", notes = "kyc身份校验")
    CommonResponse<Long> kycVerify(@Validated @RequestParam(value = "docOneFront", required = true) MultipartFile docOneFront,
                                     @Validated @RequestParam(value = "docOneBack", required = false) MultipartFile docOneBack,
                                     @Validated @RequestParam(value = "livePhoto", required = true) MultipartFile livePhoto,
                                     KycVerifyRequest request) throws IOException, ApiException;

    @PostMapping("/kyc-callBack")
    @ApiOperation(value = "kyc verify callback", notes = "kyc身份校验回调")
    CommonResponse<Long> kycVerifyCallBack(@RequestBody VerifyResult verifyResult);

    @PostMapping("/countryCode")
    @ApiOperation(value = "Query Country codes", notes = "查询国家代码")
    CommonResponse<List<String>> queryCountryCode();

    @PostMapping("/documentType")
    @ApiOperation(value = "Query Document Types", notes = "查询国家文件类型")
    CommonResponse<Map<String, List<String>>> queryDocumentTypes(@RequestBody KycDocumentTypesRequest request);

}
