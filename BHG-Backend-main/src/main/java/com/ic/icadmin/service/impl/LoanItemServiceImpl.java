package com.ic.icadmin.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemCreateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemUpdateRequest;
import com.ic.icadmin.dto.request.loanItems.LoanItemsQueryRequest;
import com.ic.icadmin.dto.response.loanItems.LoanItemDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemEditDetailResponse;
import com.ic.icadmin.dto.response.loanItems.LoanItemsExportDTO;
import com.ic.icadmin.dto.response.loanItems.LoanItemsResponse;
import com.ic.icadmin.entity.LoanItemsEntity;
import com.ic.icadmin.mapper.LoanItemsMapper;
import com.ic.icadmin.service.ILoanItemService;
import com.ic.icadmin.service.export.ExportService;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.enums.FilterTypeEnum;
import com.ic.icadmin.share.enums.LoanStatusFilterEnum;
import com.ic.icadmin.share.error.LoanItemsErrorEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-06 14:43
 **/
@Service
public class LoanItemServiceImpl implements ILoanItemService {

    private static String EXPORT_DATE_FORMAT_PATTERN = "yyyy-MM-dd";

    @Autowired
    private LoanItemsMapper loanItemsMapper;

    @Autowired
    private ExportService exportService;

    @Override
    public CommonResponse<PageInfo<LoanItemsResponse>> queryLoanItems(LoanItemsQueryRequest request, int pageNum,
                                                                      int pageSize) {
        PageInfo<LoanItemsEntity> loanItemsEntities = PageHelper.startPage(pageNum, pageSize)
                .doSelectPageInfo(() -> queryLoanItemsEntities(request));
        PageInfo<LoanItemsResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(loanItemsEntities, responses, "list");
        responses.setList(
            loanItemsEntities.getList().stream().map((LoanItemsEntity l)-> new LoanItemsResponse(l)).collect(Collectors.toList())
                         );
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<LoanItemDetailResponse> queryLoanItemById(QueryByIdRequest request) {
        LoanItemsEntity entity = getLoanItemEntity(request.getId());
        return CommonResponse.success(new LoanItemDetailResponse(entity));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> createLoanItem(LoanItemCreateRequest request) {
        LoanItemsEntity entity = buildLoanItem(request);
        int insert = loanItemsMapper.insert(entity);
        if (insert != 1){
            LoanItemsErrorEnum.LOAN_CREATE_FAIL.throwException();
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<LoanItemEditDetailResponse> queryLoanItemByIdWhenEdit(QueryByIdRequest request) {
        LoanItemsEntity entity = getLoanItemEntity(request.getId());
        return CommonResponse.success(new LoanItemEditDetailResponse(entity));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> updateLoanItem(LoanItemUpdateRequest request) {
        getLoanItemEntity(request.getId());
        LoanItemsEntity entity = buildLoanItem(request);
        entity.setId(request.getId());
        entity.setCreatedAt(null);
        int update = loanItemsMapper.update(null, Wrappers.<LoanItemsEntity>update().lambda()
                                           .set(LoanItemsEntity::getAddress, entity.getAddress())
                                           .set(LoanItemsEntity::getProjectDate, entity.getProjectDate())
                                           .set(LoanItemsEntity::getLoanStatus, entity.getLoanStatus())
                                           .set(LoanItemsEntity::getDescription, entity.getDescription())
                                           .set(LoanItemsEntity::getValue, entity.getValue())
                                           .set(LoanItemsEntity::getUpdatedAt, entity.getUpdatedAt())
                                           .eq(LoanItemsEntity::getId, entity.getId()));
        if (update != 1){
            LoanItemsErrorEnum.LOAN_UPDATE_FAIL.throwException();
        }
        return CommonResponse.success(entity.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> delLoanItem(QueryByIdRequest request) {
        getLoanItemEntity(request.getId());
        int del = loanItemsMapper.update(null, Wrappers.<LoanItemsEntity>update().lambda()
                              .set(LoanItemsEntity::getDelFlag, Boolean.TRUE)
                              .set(LoanItemsEntity::getUpdatedAt, new Date())
                              .eq(LoanItemsEntity::getId, request.getId()));
        if (del != 1){
            LoanItemsErrorEnum.LOAN_DELETE_FAIL.throwException();
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    public void exportLoansCsv(LoanItemsQueryRequest request, HttpServletResponse response) throws IOException {
        List<LoanItemsExportDTO> exportDTOS = queryExportData(request);
        String today = DateUtil.format(new Date(), FastDateFormat.getInstance(EXPORT_DATE_FORMAT_PATTERN, Locale.US));
        String fileName = CommonConstants.Export.EXPORT_CSV_LOANS+today+ ".csv";
        exportService.exportList(exportDTOS, fileName, response, LoanItemsExportDTO.class);
    }

    @Override
    public List<LoanItemsExportDTO> exportLoansXml(LoanItemsQueryRequest request) {
        return queryExportData(request);
    }


    //    --------------------------------------------------------------------------------------------------------

    private LoanItemsEntity getLoanItemEntity(Long id) {
        LoanItemsEntity entity = loanItemsMapper.selectOne(Wrappers.<LoanItemsEntity>query().lambda()
                                                               .eq(LoanItemsEntity::getId, id)
                                                               .eq(LoanItemsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entity)){
            LoanItemsErrorEnum.LOAN_NOT_EXIST.throwException();
        }
        return entity;
    }
    private LoanItemsEntity buildLoanItem(LoanItemCreateRequest request) {
        LoanItemsEntity entity = new LoanItemsEntity();
        entity.setAddress(request.getAddress());
        entity.setProjectDate(request.getProjectDate());
        entity.setLoanStatus(request.getLoanStatus());
        entity.setDescription(request.getDescription());
        entity.setValue(request.getValue());
        Date now = new Date();
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        return entity;
    }

    private List<LoanItemsEntity> queryLoanItemsEntities(LoanItemsQueryRequest request) {
        QueryWrapper<LoanItemsEntity> queryWrapper = Wrappers.<LoanItemsEntity>query();
        queryWrapper.eq("del_flag", Boolean.FALSE);
        if (StringUtils.hasText(request.getAddress())){
            FilterTypeEnum typeEnum = EnumUtil.getByCode(FilterTypeEnum.class, request.getAddressFilter());
            switch (typeEnum){
                case CONTAINS:
                    queryWrapper.like("LOWER(address)", request.getAddress().toLowerCase());
                    break;
                case EQUALS:
                    queryWrapper.eq("LOWER(address)", request.getAddress().toLowerCase());
                    break;
                case STARTS_WITH:
                    queryWrapper.likeRight("LOWER(address)", request.getAddress().toLowerCase());
                    break;
                case ENDS_WITH:
                    queryWrapper.likeLeft("LOWER(address)", request.getAddress().toLowerCase());
                    break;
                default:
                    break;
            }
        }
        queryWrapper.ge(ObjectUtil.isNotNull(request.getProjectDateStart()), "project_date", request.getProjectDateStart());
        queryWrapper.le(ObjectUtil.isNotNull(request.getProjectDateEnd()), "project_date", request.getProjectDateEnd());
        if (ObjectUtil.isNotNull(request.getLoanStatus())){
            LoanStatusFilterEnum statusEnum = EnumUtil.getByCode(LoanStatusFilterEnum.class, request.getLoanStatusFilter());
            switch (statusEnum){
                case EQUALS:
                    queryWrapper.eq("loan_status", request.getLoanStatus());
                    break;
                case GREATER_THAN:
                    queryWrapper.ge("loan_status", request.getLoanStatus());
                    break;
                case LESS_THAN:
                    queryWrapper.lt("loan_status", request.getLoanStatus());
                    break;
                default:
                    break;
            }
        }
        if (StringUtils.hasText(request.getDescription())){
            FilterTypeEnum typeEnum = EnumUtil.getByCode(FilterTypeEnum.class, request.getDescriptionFilter());
            switch (typeEnum){
                case CONTAINS:
                    queryWrapper.like("LOWER(description)", request.getDescription().toLowerCase());
                    break;
                case EQUALS:
                    queryWrapper.eq("LOWER(description)", request.getDescription().toLowerCase());
                    break;
                case STARTS_WITH:
                    queryWrapper.likeRight("LOWER(description)", request.getDescription().toLowerCase());
                    break;
                case ENDS_WITH:
                    queryWrapper.likeLeft("LOWER(description)", request.getDescription().toLowerCase());
                    break;
                default:
                    break;
            }
        }
        if (StringUtils.hasText(request.getValue())){
            FilterTypeEnum typeEnum = EnumUtil.getByCode(FilterTypeEnum.class, request.getValueFilter());
            switch (typeEnum){
                case CONTAINS:
                    queryWrapper.like("LOWER(value)", request.getValue().toLowerCase());
                    break;
                case EQUALS:
                    queryWrapper.eq("LOWER(value)", request.getValue().toLowerCase());
                    break;
                case STARTS_WITH:
                    queryWrapper.likeRight("LOWER(value)", request.getValue().toLowerCase());
                    break;
                case ENDS_WITH:
                    queryWrapper.likeLeft("LOWER(value)", request.getValue().toLowerCase());
                    break;
                default:
                    break;
            }
        }
        queryWrapper.ge(ObjectUtil.isNotNull(request.getCreateAtStart()), "created_at", request.getCreateAtStart());
        queryWrapper.le(ObjectUtil.isNotNull(request.getCreateAtEnd()), "created_at", request.getCreateAtEnd());
        queryWrapper.ge(ObjectUtil.isNotNull(request.getUpdateAtStart()), "created_at", request.getUpdateAtStart());
        queryWrapper.le(ObjectUtil.isNotNull(request.getUpdateAtEnd()), "created_at", request.getUpdateAtEnd());
        queryWrapper.orderByDesc("id");
        List<LoanItemsEntity> loanItemsEntities = loanItemsMapper.selectList(queryWrapper);
        return loanItemsEntities;
    }

    private List<LoanItemsExportDTO> queryExportData(LoanItemsQueryRequest request) {
        List<LoanItemsEntity> loanItemsEntities = queryLoanItemsEntities(request);
        List<LoanItemsExportDTO> exportDTOS =
            loanItemsEntities.stream().map((LoanItemsEntity l)->new LoanItemsExportDTO(l)).collect(Collectors.toList());
        return exportDTOS;
    }
}
