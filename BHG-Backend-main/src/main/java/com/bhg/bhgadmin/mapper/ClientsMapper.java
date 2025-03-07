package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.biz.BizClientDetailDTO;
import com.bhg.bhgadmin.dto.request.client.ClientsQueryRequest;
import com.bhg.bhgadmin.dto.response.client.UpperClientsResponse;
import com.bhg.bhgadmin.dto.response.financings.ClientsNameResponse;
import com.bhg.bhgadmin.entity.ClientsEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClientsMapper extends BaseMapper<ClientsEntity> {

    /**
     * birthday coming in 1 month
     *
     * @return
     */
    List<ClientsEntity> queryBirthdayComingOneMonth();

    BizClientDetailDTO queryClientDetailById(@Param("id") Long id);

    List<UpperClientsResponse> queryUpperClients();

    List<ClientsNameResponse> getClientsNames();

    List<ClientsEntity> queryClientList(ClientsQueryRequest request);
}