package com.ic.icadmin.api.dto.request;

import com.ic.icadmin.dto.request.investment.InvestmentRequest;
import lombok.Data;

@Data
public class InvestmentPageRequest extends InvestmentRequest {
    int pageNum = 1;
    int pageSize = 30;
}

