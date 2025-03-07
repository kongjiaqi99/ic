package com.bhg.bhgadmin.api.dto.request;

import com.bhg.bhgadmin.dto.request.investment.InvestmentRequest;
import lombok.Data;

@Data
public class InvestmentPageRequest extends InvestmentRequest {
    int pageNum = 1;
    int pageSize = 30;
}

