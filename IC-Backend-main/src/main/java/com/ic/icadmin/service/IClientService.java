package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.client.*;
import com.ic.icadmin.dto.response.client.ClientDetailResponse;
import com.ic.icadmin.dto.response.client.ClientEditDetailResponse;
import com.ic.icadmin.dto.response.client.ClientsExportDTO;
import com.ic.icadmin.dto.response.client.ClientsResponse;
import com.ic.icadmin.dto.response.client.InvestmentEntityEditResponse;
import com.ic.icadmin.dto.response.client.InvestmentEntityResponse;
import com.ic.icadmin.dto.response.client.UpperClientsResponse;
import com.github.pagehelper.PageInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface IClientService {

    /**
     * queryClients
     * @param request
     * @param pageNum
     * @param pageSize
     * @return
     */
    CommonResponse<PageInfo<ClientsResponse>> queryClients(ClientsQueryRequest request, int pageNum, int pageSize);

    /**
     * queryClientDetailById
     * @param request
     * @return
     */
    CommonResponse<ClientDetailResponse> queryClientDetailById(ClientAndEntityDetailQueryRequest request);

    /**
     * queryInvestmentEntityById
     * @param request
     * @return
     */
    CommonResponse<List<InvestmentEntityResponse>> queryInvestmentEntityById(ClientAndEntityDetailQueryRequest request);

    CommonResponse<Long> createClient(ClientCreateRequest request);

    CommonResponse<Long> editClient(ClientEditRequest request);

    CommonResponse<String> delClient(ClientDelRequest request);

    CommonResponse<String> resetClientPwd(ClientDelRequest request);

    CommonResponse<ClientEditDetailResponse> queryClientDetailByIdWhenEdit(ClientAndEntityDetailQueryRequest request);

    CommonResponse<List<InvestmentEntityEditResponse>> queryInvestmentEntityByIdWhenEdit(ClientAndEntityDetailQueryRequest request);

    CommonResponse<List<UpperClientsResponse>> queryUpperClients();

    void exportClientsCsv(ClientsQueryRequest request, HttpServletResponse response) throws IOException;

    CommonResponse<List<ClientsResponse>> queryDownwardClients(ClientsDownwardQueryRequest request);

    List<ClientsExportDTO> exportClientsXml(ClientsQueryRequest request);

    Boolean checkEmailExist(Long id, String email);

    String getInvestmentFileFullPath(String fileType, Long investmentId, String fileName);

    CommonResponse<Long> createEntity(InvestmentCreateRequest request, MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour);

    CommonResponse<Long> editEntity(InvestmentCreateRequest request, MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour);

    CommonResponse<List<InvestmentEntityResponse>> queryEntity(EntityQueryRequest request);

    CommonResponse<Long> approvedClientKyc(ClientEditRequest request);

    CommonResponse<Long> refuseClientKyc(ClientEditRequest request);
}
