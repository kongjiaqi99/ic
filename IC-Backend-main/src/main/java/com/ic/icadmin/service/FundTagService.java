package com.ic.icadmin.service;

import java.util.List;

import com.ic.icadmin.dto.request.FundTagRequest;
import com.ic.icadmin.dto.response.FundDetails;
import com.ic.icadmin.dto.response.FundTagResponse;

public interface FundTagService {
    
    FundTagResponse getFundsByTagIds(List<Long> ids);
    void addFundsToTag(FundTagRequest request);
    void deleteFunds(FundTagRequest request);
    FundTagResponse getAllAvailableFunds();

}
