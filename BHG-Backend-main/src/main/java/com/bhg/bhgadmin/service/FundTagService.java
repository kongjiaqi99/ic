package com.bhg.bhgadmin.service;

import java.util.List;

import com.bhg.bhgadmin.dto.request.FundTagRequest;
import com.bhg.bhgadmin.dto.response.FundDetails;
import com.bhg.bhgadmin.dto.response.FundTagResponse;

public interface FundTagService {
    
    FundTagResponse getFundsByTagIds(List<Long> ids);
    void addFundsToTag(FundTagRequest request);
    void deleteFunds(FundTagRequest request);
    FundTagResponse getAllAvailableFunds();

}
