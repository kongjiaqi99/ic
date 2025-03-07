package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.request.financings.FinancingsQueryRequest;
import com.ic.icadmin.dto.response.financings.FinancingDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingEditDetailResponse;
import com.ic.icadmin.dto.response.financings.FinancingsResponse;
import com.ic.icadmin.entity.FinancingsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FinancingsMapper extends BaseMapper<FinancingsEntity> {

    List<FinancingsResponse> queryFinancingsResponses(FinancingsQueryRequest request);

    FinancingDetailResponse queryFinancingById(Long id);

    FinancingEditDetailResponse queryFinancingByIdWhenEdit(Long id);
}