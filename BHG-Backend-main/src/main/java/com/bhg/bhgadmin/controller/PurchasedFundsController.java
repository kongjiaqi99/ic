package com.bhg.bhgadmin.controller;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.text.CharSequenceUtil;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.QueryByIdRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundCreateRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundEditRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.financings.ClientsNameResponse;
import com.bhg.bhgadmin.dto.response.financings.FundsNameResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.ListPurchasedFundsExportDTO;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundEditDetailResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsDetailResponse;
import com.bhg.bhgadmin.dto.response.purchasedFunds.PurchasedFundsResponse;
import com.bhg.bhgadmin.service.IFinancingsService;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.share.enums.TemplateTypeEnum;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import com.github.pagehelper.PageInfo;
import com.mailjet.client.errors.MailjetException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-16 18:35
 **/
@RestController
@RequestMapping(path = "beaver-admin/purchased-funds")
@Api(tags = "purchased-funds")
public class PurchasedFundsController {

    @Autowired
    private IFinancingsService financingsService;

    @Autowired
    private IPurchasedFundsService purchasedFundsService;

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/getClientsNames")
    @ApiOperation(value = "getClientsNames", notes = "query Clients' Names")
    CommonResponse<List<ClientsNameResponse>> getClientsNames(){
        return CommonResponse.success(financingsService.getClientsNames());
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/getFundsNames")
    @ApiOperation(value = "getFundsNames", notes = "query funds' Names")
    CommonResponse<List<FundsNameResponse>> getFundsNames(){
        return CommonResponse.success(financingsService.getFundsNames());
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/getFundsNamesCN")
    @ApiOperation(value = "getFundsNamesCN", notes = "query funds' Names CN")
    CommonResponse<List<FundsNameResponse>> getFundsNamesCN(){
        return CommonResponse.success(financingsService.getFundsNamesCN());
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/queryPurchasedFunds")
    @ApiOperation(value = "queryPurchasedFunds", notes = "query purchased funds")
    CommonResponse<PageInfo<PurchasedFundsResponse>> queryPurchasedFunds(@RequestBody PurchasedFundsQueryRequest request,
                                                                               @RequestParam int pageNum,
                                                                               @RequestParam int pageSize){
        return CommonResponse.success(purchasedFundsService.queryPurchasedFunds(request, pageNum, pageSize));
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/queryPurchasedFundById")
    @ApiOperation(value = "queryPurchasedFundById", notes = "query purchased fund by Id")
    CommonResponse<PurchasedFundsDetailResponse> queryPurchasedFundById(@RequestBody QueryByIdRequest request){
        return purchasedFundsService.queryPurchasedFundById(request.getId());
    }

    @PreAuthorize("hasAuthority('purchased-funds-edit')")
    @PostMapping("/createPurchasedFund")
    @ApiOperation(value = "createPurchasedFund", notes = "create Purchased Fund")
    CommonResponse<Long> createPurchasedFund(
            @RequestParam(value = "applicationFormSignedFile", required = false)MultipartFile applicationFormSigned,
            @RequestParam(value = "applicationFormSignedFileTwo", required = false)MultipartFile applicationFormSignedTwo,
            @RequestParam(value = "applicationFormSignedFileThree", required = false)MultipartFile applicationFormSignedThree,
            @RequestParam(value = "applicationFormSignedFileFour", required = false)MultipartFile applicationFormSignedFour,
                                             PurchasedFundCreateRequest request){
        return purchasedFundsService.createPurchasedFund(
                applicationFormSigned,
                applicationFormSignedTwo,
                applicationFormSignedThree,
                applicationFormSignedFour,
                request);
    }

    @PreAuthorize("hasAuthority('purchased-funds-edit')")
    @PostMapping("/queryPurchasedFundByIdWhenEdit")
    @ApiOperation(value = "queryPurchasedFundByIdWhenEdit", notes = "query purchased fund by Id when edit")
    CommonResponse<PurchasedFundEditDetailResponse> queryPurchasedFundByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return purchasedFundsService.queryPurchasedFundByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('purchased-funds-edit')")
    @PostMapping("/editPurchasedFund")
    @ApiOperation(value = "editPurchasedFund", notes = "edit Purchased Fund")
    CommonResponse<Long> editPurchasedFund(
            @RequestParam(value = "applicationFormSignedFile", required = false)MultipartFile applicationFormSigned,
            @RequestParam(value = "applicationFormSignedFileTwo", required = false)MultipartFile applicationFormSignedTwo,
            @RequestParam(value = "applicationFormSignedFileThree", required = false)MultipartFile applicationFormSignedThree,
            @RequestParam(value = "applicationFormSignedFileFour", required = false)MultipartFile applicationFormSignedFour,
                                           PurchasedFundEditRequest request){
        return purchasedFundsService.editPurchasedFund(applicationFormSigned,applicationFormSignedTwo,
                applicationFormSignedThree,
                applicationFormSignedFour, request);
    }

    @PreAuthorize("hasAuthority('purchased-funds-edit')")
    @PostMapping("/delPurchasedFund")
    @ApiOperation(value = "delPurchasedFund", notes = "delete Purchased fund")
    CommonResponse<Long> delPurchasedFund(@RequestBody QueryByIdRequest request){
        return purchasedFundsService.delPurchasedFund(request);
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/sendUnitCertificate")
    @ApiOperation(value = "sendUnitCertificate", notes = "send unit certificate")
    CommonResponse sendUnitCertificate(@RequestBody QueryByIdRequest request) throws MailjetException {
        purchasedFundsService.sendUnitCertificate(request);
        return CommonResponse.success();
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/exportUnitCertificate")
    @ApiOperation(value = "exportUnitCertificate", notes = "export unit certificate")
    CommonResponse<String> exportUnitCertificate(@RequestBody QueryByIdRequest request) throws MailjetException {
        return CommonResponse.success(purchasedFundsService.exportUnitCertificate(request));
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @GetMapping("/exportCsv")
    @ApiOperation(value = "exportCsv", notes = "export Csv")
    void exportCsv(PurchasedFundsQueryRequest request,
                   HttpServletResponse response) throws IOException {
        purchasedFundsService.exportCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportXml", notes = "export Xml")
    ListPurchasedFundsExportDTO exportXml(PurchasedFundsQueryRequest request){
        return new ListPurchasedFundsExportDTO(purchasedFundsService.exportXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportJson", notes = "export Json")
    ListPurchasedFundsExportDTO exportJson(PurchasedFundsQueryRequest request){
        return new ListPurchasedFundsExportDTO(purchasedFundsService.exportXml(request));
    }

    @PreAuthorize("hasAuthority('purchased-funds')")
    @PostMapping("/sendMail")
    @ApiOperation(value = "sendMail", notes = "send mail")
    CommonResponse<Boolean> sendMail(@RequestBody PurchasedFundsQueryRequest request) throws MailjetException {
        Assert.isFalse(request == null
                || CharSequenceUtil.isBlank(request.getStartDate()), "Start date");
        purchasedFundsService.sendMail(request);
        return CommonResponse.success(Boolean.TRUE);
    }
    @GetMapping(value = "/exportPdf", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportPdf", notes = "export Json")
    void exportPdf(@RequestParam(required = false, value = "id") List<Long> id,
                                           @RequestParam(required = false, value = "date") String date,
                                           @RequestParam(required = false, value = "amount") String amount,
                                           @RequestParam(required = false, value = "template") Integer template,
                                           @RequestParam(required = false, value = "note") String note,
                                           HttpServletResponse response){
        try {
            if (template != null && template.equals(TemplateTypeEnum.ANNUAL.getCode())) {
                DateTime parseDate = DateUtil.parseDate(date);
                LocalDate searchLast = DateFormatUtil.getLocalDateByYearAndMonthAndDay(parseDate.toLocalDateTime().getYear(), 7, 1);
                purchasedFundsService.exportAnnual(searchLast, id, response);
            } else {
                purchasedFundsService.exportMonthly(date, amount, id, response, note);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/initPoolUnitCert")
    @ApiOperation(value = "initPoolUnitCert", notes = "initPoolUnitCert")
    CommonResponse<Boolean> initPoolUnitCertificate(@RequestParam(required = false, value = "id") List<Long> id) {
        purchasedFundsService.initPoolUnitCertificate(id);
        return CommonResponse.success(Boolean.TRUE);
    }

}
