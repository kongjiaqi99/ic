package com.ic.icadmin.service;

import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.enquiries.EnquiriesQueryRequest;
import com.ic.icadmin.dto.request.enquiries.EnquiryDetailRequest;
import com.ic.icadmin.dto.response.enquiries.EnquiriesExportDTO;
import com.ic.icadmin.dto.response.enquiries.EnquiriesResponse;
import com.ic.icadmin.dto.response.enquiries.EnquiryDetailResponse;
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
