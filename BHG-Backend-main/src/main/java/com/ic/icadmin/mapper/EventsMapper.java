package com.ic.icadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ic.icadmin.dto.response.events.EventTransResponse;
import com.ic.icadmin.entity.EventsEntity;

import java.util.List;

public interface EventsMapper extends BaseMapper<EventsEntity> {

    List<EventTransResponse> queryEventTrans();
}