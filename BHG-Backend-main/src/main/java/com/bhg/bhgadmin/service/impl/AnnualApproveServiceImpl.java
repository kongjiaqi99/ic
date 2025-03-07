package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.purchasedFunds.AnnualApproveDto;
import com.bhg.bhgadmin.entity.AnnualApprove;
import com.bhg.bhgadmin.mapper.AnnualApproveMapper;
import com.bhg.bhgadmin.service.AnnualApproveService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 服务接口实现
 *
 * @author ljc
 * @since 2024-06-17 14:41:18
 * @description 由 Mybatisplus Code Generator 创建
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class AnnualApproveServiceImpl extends ServiceImpl<AnnualApproveMapper, AnnualApprove> implements AnnualApproveService {
    private final AnnualApproveMapper annualApproveMapper;


    @Override
    public CommonResponse<List<AnnualApproveDto>> queryList(AnnualApproveDto dto) {
        List<AnnualApprove> annualApproves = annualApproveMapper.selectList(new LambdaQueryWrapper<AnnualApprove>()
                .eq(dto.getClientId() != null, AnnualApprove::getClientId, dto.getClientId())
                .eq(dto.getEntityId() != null, AnnualApprove::getEntityId, dto.getEntityId())
                .eq(dto.getFundId() != null, AnnualApprove::getFundId, dto.getFundId())
        );
        List<AnnualApproveDto> list = BeanUtil.copyToList(annualApproves, AnnualApproveDto.class);
        return CommonResponse.success(list);
    }

    @Override
    public CommonResponse<Long> addApprove(AnnualApproveDto dto) {
        AnnualApprove annualApprove = BeanUtil.copyProperties(dto, AnnualApprove.class);
        LambdaQueryWrapper<AnnualApprove> eq = new LambdaQueryWrapper<AnnualApprove>()
                .eq(dto.getClientId() != null, AnnualApprove::getClientId, dto.getClientId())
                .eq(dto.getEntityId() != null, AnnualApprove::getEntityId, dto.getEntityId())
                .eq(dto.getFundId() != null, AnnualApprove::getFundId, dto.getFundId())
                ;
        List<AnnualApprove> list = list(eq);
        if (CollUtil.isEmpty(list)) {
            save(annualApprove);
        } else {
            annualApprove = list.get(0);
            annualApprove.setYearList(dto.getYearList());
            updateById(annualApprove);
        }
        return CommonResponse.success(annualApprove.getId());
    }
}