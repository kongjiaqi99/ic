package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.financings.FinancingCreateRequest;
import com.ic.icadmin.dto.request.financings.FinancingUpdateRequest;
import com.ic.icadmin.dto.request.financings.FinancingsQueryRequest;
import com.ic.icadmin.dto.response.financings.ClientsNameResponse;
import com.ic.icadmin.dto.response.financings.FinancingDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingEditDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingsResponse;
import com.ic.icadmin.dto.response.financings.FundsNameResponse;
import com.ic.icadmin.dto.response.financings.ListFinancingsExportDTO;
import com.ic.icadmin.service.IFinancingsService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
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
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-02 22:44
 **/
@RestController
@RequestMapping(path = "beaver-admin/financings")
@Api(tags = "Financings")
public class FinancingsController {

    @Autowired
    private IFinancingsService financingsService;

    @PreAuthorize("hasAuthority('financings')")
    @PostMapping("/getClientsNames")
    @ApiOperation(value = "getClientsNames", notes = "query Clients' Names")
    CommonResponse<List<ClientsNameResponse>> getClientsNames(){
        return CommonResponse.success(financingsService.getClientsNames());
    }

    @PreAuthorize("hasAuthority('financings')")
    @PostMapping("/getFundsNames")
    @ApiOperation(value = "getFundsNames", notes = "query funds' Names")
    CommonResponse<List<FundsNameResponse>> getFundsNames(){
        return CommonResponse.success(financingsService.getFundsNames());
    }

    @PreAuthorize("hasAuthority('financings')")
    @PostMapping("/queryFinancings")
    @ApiOperation(value = "queryFinancings", notes = "query Financings")
    CommonResponse<PageInfo<FinancingsResponse>> queryFinancings(@RequestBody FinancingsQueryRequest request,
                                                                 int pageNum, int pageSize){
        return financingsService.queryFinancings(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('financings')")
    @PostMapping("/queryFinancingById")
    @ApiOperation(value = "queryFinancingById", notes = "query Financing By Id")
    CommonResponse<FinancingDetailResponse> queryFinancingById(@RequestBody QueryByIdRequest request){
        return financingsService.queryFinancingById(request);
    }

    @PreAuthorize("hasAuthority('financings-edit')")
    @PostMapping("/createFinancing")
    @ApiOperation(value = "createFinancing", notes = "create Financing")
    CommonResponse<Long> createFinancing(@RequestParam(value = "referralAgreement", required = false) MultipartFile referralAgreement,
                                         @RequestBody FinancingCreateRequest request){
        return financingsService.createFinancing(referralAgreement, request);
    }

    @PreAuthorize("hasAuthority('financings-edit')")
    @PostMapping("/queryFinancingByIdWhenEdit")
    @ApiOperation(value = "queryFinancingByIdWhenEdit", notes = "query Financing By Id When Edit")
    CommonResponse<FinancingEditDetailResponse> queryFinancingByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return financingsService.queryFinancingByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('financings-edit')")
    @PostMapping("/updateFinancing")
    @ApiOperation(value = "updateFinancing", notes = "update Financing")
    CommonResponse<Long> updateFinancing(@RequestParam(value = "referralAgreement", required = false) MultipartFile referralAgreement,
                                         @RequestBody FinancingUpdateRequest request){
        return financingsService.updateFinancing(referralAgreement, request);
    }

    @PreAuthorize("hasAuthority('financings-edit')")
    @PostMapping("/delFinancing")
    @ApiOperation(value = "delFinancing", notes = "delete Financing")
    CommonResponse<Long> delFinancing(@RequestBody QueryByIdRequest request){
        return financingsService.delFinancing(request);
    }

    @PreAuthorize("hasAuthority('funds')")
    @GetMapping("/exportFinancingsCsv")
    @ApiModelProperty(value = "exportFinancingsCsv", notes = "export Financings Csv")
    void exportFinancingsCsv(FinancingsQueryRequest request,
                             HttpServletResponse response) throws IOException {
        financingsService.exportFinancingsCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportFinancingsXml", notes = "export Financings Xml")
    ListFinancingsExportDTO exportFinancingsXml(FinancingsQueryRequest request){
        return new ListFinancingsExportDTO(financingsService.exportFinancingsXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportFinancingsJson", notes = "export Financings Json")
    ListFinancingsExportDTO exportFinancingsJson(FinancingsQueryRequest request){
        return new ListFinancingsExportDTO(financingsService.exportFinancingsXml(request));
    }

    @PreAuthorize("hasAuthority('financings')")
    @PostMapping("/subClientDelete")
    @ApiModelProperty(value = "subClientDelete", notes = "delete sub clients connection in detail page of Financing")
    CommonResponse<Long> subClientDelete(@RequestBody QueryByIdRequest request){
        return financingsService.subClientDelete(request);
    }

    @GetMapping(value = "/exportPdf", produces = MediaType.APPLICATION_XML_VALUE)
    @PostMapping("/exportPdf")
    void exportPdf(@RequestParam(required = false, value = "id") Long id,
                                                @RequestParam(required = false, value = "date") String date,
                                                HttpServletResponse response) throws Exception {
        financingsService.exportPdf(date, id, response);
    }

}
