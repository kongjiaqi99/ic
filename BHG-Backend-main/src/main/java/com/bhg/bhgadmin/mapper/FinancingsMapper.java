package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.request.financings.FinancingsQueryRequest;
import com.bhg.bhgadmin.dto.response.financings.FinancingDetailResponse;
import com.bhg.bhgadmin.dto.response.financings.FinancingEditDetailResponse;
import com.bhg.bhgadmin.dto.response.financings.FinancingsResponse;
import com.bhg.bhgadmin.entity.FinancingsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FinancingsMapper extends BaseMapper<FinancingsEntity> {

    List<FinancingsResponse> queryFinancingsResponses(FinancingsQueryRequest request);

    FinancingDetailResponse queryFinancingById(Long id);

    FinancingEditDetailResponse queryFinancingByIdWhenEdit(Long id);
}