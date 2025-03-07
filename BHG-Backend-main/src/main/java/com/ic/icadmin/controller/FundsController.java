package com.ic.icadmin.controller;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.funds.FundCreateRequest;
import com.ic.icadmin.dto.request.funds.FundEditRequest;
import com.ic.icadmin.dto.request.funds.FundsQueryRequest;
import com.ic.icadmin.dto.response.funds.FundDetailResponse;
import com.ic.icadmin.dto.response.funds.FundEditDetailResponse;
import com.ic.icadmin.dto.response.funds.FundsResponse;
import com.ic.icadmin.dto.response.funds.ListFundsExportDTO;
import com.ic.icadmin.service.IFundsService;
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

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-02 22:44
 **/
@RestController
@RequestMapping(path = "beaver-admin/funds")
@Api(tags = "Funds")
public class FundsController {

    @Autowired
    private IFundsService fundsService;

    @PreAuthorize("hasAuthority('funds')")
    @PostMapping("/queryFunds")
    @ApiOperation(value = "queryFunds", notes = "query Funds")
    CommonResponse<PageInfo<FundsResponse>> queryFunds(@RequestBody FundsQueryRequest request,
                                                       int pageNum,
                                                       int pageSize){
        return fundsService.queryFunds(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('funds')")
    @PostMapping("/queryFundById")
    @ApiOperation(value = "queryFundById", notes = "query Funds by Id")
    CommonResponse<FundDetailResponse> queryFundById(@RequestBody QueryByIdRequest request){
        CommonResponse<FundDetailResponse> fundDetailResponse= fundsService.queryFundById(request);
        return fundDetailResponse;
    }

    @PreAuthorize("hasAuthority('funds-edit')")
    @PostMapping("/createFund")
    @ApiOperation(value = "createFund", notes = "createFund")
    CommonResponse<Long> createFund(@RequestParam(value = "imFilePath", required = false)MultipartFile imFilePath,
                                    @RequestParam(value = "subImFilePath", required = false)MultipartFile subImFilePath,
                                    @RequestParam(value = "introduceFilePath", required = false)MultipartFile introduceFilePath,
                                    @RequestParam(value = "eoiFilePath", required = false)MultipartFile eoiFilePath,
                                    @RequestParam(value = "reportFilePath", required = false)MultipartFile reportFilePath,
                                    @RequestParam(value = "additionalInvestmentFile", required = false)MultipartFile additionalInvestmentFile,
                                    @RequestParam(value = "constitutionFile", required = false)MultipartFile constitutionFile,
                                    @RequestParam(value = "applicationForm", required = false)MultipartFile applicationForm,
                                    @RequestParam(value = "applicationFormTwo", required = false)MultipartFile applicationFormTwo,
                                    @RequestParam(value = "applicationFormThree", required = false)MultipartFile applicationFormThree,
                                    @RequestParam(value = "applicationFormFour", required = false)MultipartFile applicationFormFour,
                                    @RequestParam(value = "coverFile", required = false)MultipartFile cover,
                                    @RequestParam(value = "coverFileTwo", required = false)MultipartFile coverTwo,
                                    @RequestParam(value = "coverFileThree", required = false)MultipartFile coverThree,
                                    @RequestParam(value = "coverFileFour", required = false)MultipartFile coverFour,
                                    @RequestParam(value = "coverCnFile", required = false)MultipartFile coverCn,
                                    @RequestParam(value = "coverCnFileTwo", required = false)MultipartFile coverCnTwo,
                                    @RequestParam(value = "coverCnFileThree", required = false)MultipartFile coverCnThree,
                                    @RequestParam(value = "coverCnFileFour", required = false)MultipartFile coverCnFour,
                                    FundCreateRequest request){

        return CommonResponse.success(fundsService.createFund(imFilePath,
                                                              subImFilePath,
                                                              introduceFilePath,
                                                              eoiFilePath,
                                                              reportFilePath,
                                                              additionalInvestmentFile,
                                                              constitutionFile,
                applicationForm,
                applicationFormTwo,
                applicationFormThree,
                applicationFormFour,
                cover,
                coverTwo,
                coverThree,
                coverFour,
                coverCn,
                coverCnTwo,
                coverCnThree,
                coverCnFour,
                request));
    }

    @PreAuthorize("hasAuthority('funds-edit')")
    @PostMapping("/queryFundByIdWhenEdit")
    @ApiOperation(value = "queryFundByIdWhenEdit", notes = "query Fund By Id When Edit")
    CommonResponse<FundEditDetailResponse> queryFundByIdWhenEdit(@RequestBody QueryByIdRequest request){
        return fundsService.queryFundByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('funds-edit')")
    @PostMapping("/editFund")
    @ApiOperation(value = "editFund", notes = "edit Fund")
    CommonResponse<Long> editFund(@RequestParam(value = "imFilePath", required = false)MultipartFile imFilePath,
                                  @RequestParam(value = "subImFilePath", required = false)MultipartFile subImFilePath,
                                  @RequestParam(value = "introduceFilePath", required = false)MultipartFile introduceFilePath,
                                  @RequestParam(value = "eoiFilePath", required = false)MultipartFile eoiFilePath,
                                  @RequestParam(value = "reportFilePath", required = false)MultipartFile reportFilePath,
                                  @RequestParam(value = "additionalInvestmentFile", required = false)MultipartFile additionalInvestmentFile,
                                  @RequestParam(value = "constitutionFile", required = false)MultipartFile constitutionFile,
                                  @RequestParam(value = "applicationForm", required = false)MultipartFile applicationForm,
                                  @RequestParam(value = "applicationFormTwo", required = false)MultipartFile applicationFormTwo,
                                  @RequestParam(value = "applicationFormThree", required = false)MultipartFile applicationFormThree,
                                  @RequestParam(value = "applicationFormFour", required = false)MultipartFile applicationFormFour,
                                  @RequestParam(value = "coverFile", required = false)MultipartFile cover,
                                  @RequestParam(value = "coverFileTwo", required = false)MultipartFile coverTwo,
                                  @RequestParam(value = "coverFileThree", required = false)MultipartFile coverThree,
                                  @RequestParam(value = "coverFileFour", required = false)MultipartFile coverFour,
                                  @RequestParam(value = "coverCnFile", required = false)MultipartFile coverCn,
                                  @RequestParam(value = "coverCnFileTwo", required = false)MultipartFile coverCnTwo,
                                  @RequestParam(value = "coverCnFileThree", required = false)MultipartFile coverCnThree,
                                  @RequestParam(value = "coverCnFileFour", required = false)MultipartFile coverCnFour,
                                  FundEditRequest request){
        return fundsService.editFund(imFilePath,
                                     subImFilePath,
                                     introduceFilePath,
                                     eoiFilePath,
                                     reportFilePath,
                                     additionalInvestmentFile,
                                     constitutionFile,
                                     applicationForm,
                applicationFormTwo,
                applicationFormThree,
                applicationFormFour,
                                     cover,
                coverTwo,
                coverThree,
                coverFour,
                                     coverCn,
                coverCnTwo,
                coverCnThree,
                coverCnFour,
                                     request);
    }

    @PreAuthorize("hasAuthority('funds-edit')")
    @PostMapping("/delFund")
    @ApiOperation(value = "delFund", notes = "delete Fund")
    CommonResponse<Long> delFund(@RequestBody QueryByIdRequest request){
        return fundsService.delFund(request);
    }

    @PreAuthorize("hasAuthority('funds')")
    @GetMapping("/exportFundsCsv")
    @ApiModelProperty(value = "exportFundsCsv", notes = "export Funds Csv")
    void exportFundsCsv(FundsQueryRequest request,
                        HttpServletResponse response) throws IOException {
        fundsService.exportFundsCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportFundsXml", notes = "export Funds Xml")
    ListFundsExportDTO exportFundsXml(FundsQueryRequest request){
        return new ListFundsExportDTO(fundsService.exportFundsXml(request));
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportFundsJson", notes = "export Funds Json")
    ListFundsExportDTO exportFundsJson(FundsQueryRequest request){
        return new ListFundsExportDTO(fundsService.exportFundsXml(request));
    }
}
