package com.bhg.bhgadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bhg.bhgadmin.dto.response.events.EventTransResponse;
import com.bhg.bhgadmin.entity.EventsEntity;

import java.util.List;

public interface EventsMapper extends BaseMapper<EventsEntity> {

    List<EventTransResponse> queryEventTrans();
}