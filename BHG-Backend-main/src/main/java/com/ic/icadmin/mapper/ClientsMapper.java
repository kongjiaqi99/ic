package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.biz.BizClientDetailDTO;
import com.ic.icadmin.dto.request.client.ClientsQueryRequest;
import com.ic.icadmin.dto.response.client.UpperClientsResponse;
import com.ic.icadmin.dto.response.financings.ClientsNameResponse;
import com.ic.icadmin.entity.ClientsEntity;
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