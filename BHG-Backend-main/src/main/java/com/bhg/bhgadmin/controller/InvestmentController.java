package com.bhg.bhgadmin.controller;


import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.audit.AuditEditRequest;
import com.bhg.bhgadmin.dto.request.audit.AuditQueryRequest;
import com.bhg.bhgadmin.dto.request.investment.InvestmentRequest;
import com.bhg.bhgadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.bhg.bhgadmin.dto.response.audit.AuditResponse;
import com.bhg.bhgadmin.dto.response.investment.InvestmentGlobalResponse;
import com.bhg.bhgadmin.dto.response.investment.InvestmentRecord;
import com.bhg.bhgadmin.dto.response.investment.InvestmentResponse;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.share.enums.TemplateTypeEnum;
import com.bhg.bhgadmin.share.utils.DateFormatUtil;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
@RestController
@Slf4j
@RequestMapping("beaver-admin/investment")
public class InvestmentController {

    @Resource
    IPurchasedFundsService purchasedFundsService;

    @PreAuthorize("hasAnyAuthority('admin-users','purchased-funds')")
    @PostMapping("/queryPage")
    @ApiOperation(value = "queryPage", notes = "queryPage")
    public CommonResponse<PageInfo<InvestmentResponse>> queryPage(@RequestBody InvestmentRequest request,
                                                                       int pageNum, int pageSize){
        return purchasedFundsService.queryInvestmentPage(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAnyAuthority('admin-users','purchased-funds')")
    @GetMapping("/queryGlobal")
    @ApiOperation(value = "queryGlobal", notes = "queryGlobal")
    public CommonResponse<InvestmentGlobalResponse> queryGlobal(){
        return purchasedFundsService.queryInvestmentGlobal();
    }

    @PreAuthorize("hasAnyAuthority('admin-users','purchased-funds')")
    @PostMapping("/record")
    @ApiOperation(value = "record", notes = "record")
    public CommonResponse<List<InvestmentRecord>> record(@RequestBody PurchasedFundsQueryRequest request){
        return purchasedFundsService.investmentRecord(request);
    }

    @GetMapping(value = "/exportPdf", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportPdf", notes = "export Json")
    void exportPdf(@RequestParam( value = "fundId") Long fundId,
                   @RequestParam( value = "entityId") Long entityId,
                   @RequestParam(required = false, value = "note") String note,
                   HttpServletResponse response){
        try {
            purchasedFundsService.exportInvestmentPdf(fundId, entityId, note, response);
        } catch (Exception e) {
            log.error("investment exportPdf error", e);
        }
    }
}

