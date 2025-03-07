package com.bhg.bhgadmin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.AuditEditRequest;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.entity.Audit;
import com.bhg.bhgadmin.entity.ClientsEntity;
import com.bhg.bhgadmin.entity.InvestmentEntities;
import com.bhg.bhgadmin.mapper.AuditMapper;
import com.bhg.bhgadmin.mapper.ClientsMapper;
import com.bhg.bhgadmin.mapper.InvestmentEntitiesMapper;
import com.bhg.bhgadmin.service.AuditService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bhg.bhgadmin.share.enums.AuditStatusEnum;
import com.bhg.bhgadmin.share.enums.AuditTypeEnum;
import com.bhg.bhgadmin.share.enums.EntityStatusEnum;
import com.bhg.bhgadmin.share.utils.LoginUserUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
@Service
public class AuditServiceImpl extends ServiceImpl<AuditMapper, Audit> implements AuditService {
    
    @Resource
    ClientsMapper clientsMapper;
    @Resource
    InvestmentEntitiesMapper entitiesMapper;
    @Override
    public CommonResponse<PageInfo<AuditResponse>> queryPage(AuditQueryRequest request, int pageNum, int pageSize) {
        if (request == null) {
            request = new AuditQueryRequest();
        }
        AuditQueryRequest finalRequest = request;
        PageInfo<Audit> page =
                PageHelper.startPage(pageNum, pageSize)
                        .doSelectPageInfo(() ->
                                baseMapper.selectList(new LambdaQueryWrapper<Audit>()
                                        .like(CharSequenceUtil.isNotBlank(finalRequest.getEmail()), Audit::getCreatorName, finalRequest.getCreator())
                                        .eq(CharSequenceUtil.isNotBlank(finalRequest.getAuditType()), Audit::getAuditType, finalRequest.getAuditType())
                                        .eq(CharSequenceUtil.isNotBlank(finalRequest.getStatus()), Audit::getStatus, finalRequest.getStatus())
                                        .like(CharSequenceUtil.isNotBlank(finalRequest.getCreatorName()), Audit::getStatus, finalRequest.getCreatorName())
                                        .eq(finalRequest.getCreator() != null, Audit::getCreator, finalRequest.getCreator())
                                        .orderByDesc(Audit::getId))
                        );
        PageInfo<AuditResponse> responses = new PageInfo<>();
        BeanUtils.copyProperties(page, responses, "list");
        responses.setList(BeanUtil.copyToList(page.getList(), AuditResponse.class));
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<Long> editAudit(AuditEditRequest request) {
        Audit audit = baseMapper.selectById(request.getId());
        Integer result = -1;
        if (audit != null) {
            String auditType = audit.getAuditType();
            if (auditType.equals(AuditTypeEnum.CLIENT.getMessage())) {
                result = auditClient(audit, request);
            } else if (auditType.equals(AuditTypeEnum.ENTITY.getMessage())) {
                result = auditEntity(audit, request);
            }
        }
        if (result > 0 || (audit != null &&
                ObjectUtil.equals(audit.getAuditType(),AuditTypeEnum.INVESTMENT.getMessage()))) {
            baseMapper.update(null, new LambdaUpdateWrapper<Audit>()
                    .set(Audit::getStatus, request.getStatus())
                    .set(Audit::getApprover, LoginUserUtil.getLoginUserId())
                    .set(Audit::getApproverName, LoginUserUtil.getLoginUserName())
                    .set(Audit::getUpdatedAt, new Date())
                    .eq(Audit::getId, request.getId())
            );
        }
        return CommonResponse.success(request.getId());
    }

    @Override
    public CommonResponse<AuditResponse> queryById(Long id) {
        Audit audit = baseMapper.selectById(id);
        if (audit != null) {
            return CommonResponse.success(BeanUtil.copyProperties(audit, AuditResponse.class));
        }
        return CommonResponse.success(null);
    }

    private int auditEntity(Audit audit, AuditEditRequest request) {
        if (request.getStatus().equals(AuditStatusEnum.REJECTED.getMessage())) {
            return entitiesMapper.update(null, new LambdaUpdateWrapper<InvestmentEntities>()
                    .set(InvestmentEntities::getStatus, EntityStatusEnum.NORMAL.getCode())
                    .set(InvestmentEntities::getUpdatedAt, new Date())
                    .eq(InvestmentEntities::getId, audit.getEntityId()));
        } else if (request.getStatus().equals(AuditStatusEnum.APPROVED.getMessage())) {
            InvestmentEntities entities = JSONUtil.toBean(audit.getNewEntity(), InvestmentEntities.class);
            return entitiesMapper.updateById(entities);
        }
        return -1;
    }

    private Integer auditClient(Audit audit, AuditEditRequest request) {
        if (request.getStatus().equals(AuditStatusEnum.REJECTED.getMessage())) {
            return clientsMapper.update(null, new LambdaUpdateWrapper<ClientsEntity>()
                    .set(ClientsEntity::getStatus, EntityStatusEnum.NORMAL.getCode())
                    .set(ClientsEntity::getUpdatedAt, new Date())
                    .eq(ClientsEntity::getId, audit.getEntityId()));
        } else if (request.getStatus().equals(AuditStatusEnum.APPROVED.getMessage())) {
            ClientsEntity clientsEntity = JSONUtil.toBean(audit.getNewEntity(),ClientsEntity.class);
            return clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                    .set(ClientsEntity::getUpperClientId, clientsEntity.getUpperClientId())
                    .set(ClientsEntity::getLevel2UpperClientId, clientsEntity.getLevel2UpperClientId())
                    .set(ClientsEntity::getBeaverId, clientsEntity.getBeaverId())
                    .set(ClientsEntity::getName, clientsEntity.getName())
                    .set(ClientsEntity::getClientType, clientsEntity.getClientType())
                    .set(ClientsEntity::getCountryCode, clientsEntity.getCountryCode())
                    .set(ClientsEntity::getMobile, clientsEntity.getMobile())
                    .set(ClientsEntity::getBirth, clientsEntity.getBirth())
                    .set(ClientsEntity::getUpdatedAt, clientsEntity.getUpdatedAt())
                    .set(ClientsEntity::getBsb, clientsEntity.getBsb())
                    .set(ClientsEntity::getAccountName, clientsEntity.getAccountName())
                    .set(ClientsEntity::getAccountNumber, clientsEntity.getAccountNumber())
                    .set(ClientsEntity::getStartDate, clientsEntity.getStartDate())
                    .set(ClientsEntity::getEndDate, clientsEntity.getEndDate())
                    .set(ClientsEntity::getInterestedFund, clientsEntity.getInterestedFund())
                    .set(ClientsEntity::getInvestEntity, clientsEntity.getInvestEntity())
                    .set(ClientsEntity::getInvestStatus, clientsEntity.getInvestStatus())
                    .set(ClientsEntity::getLinkToValueup, clientsEntity.getLinkToValueup())
                    .set(ClientsEntity::getTargetAmount, clientsEntity.getTargetAmount())
                    .set(ClientsEntity::getWithheldTax, clientsEntity.getWithheldTax())
                    .set(ClientsEntity::getTfNum, clientsEntity.getTfNum())
                    .eq(ClientsEntity::getId, clientsEntity.getId()));
        }
        return -1;
    }
}
