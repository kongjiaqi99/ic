package com.bhg.bhgadmin.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.bhg.bhgadmin.DAO.FundEntityDAO;
import com.bhg.bhgadmin.DAO.FundTagDAO;
import com.bhg.bhgadmin.DAO.TagDAO;
import com.bhg.bhgadmin.dto.request.FundTagRequest;
import com.bhg.bhgadmin.dto.response.FundDetails;
import com.bhg.bhgadmin.dto.response.FundTagResponse;
import com.bhg.bhgadmin.entity.FundEntity;
import com.bhg.bhgadmin.entity.FundTag;
import com.bhg.bhgadmin.service.FundTagService;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;

import lombok.AllArgsConstructor;
import lombok.Data;

@Service
@Data
@AllArgsConstructor
@Transactional
public class FundTagServiceImpl implements FundTagService{

    private TagDAO tagDAO;
    private FundTagDAO fundTagDAO;
    private FundEntityDAO fundEntityDAO;

    @Override
    public FundTagResponse getFundsByTagIds(List<Long> ids) {
        List<FundTag> result = new ArrayList<>();
        List<FundDetails> funds = new ArrayList<>();
        
        for (Long id : ids) {
            result.addAll(fundTagDAO.findByTagId(id));   
        }
        
        for (FundTag fundTag : result) {
            String name = fundEntityDAO.findById(fundTag.getFundId()).getFundName();
            Long fundId = fundTag.getFundId();
            Date endDate = fundEntityDAO.findById(fundTag.getFundId()).getEndDate();
            String endDay = DateFormatUtil.getDdMmYyyy(endDate);
            FundDetails detail = new FundDetails(fundId, name, endDay);
            funds.add(detail);
        }
        FundTagResponse response = new FundTagResponse(funds);
        return response;
    }

    @Override
    public void addFundsToTag(FundTagRequest request) {
        
        if (!tagDAO.existsById(request.getTagId())) {
            throw new IllegalArgumentException("Tag ID " + request.getTagId() + " does not exist in the tags table.");
        }
    
        for (Long fundId : request.getFundId()) {
            FundTag fundTag = new FundTag();
            fundTag.setTagId(request.getTagId());
            fundTag.setFundId(fundId);
            fundTagDAO.save(fundTag);
            
        }
    }

    @Override
    public void deleteFunds(FundTagRequest request) {
        for (Long fundId : request.getFundId()) {
            fundTagDAO.delete(fundId, request.getTagId());
        }
    }

    @Override
    public FundTagResponse getAllAvailableFunds() {
        List<FundDetails> result = new ArrayList<>();
        List<FundEntity> nonTaggedFunds = fundEntityDAO.findNonTaggedFunds();
        
        for (FundEntity nonTaggedFund : nonTaggedFunds) {
            result.add(new FundDetails(nonTaggedFund.getId(), nonTaggedFund.getFundName(), DateFormatUtil.getDdMmYyyy(nonTaggedFund.getEndDate())));
        }
        
        
        // The following has been done in database level.
        // Set<Long> taggedFundIds = fundTags.stream()
        //                                   .map(FundTag::getFundId)
        //                                   .collect(Collectors.toSet());

        // for (FundEntity fund : funds) {
        //     if (!taggedFundIds.contains(fund.getId())) {
        //         result.add(new FundDetails(fund.getId(), fund.getFundName(), DateFormatUtil.getDdMmYyyy(fund.getEndDate())));
        //     }
        // }
        FundTagResponse response = new FundTagResponse(result);
        return response;
        
    }

}
