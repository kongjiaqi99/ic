package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.request.funds.FundsQueryRequest;
import com.bhg.bhgadmin.dto.response.financings.FundsNameResponse;
import com.bhg.bhgadmin.entity.FundsEntity;

import java.util.List;

public interface FundsMapper extends BaseMapper<FundsEntity> {

    List<FundsNameResponse> getFundsNames();

    List<FundsNameResponse> getFundsNamesCN();

    List<FundsEntity> selectListByRequest(FundsQueryRequest request);
}