package com.bhg.bhgadmin.api.service.impl;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.text.StrBuilder;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bhg.bhgadmin.api.dto.request.account.ClientInfoEditRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycDocumentTypesRequest;
import com.bhg.bhgadmin.api.dto.request.account.KycVerifyRequest;
import com.bhg.bhgadmin.api.dto.response.account.ApiFinancingProjectsResponse;
import com.bhg.bhgadmin.api.dto.response.account.ApiInvestmentProjectsResponse;
import com.bhg.bhgadmin.api.service.IAccountClientService;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.biz.BizFinancingSubClientTotalReturn;
import com.bhg.bhgadmin.dto.biz.BizPurchasedFundsDTO;
import com.bhg.bhgadmin.entity.*;
import com.bhg.bhgadmin.mapper.*;
import com.bhg.bhgadmin.properties.DynamicProperties;
import com.bhg.bhgadmin.properties.StaticProperties;
import com.bhg.bhgadmin.service.IClientService;
import com.bhg.bhgadmin.service.IPurchasedFundsService;
import com.bhg.bhgadmin.service.IStorageProcessor;
import com.bhg.bhgadmin.share.enums.FundCategoryEnum;
import com.bhg.bhgadmin.share.enums.KycStatusEnum;
import com.bhg.bhgadmin.share.error.ClientsErrorEnum;
import com.bhg.bhgadmin.share.error.CommonErrorEnum;
import com.bhg.bhgadmin.share.error.FundsErrorEnum;
import com.bhg.bhgadmin.share.utils.AmountFormatUtil;
import com.bhg.bhgadmin.share.utils.EnumUtil;
import com.bhg.bhgadmin.share.utils.FileUtil;
import com.google.common.collect.Lists;
import com.trulioo.normalizedapi.ApiClient;
import com.trulioo.normalizedapi.ApiException;
import com.trulioo.normalizedapi.api.ConfigurationApi;
import com.trulioo.normalizedapi.api.VerificationsApi;
import com.trulioo.normalizedapi.model.DataFields;
import com.trulioo.normalizedapi.model.Document;
import com.trulioo.normalizedapi.model.VerifyRequest;
import com.trulioo.normalizedapi.model.VerifyResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-21 23:59
 **/
@Slf4j
@Service
public class AccountClientServiceImpl implements IAccountClientService {

    @Autowired
    private InvestmentEntitiesMapper investmentEntitiesMapper;

    @Autowired
    private PurchasedFundsMapper purchasedFundsMapper;

    @Autowired
    private FinancingsMapper financingsMapper;

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private IPurchasedFundsService purchasedFundsService;

    @Autowired
    private IClientService clientService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private ThreadPoolTaskExecutor executor;

    @Autowired
    private StaticProperties staticProperties;

    @Autowired
    private DynamicProperties dynamicProperties;

    @Resource
    FinanceReferenceMapper financeRefMapper;

    @Resource
    private InvestmentEntitiesKycMapper investmentEntitiesKycMapper;
    private final static String INVESTMENT_ENTITY = "investment_entity";
    private final static String FILE_1_FRONT = "file_1_front";
    private final static String FILE_1_BACK = "file_1_back";
    private final static String FILE_2_FRONT = "file_2_front";
    private final static String FILE_2_BACK = "file_2_back";
    private final static String KYC_FILES_TEMP_PATH = "files/kycTempFiles";

    @Override
    public Integer getKycStatus(Long clientId) {
        List<InvestmentEntitiesKyc> investmentEntitiesList = investmentEntitiesKycMapper.selectList(
            Wrappers.<InvestmentEntitiesKyc>query().lambda().eq(InvestmentEntitiesKyc::getClientId, clientId)
                    .isNotNull(InvestmentEntitiesKyc::getKycStatus)
                    .eq(InvestmentEntitiesKyc::getDelFlag, Boolean.FALSE).orderByDesc(InvestmentEntitiesKyc::getUpdatedAt));
        if (CollectionUtil.isNotEmpty(investmentEntitiesList)){
            return investmentEntitiesList.get(0).getKycStatus();
        }
        return null;
    }

    @Override
    public CommonResponse<List<ApiInvestmentProjectsResponse>> queryInvestmentProject(Long loginUserId) {
        List<ApiInvestmentProjectsResponse> responses = new ArrayList<>();
        if (ObjectUtil.isNull(loginUserId)){
            CommonErrorEnum.PARMS_ERROR.throwException();
        }
        List<BizPurchasedFundsDTO> purchasedFundsDTOs = purchasedFundsMapper.queryPurchasedFundsForClientAPI(loginUserId);
        if (CollectionUtil.isEmpty(purchasedFundsDTOs)){
            return CommonResponse.success(responses);
        }
        for (BizPurchasedFundsDTO pf : purchasedFundsDTOs){
            BigDecimal currentTotalReturn = purchasedFundsService.getCurrentTotalReturn(pf);
            ApiInvestmentProjectsResponse investmentResponse = new ApiInvestmentProjectsResponse();
            investmentResponse.setFundName(pf.getFundName());
            investmentResponse.setSettlementDate(DateUtil.format(pf.getSettlementDate(), DatePattern.NORM_DATE_PATTERN));
            investmentResponse.setInterestDate(DateUtil.format(pf.getInterestStartDate(), DatePattern.NORM_DATE_PATTERN));
            investmentResponse.setTransactionDate(DateUtil.format(pf.getTransactionDate(), DatePattern.NORM_DATE_PATTERN));
            investmentResponse.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(pf.getPurchaseAmount().setScale(2, RoundingMode.HALF_UP)));
            investmentResponse.setAccumulatedIncomeBigDecimal(currentTotalReturn.setScale(2, RoundingMode.HALF_UP));
            investmentResponse.setAccumulatedIncome(AmountFormatUtil.formatThousandsSeparator(currentTotalReturn));
            responses.add(investmentResponse);
        }
        // calculate total
        ApiInvestmentProjectsResponse total = new ApiInvestmentProjectsResponse();
        total.setFundName("Total");
        total.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(purchasedFundsDTOs.stream().map(
            PurchasedFundsEntity::getPurchaseAmount).reduce(BigDecimal.ZERO, BigDecimal::add).setScale(2, RoundingMode.HALF_UP)));
        total.setAccumulatedIncome(AmountFormatUtil.formatThousandsSeparator(responses.stream().map(ApiInvestmentProjectsResponse::getAccumulatedIncomeBigDecimal).reduce(BigDecimal.ZERO, BigDecimal::add).setScale(2, RoundingMode.HALF_UP)));
        responses.add(total);
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<List<ApiFinancingProjectsResponse>> queryFinancingProject(ClientsEntity loginUser) {
        List<ApiFinancingProjectsResponse> responses = new ArrayList<>();
        if (ObjectUtil.isNotNull(loginUser.getUpperClientId()) && ObjectUtil.isNotNull(loginUser.getLevel2UpperClientId())){
            // 3级客户直接 返回空
            return CommonResponse.success(responses);
        }
        List<BizPurchasedFundsDTO> purchasedFundsDTOs = purchasedFundsMapper.queryPurchasedFundsForClientAPI(loginUser.getId());
        if (CollectionUtil.isEmpty(purchasedFundsDTOs)){
            return CommonResponse.success();
        }
        List<ClientsEntity> subSubClients = new ArrayList<>();
        for (BizPurchasedFundsDTO pf : purchasedFundsDTOs){
            FinancingsEntity financingsEntity = null;
            // 需要考虑自己做自己的upper client的情况
            if ((ObjectUtil.isNull(loginUser.getUpperClientId()) || loginUser.getId().equals(loginUser.getUpperClientId()))
                && ObjectUtil.isNull(loginUser.getLevel2UpperClientId())){
                //查询financing中的commission rate
                try {
                    financingsEntity = financingsMapper.selectOne(Wrappers.<FinancingsEntity>query().lambda()
                                                                                       .eq(FinancingsEntity::getClientId, pf.getClientId())
                                                                                       .eq(FinancingsEntity::getFundId, pf.getFundId())
                                                                                       .eq(FinancingsEntity::getDelFlag, Boolean.FALSE));
                    if (ObjectUtil.isNotNull(financingsEntity) && ObjectUtil.isNotNull(financingsEntity.getCommissionRate())){
                        pf.setCommissionRate(financingsEntity.getCommissionRate());
                    }
                } catch (Exception e){
                    log.error("用户端queryFinancingProject===ClientId={}, FundId={}查出多个financing===", pf.getClientId(), pf.getFundId());
                }
                // 1级用户
                // 查询其下2级客户
                List<ClientsEntity> subClientsToAssemble =
                    clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda()
                                                             .eq(ClientsEntity::getUpperClientId, loginUser.getId())
                                                             .isNull(ClientsEntity::getLevel2UpperClientId)
                                                             .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
                if (CollectionUtil.isNotEmpty(subClientsToAssemble)){
                    for (ClientsEntity sub : subClientsToAssemble) {
                        // 查询其下3级客户
                        List<ClientsEntity> subSubClientsToAssemble =
                            clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda()
                                                                     .eq(ClientsEntity::getUpperClientId, loginUser.getId())
                                                                     .eq(ClientsEntity::getLevel2UpperClientId, sub.getId())
                                                                     .eq(ClientsEntity::getDelFlag, Boolean.FALSE));
                        // 只有2级客户就把2级客户算作计息
                        if (CollectionUtil.isEmpty(subSubClientsToAssemble)){
                            subSubClients.add(sub);
                        } else {
                            subSubClients.addAll(subSubClientsToAssemble);
                        }
                    }
                }
            } else if (ObjectUtil.isNotNull(loginUser.getUpperClientId())
                && (ObjectUtil.isNull(loginUser.getLevel2UpperClientId()) || loginUser.getId().equals(loginUser.getLevel2UpperClientId()))){
                // 2级用户
                // 查询其下3级客户
                subSubClients = clientsMapper.selectList(Wrappers.<ClientsEntity>query().lambda()
                                                             .eq(ClientsEntity::getLevel2UpperClientId, loginUser.getId()));
            }
            // assemble response
            ApiFinancingProjectsResponse financingAmount = new ApiFinancingProjectsResponse();
            financingAmount.setFundName(pf.getFundName());
            financingAmount.setSettlementDate(DateUtil.format(pf.getSettlementDate(), DatePattern.NORM_DATE_PATTERN));
            financingAmount.setInterestDate(DateUtil.format(pf.getInterestStartDate(), DatePattern.NORM_DATE_PATTERN));
            if (CollectionUtil.isEmpty(subSubClients)){
                continue;
            }
            if (financingsEntity != null) {
                List<FinanceReference> financeReferences = financeRefMapper.selectList(new LambdaQueryWrapper<FinanceReference>()
                        .eq(FinanceReference::getFinanceId, financingsEntity.getId()));
                // get subClientTotalReturns
                List<BizPurchasedFundsDTO> subSubClientPurchasedFunds = purchasedFundsMapper.queryPurchasedFundsForFinancings(null, pf.getFundId(),
                        financeReferences.stream().map(FinanceReference::getEntityId).collect(Collectors.toList()));
                if (CollectionUtil.isEmpty(subSubClientPurchasedFunds)){
                    financingAmount.setTotalAmountBigDecimal(BigDecimal.ZERO);
                    financingAmount.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(BigDecimal.ZERO));
                    financingAmount.setAccumulatedCommissionBigDecimal(BigDecimal.ZERO);
                    financingAmount.setAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(BigDecimal.ZERO));
                } else {
                    financingAmount.setTotalAmountBigDecimal(subSubClientPurchasedFunds.stream().map(PurchasedFundsEntity::getPurchaseAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
                    financingAmount.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(financingAmount.getTotalAmountBigDecimal()));
                    financingAmount.setTransactionDate(DateUtil.format(subSubClientPurchasedFunds.stream().sorted(
                                    Comparator.comparing(PurchasedFundsEntity::getTransactionDate)).collect(Collectors.toList()).get(0).getTransactionDate(),
                            DatePattern.NORM_DATE_PATTERN));
                    // 没有commissionRate 只能计算投资总额
                    if (ObjectUtil.isNull(pf.getCommissionRate())){
                        financingAmount.setAccumulatedCommissionBigDecimal(BigDecimal.ZERO);
                        financingAmount.setAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(BigDecimal.ZERO));
                    } else {
                        List<BizFinancingSubClientTotalReturn> financingSubClientTotalReturns =
                                calculateFinancingSubClientTotalReturn(pf.getCommissionRate(), pf.getBYearlyReturnRate(), subSubClients, subSubClientPurchasedFunds);
                        financingAmount.setAccumulatedCommissionBigDecimal(financingSubClientTotalReturns.stream().map(BizFinancingSubClientTotalReturn::getCommissionTotalReturn).reduce(BigDecimal.ZERO, BigDecimal::add));
                        financingAmount.setAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(financingAmount.getAccumulatedCommissionBigDecimal()));
                    }
                }
            }
            responses.add(financingAmount);
        }
        if (CollectionUtil.isNotEmpty(responses)) {
            // calculate total
            ApiFinancingProjectsResponse total = new ApiFinancingProjectsResponse();
            total.setFundName("Total");
            total.setTotalAmount(AmountFormatUtil.formatThousandsSeparator(responses.stream().map(ApiFinancingProjectsResponse::getTotalAmountBigDecimal).reduce(BigDecimal.ZERO, BigDecimal::add)));
            total.setAccumulatedCommission(AmountFormatUtil.formatThousandsSeparator(responses.stream().map(ApiFinancingProjectsResponse::getAccumulatedCommissionBigDecimal).reduce(
                BigDecimal.ZERO, BigDecimal::add)));
            responses.add(total);
        }
        return CommonResponse.success(responses);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<String> editClientInfo(ClientInfoEditRequest request, Long loginUserId) {
        if (clientService.checkEmailExist(loginUserId, request.getEmail())){
            ClientsErrorEnum.EMAIL_EXIST.throwException(new Object[]{request.getEmail()});
        }
        clientsMapper.update(null, Wrappers.<ClientsEntity>update().lambda()
                            .set(StringUtils.hasText(request.getName()), ClientsEntity::getName, request.getName())
                            .set(StringUtils.hasText(request.getEmail()), ClientsEntity::getEmail, request.getEmail())
                            .set(StringUtils.hasText(request.getMobile()), ClientsEntity::getMobile, request.getMobile())
                            .set(ObjectUtil.isNotNull(request.getBirth()), ClientsEntity::getBirth, request.getBirth())
                            .set(StringUtils.hasText(request.getPassword()), ClientsEntity::getEncryptedPassword, passwordEncoder.encode(request.getPassword()))
                            .set(ClientsEntity::getUpdatedAt, new Date())
                            .eq(ClientsEntity::getId, loginUserId));
        return CommonResponse.success(request.getEmail());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CommonResponse<Long> kycVerify(MultipartFile docOneFront, MultipartFile docOneBack,
                                            MultipartFile livePhoto, KycVerifyRequest request, ClientsEntity loginUser) throws IOException, ApiException {
        InvestmentEntitiesKyc entity = new InvestmentEntitiesKyc();
        entity.setEntityType(request.getEntityType());
        entity.setEntityName(request.getEntityName());
        entity.setClientId(loginUser.getId());
        entity.setKycResult(Boolean.FALSE);
        entity.setBsb(loginUser.getBsb());
        entity.setAccountNumber(loginUser.getAccountNumber());
        entity.setAccountName(loginUser.getAccountName());
        entity.setKycStatus(KycStatusEnum.WAITING.getCode());
        Date now = new Date();
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        if (ObjectUtil.isNotNull(docOneFront)){
            entity.setFile1Front(storageProcessor.generateUploadFileName(docOneFront.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(docOneBack)){
            entity.setFile1Back(storageProcessor.generateUploadFileName(docOneBack.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(livePhoto)){
            entity.setFile2Front(storageProcessor.generateUploadFileName(livePhoto.getOriginalFilename()));
        }
/*        if (ObjectUtil.isNotNull(docTwoFront)){
            entity.setFile2Front(storageProcessor.generateUploadFileName(docTwoFront.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(docTwoBack)){
            entity.setFile2Back(storageProcessor.generateUploadFileName(docTwoBack.getOriginalFilename()));
        }*/
        investmentEntitiesKycMapper.insert(entity);
        // 上传Oss
        batchStoreFiles(docOneFront, docOneBack, livePhoto,entity);
        // post verify request
        verifyIdentity(docOneFront, docOneBack, livePhoto, request, entity);
        return CommonResponse.success(entity.getId());
    }

    @Override
    public CommonResponse<Long> kycVerifyCallBack(VerifyResult verifyResult) {
        if (ObjectUtil.isNull(verifyResult)){
            log.error("kycVerifyCallBack===request param verifyResult id null");
            CommonErrorEnum.PARMS_ERROR.throwException();
        }
        InvestmentEntitiesKyc entity = investmentEntitiesKycMapper.selectOne(
            Wrappers.<InvestmentEntitiesKyc>update().lambda().eq(InvestmentEntitiesKyc::getTranscationId,
                                                              verifyResult.getTransactionID()
                                                             ).eq(InvestmentEntitiesKyc::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNotNull(entity)){
            updateKycCallBackRecord(entity, verifyResult);
        } else {
            log.error("kycVerifyCallBack===Can not find Investment Entity that transaction Id={}", verifyResult.getTransactionID());
            CommonErrorEnum.PARMS_ERROR.throwException();
        }
        return CommonResponse.success();
    }

    @Override
    public CommonResponse<List<String>> queryCountryCode() {
        //Example Username: JoeNapoli_API_Demo, Example Password: 05uZuPRCyPi!6
        ApiClient apiClient = new ApiClient();
        apiClient.setUsername(staticProperties.getTrulioo_username());
        apiClient.setPassword(staticProperties.getTrulioo_password());
        ConfigurationApi configurationClient = new ConfigurationApi(apiClient);

        List<String> countryCodes = null;
        try {
            countryCodes = configurationClient.getCountryCodes("Identity Verification");
        } catch (ApiException e) {
            log.error("Exception when calling ConfigurationApi#getCountryCodes");
            e.printStackTrace();
        }
        return CommonResponse.success(countryCodes);
    }

    @Override
    public CommonResponse<Map<String, List<String>>> queryDocumentTypes(KycDocumentTypesRequest request) {
        ApiClient apiClient = new ApiClient();
        apiClient.setUsername(staticProperties.getTrulioo_username());
        apiClient.setPassword(staticProperties.getTrulioo_password());
        ConfigurationApi configurationClient = new ConfigurationApi(apiClient);
        Map<String, List<String>> documentTypes = null;
        //getDocumentTypes
        try {
            documentTypes = configurationClient.getDocumentTypes(request.getCountryCode());
        }  catch (ApiException e) {
            log.error("Exception when calling ConfigurationApi#getDocumentTypes");
            e.printStackTrace();
        }
        return CommonResponse.success(documentTypes);
    }

    @Override
    public ClientsEntity getClientById(Long id) {
        return clientsMapper.selectById(id);
    }


    //    ---------------------------------------------------------------------------------------------------------
    /**
     * calculate sub clients' total return in Financing
     * @param commissionRate
     * @param bYearlyReturnRate
     * @param subClient
     * @param subClientPurchasedFunds
     * @return
     */
    private List<BizFinancingSubClientTotalReturn> calculateFinancingSubClientTotalReturn(BigDecimal commissionRate, BigDecimal bYearlyReturnRate, List<ClientsEntity> subClient, List<BizPurchasedFundsDTO> subClientPurchasedFunds) {
        List<BizFinancingSubClientTotalReturn> financingSubClientTotalReturns = new ArrayList<>(subClientPurchasedFunds.size());
        for (PurchasedFundsEntity p : subClientPurchasedFunds){
            BizPurchasedFundsDTO dto = subClientPurchasedFunds.stream().filter(bizP -> bizP.getId().equals(p.getId())).collect(Collectors.toList()).get(0);
            BigDecimal currentTotalReturn = purchasedFundsService.getCurrentTotalReturn(dto);
            FundCategoryEnum fundCategory = EnumUtil.getByCode(FundCategoryEnum.class, dto.getBFundCategory());
            BigDecimal targetReturn = purchasedFundsService.getTargetReturn(dto, fundCategory, DateUtil.lengthOfYear(DateUtil.year(new Date())));
            BigDecimal currentMonthReturn = purchasedFundsService.getCurrentMonthReturn(dto);

            BizFinancingSubClientTotalReturn financingSubClientTotalReturn = new BizFinancingSubClientTotalReturn();
            List<ClientsEntity> clientsEntities =
                subClient.stream().filter(subClientEntity -> subClientEntity.getId().equals(p.getClientId())).collect(Collectors.toList());
            if (CollectionUtil.isEmpty(clientsEntities)){
                continue;
            }
            ClientsEntity clientsEntity = clientsEntities.get(0);
            financingSubClientTotalReturn.setClientId(clientsEntity.getId());
            financingSubClientTotalReturn.setEntityName(clientsEntity.getName());
            financingSubClientTotalReturn.setPurchasedDate(p.getUnitCertificateDate());
            financingSubClientTotalReturn.setPurchasedAmount(p.getPurchaseAmount());
            financingSubClientTotalReturn.setCurrentTotalReturn(currentTotalReturn);
            financingSubClientTotalReturn.setCommissionRate(commissionRate);
            financingSubClientTotalReturn.setCommissionTotalReturn(currentTotalReturn.multiply(
                commissionRate.divide(bYearlyReturnRate)
                                                                                              ).setScale(2, RoundingMode.HALF_UP));
            financingSubClientTotalReturn.setCommissionTargetReturn(targetReturn.multiply(
                commissionRate.divide(bYearlyReturnRate)
                                                                                         ).setScale(2, RoundingMode.HALF_UP));
            financingSubClientTotalReturn.setCommissionMonthReturn(currentMonthReturn.multiply(
                commissionRate.divide(bYearlyReturnRate)
                                                                                              ).setScale(2, RoundingMode.HALF_UP));
            financingSubClientTotalReturns.add(financingSubClientTotalReturn);
        }
        return financingSubClientTotalReturns;
    }
    private void delFileInOss(String fileType, Long id, String fileName) {
        if (StringUtils.hasText(fileName)) {
            try {
                // Delete ${fileType} from Oss
                storageProcessor.delete(new StringBuffer(
                    storageProcessor.getFilePathWithoutFileName(INVESTMENT_ENTITY, fileType, id.toString())).append(fileName).toString());
            } catch (IOException delE) {
                log.error("=====investment_entity/{}/{}delete Oss failed=====", fileType, id);
            }
        }
    }

    private void batchStoreFiles(MultipartFile docOneFront, MultipartFile docOneBack, MultipartFile livePhoto, InvestmentEntitiesKyc entity) {
        List<String> fileType = Arrays.asList("Doc 1 Front", "Doc 1 Back", "Doc 2 Front", "Doc 2 Back");
        int index = 0;
        try {
            if (ObjectUtil.isNotNull(docOneFront)) {
                index = 0;
                storageProcessor.store(docOneFront.getInputStream(), INVESTMENT_ENTITY, FILE_1_FRONT, entity.getId().toString(), entity.getFile1Front());
            }
            if (ObjectUtil.isNotNull(docOneBack)){
                index = 1;
                storageProcessor.store(docOneBack.getInputStream(), INVESTMENT_ENTITY, FILE_1_BACK, entity.getId().toString(), entity.getFile1Back());
            }
            if (ObjectUtil.isNotNull(livePhoto)){
                index = 2;
                storageProcessor.store(livePhoto.getInputStream(), INVESTMENT_ENTITY, FILE_2_FRONT, entity.getId().toString(), entity.getFile2Front());
            }
/*            if (ObjectUtil.isNotNull(docTwoBack)){
                index = 3;
                storageProcessor.store(docTwoBack.getInputStream(), INVESTMENT_ENTITY, FILE_2_BACK, entity.getId().toString(), entity.getFile2Back());
            }*/
        } catch (IOException e){
            int finalIndex = index;
            CompletableFuture.runAsync(()->{
                // 上传失败时，把同fund下的其他上传成功文件删除
                for (int i = finalIndex; i >= 0; i--){
                    switch (i){
                        case 0:
                            delFileInOss(FILE_1_FRONT, entity.getId(), entity.getFile1Front());
                            break;
                        case 1:
                            delFileInOss(FILE_1_BACK, entity.getId(), entity.getFile1Back());
                            break;
                       case 2:
                            delFileInOss(FILE_2_FRONT, entity.getId(), entity.getFile2Front());
                            break;
/*                         case 3:
                            delFileInOss(FILE_2_BACK, entity.getId(), entity.getFile2Back());
                            break;*/
                        default:
                            break;
                    }
                }
            }, executor);
            e.printStackTrace();
            FundsErrorEnum.FILE_UPLOAD_FAIL.throwException(new Object[]{fileType.get(index)});
        }
    }

    private void verifyIdentity(MultipartFile docOneFront, MultipartFile docOneBack, MultipartFile livePhoto
        , KycVerifyRequest request, InvestmentEntitiesKyc entity) throws IOException, ApiException {
        ApiClient apiClient = new ApiClient();
        // convert To Base64
        File docOneF = null;
        if (ObjectUtil.isNotNull(docOneFront)) {
            docOneF =
                new File(Objects.requireNonNull(
                    StrBuilder.create(KYC_FILES_TEMP_PATH)
                        .append(FileUtil.SLASH)
                        .append(entity.getClientId())
                        .append(FileUtil.SLASH)
                        .append(docOneFront.getOriginalFilename())).toString());
            FileUtils.copyInputStreamToFile(docOneFront.getInputStream(), docOneF);
        }
        File docOneB = null;
        if (ObjectUtil.isNotNull(docOneBack)) {
            docOneB = new File(Objects.requireNonNull(
                StrBuilder.create(KYC_FILES_TEMP_PATH)
                    .append(FileUtil.SLASH)
                    .append(entity.getClientId())
                    .append(FileUtil.SLASH)
                    .append(docOneBack.getOriginalFilename())).toString());
            FileUtils.copyInputStreamToFile(docOneBack.getInputStream(), docOneB);
        }
        File liveP = new File(Objects.requireNonNull(
            StrBuilder.create(KYC_FILES_TEMP_PATH)
                .append(FileUtil.SLASH)
                .append(entity.getClientId())
                .append(FileUtil.SLASH)
                .append(livePhoto.getOriginalFilename())).toString());
        FileUtils.copyInputStreamToFile(livePhoto.getInputStream(), liveP);

        apiClient.setUsername(staticProperties.getTrulioo_username());
        apiClient.setPassword(staticProperties.getTrulioo_password());
        VerificationsApi verificationClient = new VerificationsApi(apiClient);
        VerifyRequest verifyRequest = new VerifyRequest()
            .acceptTruliooTermsAndConditions(Boolean.TRUE)
            .configurationName("Identity Verification")
            .countryCode(request.getCountryCode())
            .callBackUrl(dynamicProperties.getKycCallBackUrl())
            .dataFields(new DataFields()
                            .document(new Document()
                                          .documentFrontImage(ObjectUtil.isNotNull(docOneF) ? Base64.encode(docOneF).getBytes(StandardCharsets.UTF_8) : null)
                                          .documentBackImage(ObjectUtil.isNotNull(docOneB) ? Base64.encode(docOneB).getBytes(StandardCharsets.UTF_8) : null)
                                          .livePhoto(Base64.encode(liveP).getBytes(StandardCharsets.UTF_8))
                                          .documentType(request.getDocOneType())))
            .verboseMode(Boolean.TRUE);
        VerifyResult verifyResult = verificationClient.verify(verifyRequest);
        log.info("KYC verifyIdentity===Sync result:{}===", JSON.toJSONString(verifyResult));
        updateKycCallBackRecord(entity, verifyResult);
//        Call call = verificationClient.verifyAsync(verifyRequest, new ApiCallback<VerifyResult>() {
//            @Override
//            public void onFailure(ApiException e, int i, Map<String, List<String>> map) {
//                log.error((Marker) Level.SEVERE, null, e);
//            }
//
//            @Override
//            public void onSuccess(VerifyResult verifyResult, int i, Map<String, List<String>> map) {
//                log.info("====onSuccess Async result:{}===", JSON.toJSONString(verifyResult));
////                updateKycCallBackRecord(entity, verifyResult);
//            }
//
//            @Override
//            public void onUploadProgress(long l, long l1, boolean b) {
//
//            }
//
//            @Override
//            public void onDownloadProgress(long l, long l1, boolean b) {
//
//            }
//        });
        if (docOneF.exists()){
            docOneF.delete();
        }
        if (docOneB.exists()){
            docOneB.delete();
        }
        if (liveP.exists()){
            liveP.delete();
        }
    }

    private void updateKycCallBackRecord(InvestmentEntitiesKyc entity, VerifyResult verifyResult) {
        Integer kycStatus = null;
        if (ObjectUtil.isNotNull(verifyResult)) {
            if ("match".equalsIgnoreCase(verifyResult.getRecord().getRecordStatus())) {
                kycStatus = KycStatusEnum.APPROVED.getCode();
            } else if ("nomatch".equalsIgnoreCase(verifyResult.getRecord().getRecordStatus())) {
                kycStatus = KycStatusEnum.NOT_MATCH.getCode();
            } else if ("missing".equalsIgnoreCase(verifyResult.getRecord().getRecordStatus())) {
                kycStatus = KycStatusEnum.NOT_MATCH.getCode();
            } else if ("censored".equalsIgnoreCase(verifyResult.getRecord().getRecordStatus())) {
                kycStatus = KycStatusEnum.WAITING.getCode();
            }
            log.info("kycVerify===Investment Id:{}, verify result:{}===", entity.getId(), verifyResult.getRecord().getRecordStatus());
        }
        if (ObjectUtil.isNotNull(kycStatus)) {
            // update transaction Id and details
            investmentEntitiesKycMapper.update(null, Wrappers.<InvestmentEntitiesKyc>update().lambda()
                .set(InvestmentEntitiesKyc::getTranscationId, verifyResult.getTransactionID())
                .set(InvestmentEntitiesKyc::getKycStatus, kycStatus)
                .set(InvestmentEntitiesKyc::getDetailInfo,verifyResult.getRecord().toString())
                .set(InvestmentEntitiesKyc::getUpdatedAt, new Date())
                .eq(InvestmentEntitiesKyc::getId, entity.getId()));
        }
    }
}
