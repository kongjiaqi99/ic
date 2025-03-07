package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.config.OssClientConfig;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiriesQueryRequest;
import com.bhg.bhgadmin.dto.request.enquiries.EnquiryDetailRequest;
import com.bhg.bhgadmin.dto.response.enquiries.BorrowResponse;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiriesExportDTO;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiriesResponse;
import com.bhg.bhgadmin.dto.response.enquiries.EnquiryDetailResponse;
import com.bhg.bhgadmin.entity.BorrowProposedSecurity;
import com.bhg.bhgadmin.entity.EnquiriesEntity;
import com.bhg.bhgadmin.entity.FundsEntity;
import com.bhg.bhgadmin.mapper.BorrowProposedSecurityMapper;
import com.bhg.bhgadmin.mapper.EnquiriesMapper;
import com.bhg.bhgadmin.service.IEnquiriesService;
import com.bhg.bhgadmin.service.IStorageProcessor;
import com.bhg.bhgadmin.service.export.ExportService;
import com.bhg.bhgadmin.share.constants.CommonConstants;
import com.bhg.bhgadmin.share.enums.EnquiryTypeEnum;
import com.bhg.bhgadmin.share.error.EnquiriesErrorEnum;
import com.bhg.bhgadmin.share.error.FundsErrorEnum;
import com.bhg.bhgadmin.share.utils.FileUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-29 12:29
 **/
@Slf4j
@Service
public class EnquiriesServiceImpl implements IEnquiriesService {

    @Autowired
    private EnquiriesMapper enquiriesMapper;

    @Autowired
    private ExportService exportService;

    @Resource
    private BorrowProposedSecurityMapper borrowMapper;
    @Autowired
    private OssClientConfig ossClientConfig;
    @Autowired
    private IStorageProcessor storageProcessor;
    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Override
    public CommonResponse<PageInfo<EnquiriesResponse>> queryEnquiries(EnquiriesQueryRequest request, int pageNum, int pageSize) {
        PageInfo<EnquiriesEntity> enquiriesEntityList = PageHelper.startPage(pageNum, pageSize)
            .doSelectPageInfo(()->queryEnquiriesEntities(request));
        PageInfo<EnquiriesResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(enquiriesEntityList, responses, "list");
        responses.setList(
            enquiriesEntityList.getList().stream().map((EnquiriesEntity e)-> new EnquiriesResponse(e)).collect(
                Collectors.toList()));

        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<EnquiryDetailResponse> queryEnquiryById(EnquiryDetailRequest request) {
        EnquiriesEntity enquiriesEntity = enquiriesMapper.selectOne(Wrappers.<EnquiriesEntity>query().lambda()
                                 .eq(EnquiriesEntity::getId, request.getId())
                                 .eq(EnquiriesEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(enquiriesEntity)){
            EnquiriesErrorEnum.ENQUIRY_NOT_EXIST.throwException();
        }
        EnquiryDetailResponse response = new EnquiryDetailResponse();
        BeanUtil.copyProperties(enquiriesEntity, response);
        response.setCreateAt(enquiriesEntity.getCreatedAt());
        response.setUpdateAt(enquiriesEntity.getUpdatedAt());
        if (ObjectUtil.equals(enquiriesEntity.getType(), EnquiryTypeEnum.BORROW.getCode())) {
            List<BorrowProposedSecurity> borrowList = borrowMapper.selectList(new LambdaQueryWrapper<BorrowProposedSecurity>()
                    .eq(BorrowProposedSecurity::getEnquiryId, request.getId()));
            if (CollUtil.isNotEmpty(borrowList)) {
                List<BorrowResponse> borrowResponses = BeanUtil.copyToList(borrowList, BorrowResponse.class);
                response.setBorrowList(borrowResponses);
            }
        }
//        response.setIntentionFile(getFileFullPath(request.getId(), enquiriesEntity.getIntentionFile()));
//        response.setValuationFile(getFileFullPath(request.getId(), enquiriesEntity.getValuationFile()));
//        response.setBorrowFile(getFileFullPath(request.getId(), enquiriesEntity.getBorrowFile()));
//        response.setAsicFile(getFileFullPath(request.getId(), enquiriesEntity.getAsicFile()));
//        response.setIdFile(getFileFullPath(request.getId(), enquiriesEntity.getIdFile()));
//        response.setHouseFile(getFileFullPath(request.getId(), enquiriesEntity.getHouseFile()));
//        response.setInvestFile(getFileFullPath(request.getId(), enquiriesEntity.getInvestFile()));
//        response.setCarFile(getFileFullPath(request.getId(), enquiriesEntity.getCarFile()));
//        response.setLoanFile(getFileFullPath(request.getId(), enquiriesEntity.getLoanFile()));
//        response.setLeaseFile(getFileFullPath(request.getId(), enquiriesEntity.getLeaseFile()));
//        response.setCardFile(getFileFullPath(request.getId(), enquiriesEntity.getCardFile()));
        return CommonResponse.success(response);
    }
    public String getFileFullPath(Long fundId, String fileName) {
        if (StrUtil.isNotBlank(fileName)) {
            String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
                    .append(ossClientConfig.getBucketName())
                    .append(FileUtil.POINT_STR)
                    .append(ossClientConfig.getEndpoint())
                    .append(FileUtil.SLASH)
                    .append(storageProcessor.getFilePathWithoutFileName("enquiries", "enquiries", fundId.toString()))
                    .append(fileName)
                    .toString();
            return fundFileAllPath;
        }
        return null;
    }
    @Override
    public void exportEnquiriesCsv(EnquiriesQueryRequest request, HttpServletResponse response) throws IOException {
        List<EnquiriesExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_ENQUIRIES+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, EnquiriesExportDTO.class);
    }

    @Override
    public List<EnquiriesExportDTO> exportEnquiriesXml(EnquiriesQueryRequest request) {
        return queryExportData(request);
    }

    //    -----------------------------------------------------------------------------------------------------

    private List<EnquiriesEntity> queryEnquiriesEntities(EnquiriesQueryRequest request) {
        QueryWrapper<EnquiriesEntity> queryWrapper = Wrappers.<EnquiriesEntity>query();
        if (ObjectUtil.isNotNull(request.getName()) && StringUtils.hasText(request.getName())){
            queryWrapper.like("LOWER(name)", request.getName().toLowerCase());
        }
        if (ObjectUtil.isNotNull(request.getMessage()) && StringUtils.hasText(request.getMessage())){
            queryWrapper.like("LOWER(message)", request.getMessage().toLowerCase());
        }
        if (ObjectUtil.isNotNull(request.getEmail()) && StringUtils.hasText(request.getEmail())){
            queryWrapper.like("LOWER(email)", request.getEmail().toLowerCase());
        }
        queryWrapper
            .eq("del_flag", Boolean.FALSE)
            .orderByDesc("id");
        List<EnquiriesEntity> enquiriesEntityList = enquiriesMapper.selectList(queryWrapper);
        return enquiriesEntityList;
    }

    private List<EnquiriesExportDTO> queryExportData(EnquiriesQueryRequest request){
        List<EnquiriesEntity> enquiriesEntityList = queryEnquiriesEntities(request);
        List<EnquiriesExportDTO> response = enquiriesEntityList.stream().map(
            (EnquiriesEntity e) -> new EnquiriesExportDTO(e)).collect(Collectors.toList());
        return response;
    }


}
