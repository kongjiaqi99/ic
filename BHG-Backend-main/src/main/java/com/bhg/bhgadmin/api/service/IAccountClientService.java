package com.bhg.bhgadmin.api.service;

import com.bhg.bhgadmin.api.dto.request.account.ClientInfoEditRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycDocumentTypesRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycVerifyRequest;
import com.bhg.bhgadmin.api.dto.response.account.ApiFinancingProjectsResponse;
import com.bhg.bhgadmin.api.dto.response.account.ApiInvestmentProjectsResponse;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.trulioo.normalizedapi.ApiException;
import com.trulioo.normalizedapi.model.VerifyResult;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface IAccountClientService {

    Integer getKycStatus(Long clientId);

    CommonResponse<List<ApiInvestmentProjectsResponse>> queryInvestmentProject(Long loginUserId);

    CommonResponse<List<ApiFinancingProjectsResponse>> queryFinancingProject(ClientsEntity loginUserId);

    CommonResponse<String> editClientInfo(ClientInfoEditRequest request, Long loginUserId);

    CommonResponse<Long> kycVerify(MultipartFile docOneFront, MultipartFile docOneBack, MultipartFile livePhoto,
                                   KycVerifyRequest request, ClientsEntity loginUser) throws IOException, ApiException;

    CommonResponse<Long> kycVerifyCallBack(VerifyResult verifyResult);

    CommonResponse<List<String>> queryCountryCode();

    CommonResponse<Map<String, List<String>>> queryDocumentTypes(KycDocumentTypesRequest request);

    ClientsEntity getClientById(Long id);
}
