package com.ic.icadmin.service;

import cn.hutool.core.date.DateTime;
import com.ic.icadmin.api.dto.request.ApplicationFormRequest;
import com.ic.icadmin.api.dto.request.ReInvestmentRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizPurchasedFundsDTO;
import com.ic.icadmin.dto.request.QueryByIdRequest;
import com.ic.icadmin.dto.request.investment.InvestmentRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundCreateRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundEditRequest;
import com.ic.icadmin.dto.request.purchasedFunds.PurchasedFundsQueryRequest;
import com.ic.icadmin.dto.response.client.InvestmentEntityResponse;
import com.ic.icadmin.dto.response.investment.InvestmentGlobalResponse;
import com.ic.icadmin.dto.response.investment.InvestmentRecord;
import com.ic.icadmin.dto.response.investment.InvestmentResponse;
import com.ic.icadmin.dto.response.purchasedFunds.DividendHistoryResponse;
import com.ic.icadmin.dto.response.purchasedFunds.PurchasedFundEditDetailResponse;
import com.ic.icadmin.dto.response.purchasedFunds.PurchasedFundsDetailResponse;
import com.ic.icadmin.dto.response.purchasedFunds.PurchasedFundsExportDTO;
import com.ic.icadmin.dto.response.purchasedFunds.PurchasedFundsResponse;
import com.ic.icadmin.entity.FundsEntity;
import com.ic.icadmin.entity.PurchasedFundsEntity;
import com.ic.icadmin.share.enums.FundCategoryEnum;
import com.github.pagehelper.PageInfo;
import com.mailjet.client.errors.MailjetException;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface IPurchasedFundsService {

    PageInfo<PurchasedFundsResponse> queryPurchasedFunds(PurchasedFundsQueryRequest request, int pageNum, int pageSize);

    CommonResponse<PurchasedFundsDetailResponse> queryPurchasedFundById(Long id);

    CommonResponse<Long> createPurchasedFund(MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour, PurchasedFundCreateRequest request);

    CommonResponse<PurchasedFundEditDetailResponse> queryPurchasedFundByIdWhenEdit(QueryByIdRequest request);

    CommonResponse<Long> editPurchasedFund(MultipartFile applicationFormSigned, MultipartFile applicationFormSignedTwo, MultipartFile applicationFormSignedThree, MultipartFile applicationFormSignedFour, PurchasedFundEditRequest request);

    CommonResponse<Long> delPurchasedFund(QueryByIdRequest request);

    void exportCsv(PurchasedFundsQueryRequest request, HttpServletResponse response) throws IOException;

    List<PurchasedFundsExportDTO> exportXml(PurchasedFundsQueryRequest request);

    BigDecimal getCurrentMonthReturn(BizPurchasedFundsDTO dto);

    BigDecimal getMonthReturnByDate(BizPurchasedFundsDTO dto, LocalDate nowLocalDate);
    BigDecimal getReturnByDate(BizPurchasedFundsDTO dto, Date start, Date end);
    BigDecimal getCurrentTotalReturn(BizPurchasedFundsDTO dto);

    BigDecimal getTargetReturn(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory, int lengthOfYear);

    void sendUnitCertificate(QueryByIdRequest request) throws MailjetException;

    String getPurchasedFundFileFullPath(String fileType, Long id, String fileName);

    Date getStartReturnDay(BizPurchasedFundsDTO dto);

    Date getEndDay(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory);

    DateTime offsetWeekendDays(DateTime beginDate);

    int getLengthOfThisYear(Date unitCertificateDate);

    //1. 无论是新的还是旧的，只要purchase end date有输入值，就按照purchase end date来
    //2. 没有purchase end date的，就看fund的end date
    //     2.1 今天之前的基金，如果有输入fund end date就按照fund end date来；没有输入fund end date的使用保留的duration逻辑作为fund end date
    //     2.2 今天之后的基金，不需要duration逻辑，我们会手动输入fund end date，所以今天之后的基金都按照fund end date来
    //2024-07-05
    Date getEndDayReal(BizPurchasedFundsDTO dto, FundCategoryEnum fundCategory);

    List<DividendHistoryResponse> dividendDates(BizPurchasedFundsDTO dto, Date startDividendDate, Date endDay);

    CommonResponse<Boolean> sendMail(PurchasedFundsQueryRequest request) throws MailjetException;

    void exportMonthly(String date, String amount, List<Long> id, HttpServletResponse response, String note) throws Exception;

    void exportAnnual(LocalDate searchLast, List<Long> id, HttpServletResponse response);

    CommonResponse<PageInfo<InvestmentResponse>> queryInvestmentPage(InvestmentRequest request, int pageNum, int pageSize);

    BizPurchasedFundsDTO getBizPf(PurchasedFundsEntity pf, FundsEntity fund);

    CommonResponse<InvestmentGlobalResponse> queryInvestmentGlobal();

    String exportUnitCertificate(QueryByIdRequest request);

    CommonResponse<List<InvestmentRecord>> investmentRecord(PurchasedFundsQueryRequest request);

    List<InvestmentEntityResponse> getInvestmentCount(List<Long> entityIdList);

    CommonResponse<Long> reInvestment(ReInvestmentRequest request);

    BigDecimal getCurrentTotalReturnByDate(BizPurchasedFundsDTO bizPf, LocalDate minusDays);

    CommonResponse<String> upload(ReInvestmentRequest request, MultipartFile file, HttpServletRequest httpServletRequest);

    void pushInvestmentMsg();

    void initPoolUnitCertificate(List<Long> pfId);

    void exportInvestmentPdf(Long fundId, Long entityId, String note, HttpServletResponse response);

    CommonResponse<Long> sendApplicationForm(MultipartFile iSign,
                                             MultipartFile iSignTwo,
                                             MultipartFile iSignThree,
                                             MultipartFile cSign,
                                             MultipartFile cSignTwo,
                                             MultipartFile tSign,
                                             MultipartFile tSignTwo,
                                             MultipartFile tSignThree,
                                             MultipartFile tSignFour,
                                             MultipartFile aSign,
                                             MultipartFile aSignTwo, ApplicationFormRequest request);
}
