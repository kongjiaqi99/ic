package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.request.funds.FundsQueryRequest;
import com.ic.icadmin.dto.response.financings.FundsNameResponse;
import com.ic.icadmin.entity.FundsEntity;

import java.util.List;

public interface FundsMapper extends BaseMapper<FundsEntity> {

    List<FundsNameResponse> getFundsNames();

    List<FundsNameResponse> getFundsNamesCN();

    List<FundsEntity> selectListByRequest(FundsQueryRequest request);
}