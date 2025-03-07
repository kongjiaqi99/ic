package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemCreateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemUpdateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemsQueryRequest;
import com.ic.icadmin.dto.response.loanItems.ListLoansExportDTO;
import com.ic.icadmin.dto.response.loanItems.LoanItemDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemEditDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemsResponse;
import com.ic.icadmin.service.ILoanItemService;
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

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-05 19:49
 **/
@RestController
@RequestMapping(path = "beaver-admin/loan-items")
@Api(tags = "Loan-items")
public class LoanItemsController {

    @Autowired
    private ILoanItemService loanItemService;

    @PreAuthorize("hasAuthority('loan-items')")
    @PostMapping("/queryLoanItems")
    @ApiOperation(value = "queryLoanItems", notes = "query Loan Items")
    CommonResponse<PageInfo<LoanItemsResponse>> queryLoanItems(@RequestBody LoanItemsQueryRequest request,
                                                               int pageNum,
                                                               int pageSize){
        return loanItemService.queryLoanItems(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('loan-items')")
    @PostMapping("/queryLoanItemById")
    @ApiOperation(value = "queryLoanItemById", notes = "query Loan Item By Id")
    CommonResponse<LoanItemDetailResponse> queryLoanItemById(@RequestBody QueryByIdRequest request){
        return loanItemService.queryLoanItemById(request);
    }

    @PreAuthorize("hasAuthority('loan-items-edit')")
    @PostMapping("/createLoanItem")
    @ApiOperation(value = "createLoanItem", notes = "create Loan Item")
    CommonResponse<Long> createLoanItem(@RequestBody LoanItemCreateRequest request){
        return loanItemService.createLoanItem(request);
    }


    @PreAuthorize("hasAuthority('loan-items-edit')")
    @PostMapping("/queryLoanItemByIdWhenEdit")
    @ApiOperation(value = "queryLoanItemByIdWhenEdit", notes = "query Loan Item By Id When edit")
    CommonResponse<LoanItemEditDetailResponse> queryLoanItemByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return loanItemService.queryLoanItemByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('loan-items-edit')")
    @PostMapping("/updateLoanItem")
    @ApiOperation(value = "updateLoanItem", notes = "update Loan Item")
    CommonResponse<Long> updateLoanItem(@RequestBody LoanItemUpdateRequest request){
        return loanItemService.updateLoanItem(request);
    }

    @PreAuthorize("hasAuthority('loan-items-edit')")
    @PostMapping("/delLoanItem")
    @ApiOperation(value = "delLoanItem", notes = "Delete Loan Item By Id")
    CommonResponse<Long> delLoanItem(@RequestBody QueryByIdRequest request){
        return loanItemService.delLoanItem(request);
    }

    @PreAuthorize("hasAuthority('loan-items')")
    @GetMapping("/exportLoansCsv")
    @ApiModelProperty(value = "exportLoansCsv", notes = "export Loans Csv")
    void exportLoansCsv(@RequestParam(required = false, value = "addressFilter") Integer addressFilter,
                        @RequestParam(required = false, value = "address") String address,
                        @RequestParam(required = false, value = "projectDateStart") LocalDate projectDateStart,
                        @RequestParam(required = false, value = "projectDateEnd") LocalDate projectDateEnd,
                        @RequestParam(required = false, value = "loanStatusFilter") Integer loanStatusFilter,
                        @RequestParam(required = false, value = "loanStatus") Integer loanStatus,
                        @RequestParam(required = false, value = "descriptionFilter") Integer descriptionFilter,
                        @RequestParam(required = false, value = "description") String description,
                        @RequestParam(required = false, value = "valueFilter") Integer valueFilter,
                        @RequestParam(required = false, value = "value") String value,
                        @RequestParam(required = false, value = "createAtStart") LocalDate createAtStart,
                        @RequestParam(required = false, value = "createAtEnd") LocalDate createAtEnd,
                        @RequestParam(required = false, value = "updateAtStart") LocalDate updateAtStart,
                        @RequestParam(required = false, value = "updateAtEnd") LocalDate updateAtEnd,
                        HttpServletResponse response) throws IOException {
        LoanItemsQueryRequest request = new LoanItemsQueryRequest(addressFilter,
                                                                  address,
                                                                  projectDateStart,
                                                                  projectDateEnd,
                                                                  loanStatusFilter,
                                                                  loanStatus,
                                                                  descriptionFilter,
                                                                  description,
                                                                  valueFilter,
                                                                  value,
                                                                  createAtStart,
                                                                  createAtEnd,
                                                                  updateAtStart,
                                                                  updateAtEnd);
        loanItemService.exportLoansCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportLoansXml", notes = "export Loans Xml")
    ListLoansExportDTO exportLoansXml(@RequestParam(required = false, value = "addressFilter") Integer addressFilter,
                                      @RequestParam(required = false, value = "address") String address,
                                      @RequestParam(required = false, value = "projectDateStart") LocalDate projectDateStart,
                                      @RequestParam(required = false, value = "projectDateEnd") LocalDate projectDateEnd,
                                      @RequestParam(required = false, value = "loanStatusFilter") Integer loanStatusFilter,
                                      @RequestParam(required = false, value = "loanStatus") Integer loanStatus,
                                      @RequestParam(required = false, value = "descriptionFilter") Integer descriptionFilter,
                                      @RequestParam(required = false, value = "description") String description,
                                      @RequestParam(required = false, value = "valueFilter") Integer valueFilter,
                                      @RequestParam(required = false, value = "value") String value,
                                      @RequestParam(required = false, value = "createAtStart") LocalDate createAtStart,
                                      @RequestParam(required = false, value = "createAtEnd") LocalDate createAtEnd,
                                      @RequestParam(required = false, value = "updateAtStart") LocalDate updateAtStart,
                                      @RequestParam(required = false, value = "updateAtEnd") LocalDate updateAtEnd){
        LoanItemsQueryRequest request = new LoanItemsQueryRequest(addressFilter,
                                                                  address,
                                                                  projectDateStart,
                                                                  projectDateEnd,
                                                                  loanStatusFilter,
                                                                  loanStatus,
                                                                  descriptionFilter,
                                                                  description,
                                                                  valueFilter,
                                                                  value,
                                                                  createAtStart,
                                                                  createAtEnd,
                                                                  updateAtStart,
                                                                  updateAtEnd);
        return new ListLoansExportDTO(loanItemService.exportLoansXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportLoansJson", notes = "export Loans Json")
    ListLoansExportDTO exportLoansJson(@RequestParam(required = false, value = "addressFilter") Integer addressFilter,
                                       @RequestParam(required = false, value = "address") String address,
                                       @RequestParam(required = false, value = "projectDateStart") LocalDate projectDateStart,
                                       @RequestParam(required = false, value = "projectDateEnd") LocalDate projectDateEnd,
                                       @RequestParam(required = false, value = "loanStatusFilter") Integer loanStatusFilter,
                                       @RequestParam(required = false, value = "loanStatus") Integer loanStatus,
                                       @RequestParam(required = false, value = "descriptionFilter") Integer descriptionFilter,
                                       @RequestParam(required = false, value = "description") String description,
                                       @RequestParam(required = false, value = "valueFilter") Integer valueFilter,
                                       @RequestParam(required = false, value = "value") String value,
                                       @RequestParam(required = false, value = "createAtStart") LocalDate createAtStart,
                                       @RequestParam(required = false, value = "createAtEnd") LocalDate createAtEnd,
                                       @RequestParam(required = false, value = "updateAtStart") LocalDate updateAtStart,
                                       @RequestParam(required = false, value = "updateAtEnd") LocalDate updateAtEnd){
        LoanItemsQueryRequest request = new LoanItemsQueryRequest(addressFilter,
                                                                  address,
                                                                  projectDateStart,
                                                                  projectDateEnd,
                                                                  loanStatusFilter,
                                                                  loanStatus,
                                                                  descriptionFilter,
                                                                  description,
                                                                  valueFilter,
                                                                  value,
                                                                  createAtStart,
                                                                  createAtEnd,
                                                                  updateAtStart,
                                                                  updateAtEnd);
        return new ListLoansExportDTO(loanItemService.exportLoansXml(request));
    }
}
