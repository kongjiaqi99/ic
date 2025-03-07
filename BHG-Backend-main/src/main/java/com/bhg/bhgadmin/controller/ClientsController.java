package com.bhg.bhgadmin.controller;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.client.*;
import com.bhg.bhgadmin.dto.response.client.ClientDetailResponse;
import com.bhg.bhgadmin.dto.response.client.ClientEditDetailResponse;
import com.bhg.bhgadmin.dto.response.client.ClientsResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityEditResponse;
import com.bhg.bhgadmin.dto.response.client.InvestmentEntityResponse;
import com.bhg.bhgadmin.dto.response.client.ListClientsExportDTO;
import com.bhg.bhgadmin.dto.response.client.UpperClientsResponse;
import com.bhg.bhgadmin.service.IClientService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/clients")
@Api(tags = "Clients")
public class ClientsController extends BaseController {

    @Autowired
    private IClientService clientService;

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryClients")
    @ApiOperation(value = "queryClients", notes = "queryClients")
    CommonResponse<PageInfo<ClientsResponse>> queryClients(@RequestBody ClientsQueryRequest request, int pageNum, int pageSize){
        return clientService.queryClients(request, pageNum, pageSize);
    }


    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryEntity")
    @ApiOperation(value = "queryEntity", notes = "queryEntity")
    CommonResponse<List<InvestmentEntityResponse>> queryEntity(@RequestBody EntityQueryRequest request){
        return clientService.queryEntity(request);
    }

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryClientDetailById")
    @ApiOperation(value = "queryClientDetailById", notes = "query Client Detail By Id")
    CommonResponse<ClientDetailResponse> queryClientDetailById(@RequestBody ClientAndEntityDetailQueryRequest request){
        return clientService.queryClientDetailById(request);
    }

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryInvestmentEntityById")
    @ApiModelProperty(value = "queryInvestmentEntityById", notes = "query Investment Entity By Id")
    CommonResponse<List<InvestmentEntityResponse>> queryInvestmentEntityById(@RequestBody ClientAndEntityDetailQueryRequest request){
        return clientService.queryInvestmentEntityById(request);
    }

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryInvestmentEntityKycById")
    @ApiModelProperty(value = "queryInvestmentEntityKycById", notes = "query Investment Entity By Id")
    CommonResponse<List<InvestmentEntityResponse>> queryInvestmentEntityKycById(@RequestBody ClientAndEntityDetailQueryRequest request){
        return clientService.queryInvestmentEntityById(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/createClient")
    @ApiModelProperty(value = "createClient", notes = "create Client")
    CommonResponse<Long> createClient(@RequestBody @Validated ClientCreateRequest request){
        return clientService.createClient(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/createEntity")
    @ApiModelProperty(value = "createEntity", notes = "create Entity")
    CommonResponse<Long> createEntity(@Validated InvestmentCreateRequest request
            , @RequestParam(value = "applicationFormSignedFile", required = false) MultipartFile applicationFormSigned
            , @RequestParam(value = "applicationFormSignedFileTwo", required = false) MultipartFile applicationFormSignedTwo
            , @RequestParam(value = "applicationFormSignedFileThree", required = false) MultipartFile applicationFormSignedThree
            , @RequestParam(value = "applicationFormSignedFileFour", required = false) MultipartFile applicationFormSignedFour
    ){
        return clientService.createEntity(request, applicationFormSigned
                ,applicationFormSignedTwo
                ,applicationFormSignedThree
                ,applicationFormSignedFour);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/queryClientDetailByIdWhenEdit")
    @ApiOperation(value = "queryClientDetailByIdWhenEdit", notes = "query Client Detail By Id When Edit")
    CommonResponse<ClientEditDetailResponse> queryClientDetailByIdWhenEdit(@RequestBody ClientAndEntityDetailQueryRequest request){
        return clientService.queryClientDetailByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/queryInvestmentEntityByIdWhenEdit")
    @ApiOperation(value = "queryInvestmentEntityByIdWhenEdit", notes = "query Investment Entity By Id When Edit")
    CommonResponse<List<InvestmentEntityEditResponse>> queryInvestmentEntityByIdWhenEdit(@RequestBody ClientAndEntityDetailQueryRequest request){
        return clientService.queryInvestmentEntityByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/editClient")
    @ApiModelProperty(value = "editClient", notes = "edit Client")
    CommonResponse<Long> editClient(@RequestBody @Validated ClientEditRequest request){
        return clientService.editClient(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/editEntity")
    @ApiModelProperty(value = "editEntity", notes = "edit Entity")
    CommonResponse<Long> editEntity(@Validated InvestmentCreateRequest request
            , @RequestParam(value = "applicationFormSignedFile", required = false) MultipartFile applicationFormSigned
            , @RequestParam(value = "applicationFormSignedFileTwo", required = false) MultipartFile applicationFormSignedTwo
            , @RequestParam(value = "applicationFormSignedFileThree", required = false) MultipartFile applicationFormSignedThree
            , @RequestParam(value = "applicationFormSignedFileFour", required = false) MultipartFile applicationFormSignedFour){
        return clientService.editEntity(request, applicationFormSigned, applicationFormSignedTwo,
                applicationFormSignedThree,
                applicationFormSignedFour);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/approvedClientKyc")
    @ApiModelProperty(value = "approvedClientKyc", notes = "approvedClientKyc")
    CommonResponse<Long> approvedClientKyc(@RequestBody ClientEditRequest request){
        return clientService.approvedClientKyc(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/refuseClientKyc")
    @ApiModelProperty(value = "refuseClientKyc", notes = "refuseClientKyc")
    CommonResponse<Long> refuseClientKyc(@RequestBody ClientEditRequest request){
        return clientService.refuseClientKyc(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/delClient")
    @ApiModelProperty(value = "delClient", notes = "delete Client")
    CommonResponse<String> delClient(@RequestBody ClientDelRequest request){
        return clientService.delClient(request);
    }

    @PreAuthorize("hasAuthority('clinets-edit')")
    @PostMapping("/resetClientPassword")
    @ApiModelProperty(value = "resetClientPassword", notes = "reset Client Password")
    CommonResponse<String> resetClientPassword(@RequestBody ClientDelRequest request){
        return clientService.resetClientPwd(request);
    }

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryUpperClients")
    @ApiModelProperty(value = "queryUpperClients", notes = "query Upper Clients")
    CommonResponse<List<UpperClientsResponse>> queryUpperClients(){
        return clientService.queryUpperClients();
    }

    @PreAuthorize("hasAuthority('clients')")
    @GetMapping("/exportClientsCsv")
    @ApiModelProperty(value = "exportClientsCsv", notes = "export Clients Csv")
    void exportClientsCsv(@RequestParam(required = false, value = "beaverId") String beaverId,
                          @RequestParam(required = false, value = "clientType") Integer clientType,
                          @RequestParam(required = false, value = "email") String email,
                          @RequestParam(required = false, value = "mobile") String mobile,
                          @RequestParam(required = false, value = "name") String name,
                          HttpServletResponse response) throws IOException {
        ClientsQueryRequest request = new ClientsQueryRequest();
        request.setBeaverId(beaverId);
        request.setClientType(clientType);
        request.setEmail(email);
        request.setMobile(mobile);
        request.setName(name);
        clientService.exportClientsCsv(request, response);
    }

    @PreAuthorize("hasAuthority('clients')")
    @PostMapping("/queryDownwardClients")
    @ApiOperation(value = "queryDownwardClients", notes = "queryDownwardClients")
    CommonResponse<List<ClientsResponse>> queryDownwardClients(@RequestBody ClientsDownwardQueryRequest request){
        return clientService.queryDownwardClients(request);
    };

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportClientsXml", notes = "export Clients Xml")
    ListClientsExportDTO exportClientsXml(@RequestParam(required = false, value = "beaverId") String beaverId,
                                          @RequestParam(required = false, value = "clientType") Integer clientType,
                                          @RequestParam(required = false, value = "email") String email,
                                          @RequestParam(required = false, value = "mobile") String mobile,
                                          @RequestParam(required = false, value = "name") String name){
        ClientsQueryRequest request = new ClientsQueryRequest();
        request.setBeaverId(beaverId);
        request.setClientType(clientType);
        request.setEmail(email);
        request.setMobile(mobile);
        request.setName(name);
        return new ListClientsExportDTO(clientService.exportClientsXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportClientsJson", notes = "export Clients Json")
    ListClientsExportDTO exportClientsJson(@RequestParam(required = false, value = "beaverId") String beaverId,
                                          @RequestParam(required = false, value = "clientType") Integer clientType,
                                          @RequestParam(required = false, value = "email") String email,
                                          @RequestParam(required = false, value = "mobile") String mobile,
                                          @RequestParam(required = false, value = "name") String name){
        ClientsQueryRequest request = new ClientsQueryRequest();
        request.setBeaverId(beaverId);
        request.setClientType(clientType);
        request.setEmail(email);
        request.setMobile(mobile);
        request.setName(name);
        return new ListClientsExportDTO(clientService.exportClientsXml(request));
    }
}
