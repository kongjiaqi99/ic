package com.ic.icadmin.api.dto.request;

import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import io.swagger.annotations.ApiModel;
import lombok.Data;


/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "PurchasedFundsQueryRequest", description = "PurchasedFunds Query Request")
public class PurchasedFundsPageRequest extends PurchasedFundsQueryRequest {
    int pageNum = 1;
    int pageSize = 30;
}
