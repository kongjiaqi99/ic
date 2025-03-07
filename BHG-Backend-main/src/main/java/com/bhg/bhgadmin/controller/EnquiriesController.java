package com.bhg.bhgadmin.controller;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiriesQueryRequest;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiryDetailRequest;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiriesResponse;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiryDetailResponse;
import com.bhg.bhgadmin.dto.response.enquiries.ListEnquiriesExportDTO;
import com.bhg.bhgadmin.service.IEnquiriesService;
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

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/enquiries")
@Api(tags = "Enquiries")
public class EnquiriesController extends BaseController {

    @Autowired
    private IEnquiriesService enquiriesService;

    @PreAuthorize("hasAuthority('enquiries')")
    @PostMapping("/queryEnquiries")
    @ApiOperation(value = "queryEnquiries", notes = "query Enquiries")
    CommonResponse<PageInfo<EnquiriesResponse>> queryEnquiries(@RequestBody EnquiriesQueryRequest request,
                                                               int pageNum,
                                                               int pageSize){
        return enquiriesService.queryEnquiries(request, pageNum, pageSize);
    };

    @PreAuthorize("hasAuthority('enquiries')")
    @PostMapping("/queryEnquiryById")
    @ApiModelProperty(value = "queryEnquiryById", notes = "query Enquiry By Id")
    CommonResponse<EnquiryDetailResponse> queryEnquiryById(@RequestBody EnquiryDetailRequest request){
        return enquiriesService.queryEnquiryById(request);
    }

    @PreAuthorize("hasAuthority('enquiries')")
    @GetMapping("/exportEnquiriesCsv")
    @ApiModelProperty(value = "exportEnquiriesCsv", notes = "export Enquiries Csv")
    void exportEnquiriesCsv(EnquiriesQueryRequest request,
                          HttpServletResponse response) throws IOException {
        enquiriesService.exportEnquiriesCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportEnquiriesXml", notes = "export Enquiries Xml")
    ListEnquiriesExportDTO exportEnquiriesXml(EnquiriesQueryRequest request){
        return new ListEnquiriesExportDTO(enquiriesService.exportEnquiriesXml(request));
    }


    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportEnquiriesJson", notes = "export Events Json")
    ListEnquiriesExportDTO exportEnquiriesJson(EnquiriesQueryRequest request){
        return new ListEnquiriesExportDTO(enquiriesService.exportEnquiriesXml(request));
    }

}
