package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiriesQueryRequest;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiryDetailRequest;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiriesExportDTO;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiriesResponse;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiryDetailResponse;
import com.github.pagehelper.PageInfo;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface IEnquiriesService {

    CommonResponse<PageInfo<EnquiriesResponse>> queryEnquiries(EnquiriesQueryRequest request, int pageNum, int pageSize);

    CommonResponse<EnquiryDetailResponse> queryEnquiryById(EnquiryDetailRequest request);

    void exportEnquiriesCsv(EnquiriesQueryRequest request, HttpServletResponse response) throws IOException;

    List<EnquiriesExportDTO> exportEnquiriesXml(EnquiriesQueryRequest request);
}
