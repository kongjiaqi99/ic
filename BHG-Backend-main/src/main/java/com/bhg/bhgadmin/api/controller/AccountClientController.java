package com.bhg.bhgadmin.api.controller;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.crypto.digest.MD5;
import com.alibaba.fastjson.JSON;
import com.bhg.bhgadmin.api.client.IAccountClient;
import com.bhg.bhgadmin.api.dto.request.account.ClientInfoEditRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycDocumentTypesRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycVerifyRequest;
import com.bhg.bhgadmin.api.dto.response.account.ApiFinancingProjectsResponse;
import com.bhg.bhgadmin.api.dto.response.account.ApiInvestmentProjectsResponse;
import com.bhg.bhgadmin.api.dto.response.account.ApiPersonalInfoResponse;
import com.bhg.bhgadmin.api.service.IAccountClientService;
import com.bhg.bhgadmin.controller.BaseController;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.share.enums.KycStatusEnum;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.trulioo.normalizedapi.ApiException;
import com.trulioo.normalizedapi.model.VerifyResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 12:54
 **/
@Slf4j
@RestController
public class AccountClientController extends BaseController implements IAccountClient {

    @Autowired
    private IAccountClientService accountClientService;

    @Override
    public CommonResponse<ApiPersonalInfoResponse> queryPersonalInfo() {
        ClientsEntity loginClient = LoginUserUtil.getLoginClientNormal();
        ApiPersonalInfoResponse response = new ApiPersonalInfoResponse();
        if (loginClient != null) {
            loginClient = accountClientService.getClientById(loginClient.getId());
            response.setId(loginClient.getId());
            response.setBirthday(DateUtil.format(loginClient.getBirth(), DatePattern.NORM_DATE_PATTERN));
            response.setEmail(loginClient.getEmail());
            Integer kycStatus = accountClientService.getKycStatus(loginClient.getId());
            response.setKycStatus(ObjectUtil.isNotNull(kycStatus) && kycStatus < 4 && kycStatus > 0
                    ? EnumUtil.getByCode(KycStatusEnum.class, kycStatus).getCode()
                    : KycStatusEnum.NOT_VERIFIED.getCode());
            response.setName(loginClient.getName());
            response.setPhone(loginClient.getMobile());
            response.setEnablePin(CharSequenceUtil.isNotBlank(loginClient.getPin()));
            response.setPin(MD5.create().digestHex16(loginClient.getPin()));
            response.setBsb(loginClient.getBsb());
        } else {
            response.setEmail(LoginUserUtil.getLoginUserName());
        }
        return CommonResponse.success(response);
    }

//    @Override
//    public CommonResponse<List<ApiInvestmentProjectsResponse>> queryInvestmentProject() {
//        return accountClientService.queryInvestmentProject(getLoginUserId());
//    }
//
//    @Override
//    public CommonResponse<List<ApiFinancingProjectsResponse>> queryFinancingProject() {
//        return accountClientService.queryFinancingProject(getLoginClient());
//    }
//
//    @Override
//    public CommonResponse<String> editClientInfo(ClientInfoEditRequest request) {
//        return accountClientService.editClientInfo(request, getLoginUserId());
//    }

    @Override
    public CommonResponse<Long> kycVerify(MultipartFile docOneFront, MultipartFile docOneBack,
                                            MultipartFile livePhoto, KycVerifyRequest request) throws IOException, ApiException {
        return accountClientService.kycVerify(docOneFront, docOneBack, livePhoto, request, getLoginClient());
    }

    @Override
    public CommonResponse<Long> kycVerifyCallBack(VerifyResult verifyResult) {
        log.info("===CallBack:{}===", JSON.toJSONString(verifyResult));
        return accountClientService.kycVerifyCallBack(verifyResult);
    }

    @Override
    public CommonResponse<List<String>> queryCountryCode() {
        return accountClientService.queryCountryCode();
    }

    @Override
    public CommonResponse<Map<String, List<String>>> queryDocumentTypes(KycDocumentTypesRequest request) {
        return accountClientService.queryDocumentTypes(request);
    }
}
