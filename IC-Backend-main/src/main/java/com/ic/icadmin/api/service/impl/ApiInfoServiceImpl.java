package com.ic.icadmin.api.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ic.icadmin.api.dto.request.account.ClientSubmitEnquiryRequest;
import com.ic.icadmin.api.dto.response.news.ApiNewsDetailResponse;
import com.ic.icadmin.api.dto.response.news.ApiNewsResponse;
import com.ic.icadmin.api.service.IApiInfosService;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.biz.BizMailReceiverDTO;
import com.ic.icadmin.dto.biz.BizMailjetSenderDTO;
import com.ic.icadmin.entity.*;
import com.ic.icadmin.mapper.EnquiriesMapper;
import com.ic.icadmin.mapper.NewsImgsMapper;
import com.ic.icadmin.mapper.NewsMapper;
import com.ic.icadmin.properties.DynamicProperties;
import com.ic.icadmin.properties.StaticProperties;
import com.ic.icadmin.service.BorrowProposedSecurityService;
import com.ic.icadmin.service.INewsImgsService;
import com.ic.icadmin.service.INewsService;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.constants.MailJetConstants;
import com.ic.icadmin.share.enums.LanguageEnum;
import com.ic.icadmin.share.enums.NewsTypeEnum;
import com.ic.icadmin.share.error.CommonErrorEnum;
import com.ic.icadmin.share.error.NewsErrorEnum;
import com.ic.icadmin.share.utils.EnumUtil;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.MailjetUtil;
import com.google.common.collect.Lists;
import com.mailjet.client.errors.MailjetException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-20 13:37
 **/
@Service
@Slf4j
public class ApiInfoServiceImpl implements IApiInfosService {

    private final static String MAIN_PIC = "main_pic";

    private final static String IMG = "img";


    @Autowired
    private NewsMapper newsMapper;

    @Autowired
    private INewsService newsService;

    @Autowired
    private EnquiriesMapper enquiriesMapper;

    @Autowired
    private NewsImgsMapper newsImgsMapper;

    @Autowired
    private INewsImgsService newsImgsService;
    @Autowired
    private StaticProperties staticProperties;
    @Autowired
    private DynamicProperties dynamicProperties;
    @Resource
    private BorrowProposedSecurityService borrowService;

    @Autowired
    private IStorageProcessor storageProcessor;

    @Autowired
    private OssClientConfig ossClientConfig;

    @Override
    public CommonResponse<List<ApiNewsResponse>> queryNews(Integer newsType, Integer language, Integer limitNum) {
        NewsTypeEnum newsTypeEnum = EnumUtil.getByCode(NewsTypeEnum.class, newsType);
        LanguageEnum languageEnum = EnumUtil.getByCode(LanguageEnum.class, language);
        if (ObjectUtil.isNull(newsTypeEnum) || ObjectUtil.isNull(languageEnum)){
            CommonErrorEnum.PARMS_ERROR.throwException();
        }
        List<ApiNewsResponse> responses = new ArrayList<>();
        List<NewsEntity> newsEntities = newsMapper.selectList(Wrappers.<NewsEntity>query().lambda()
                             .eq(NewsEntity::getNewsType, newsType)
                             .eq(NewsEntity::getLanguage, language)
                             .eq(NewsEntity::getDelFlag, Boolean.FALSE)
                             .orderByDesc(NewsEntity::getId)
                             .last(ObjectUtil.isNotNull(limitNum), "limit " + limitNum));

        if (CollectionUtils.isEmpty(newsEntities)){
            return CommonResponse.success(responses);
        }
        for (NewsEntity entity : newsEntities){
            ApiNewsResponse response = new ApiNewsResponse();
            response.setId(entity.getId());
            response.setCreateAt(DateUtil.formatDateTime(entity.getCreatedAt()));
            response.setMainPic(newsService.getNewsFileFullPath(MAIN_PIC, entity.getId(), entity.getMainPic()));
            response.setNewsType(newsTypeEnum.getMessage());
            response.setPublishDate(DateUtil.format(entity.getPublishDate(), DatePattern.NORM_DATE_PATTERN));
            response.setTitle(entity.getTitle());
            response.setUpdateAt(DateUtil.formatDateTime(entity.getUpdatedAt()));
            responses.add(response);
        }
        return CommonResponse.success(responses);
    }

    @Override
    public CommonResponse<ApiNewsDetailResponse> queryNewsDetail(Long id) {
         NewsEntity entity = newsMapper.selectOne(Wrappers.<NewsEntity>query().lambda()
                            .eq(NewsEntity::getId, id)
                            .eq(NewsEntity::getDelFlag, Boolean.FALSE));
        if (ObjectUtil.isNull(entity)){
            NewsErrorEnum.NEWS_NOT_EXIST.throwException();
        }
        ApiNewsDetailResponse response = new ApiNewsDetailResponse();
        response.setId(entity.getId());
        response.setContent(entity.getContent());
        response.setCreateAt(DateUtil.formatDateTime(entity.getCreatedAt()));
        response.setLanguage(EnumUtil.getEnumMessageByCode(LanguageEnum.class, entity.getLanguage()));
        response.setMainPic(newsService.getNewsFileFullPath(MAIN_PIC, entity.getId(), entity.getMainPic()));
        response.setNewsType(EnumUtil.getEnumMessageByCode(NewsTypeEnum.class, entity.getNewsType()));
        response.setPublishDate(DateUtil.format(entity.getPublishDate(), DatePattern.NORM_DATE_PATTERN));
        response.setShowToWeb(entity.getShowToWeb());
        response.setTitle(entity.getTitle());
        response.setUpdateAt(DateUtil.formatDateTime(entity.getUpdatedAt()));
        List<NewsImgsEntity> imgsEntities = newsImgsMapper.selectList(Wrappers.<NewsImgsEntity>query().lambda()
                                 .eq(NewsImgsEntity::getNewsId, entity.getId())
                                 .eq(NewsImgsEntity::getDelFlag, Boolean.FALSE)
                                 .orderByAsc(NewsImgsEntity::getDisplayOrder));
        if (CollectionUtil.isNotEmpty(imgsEntities)){
            List<String> newsImgs = new ArrayList<>(imgsEntities.size());
            for (NewsImgsEntity newsImgEntity : imgsEntities){
                newsImgs.add(newsImgsService.getNewsImgFileFullPath(IMG, newsImgEntity.getId(), newsImgEntity.getImg()));
            }
            response.setNewsImgs(newsImgs);
         }
        return CommonResponse.success(response);
    }

    @Override
    public CommonResponse<String> submitEnquiry(ClientSubmitEnquiryRequest request, MultipartFile intentionFile, MultipartFile valuationFile, MultipartFile borrowFile, MultipartFile asicFile, MultipartFile idFile, MultipartFile houseFile, MultipartFile investFile, MultipartFile carFile, MultipartFile loanFile, MultipartFile leaseFile, MultipartFile cardFile) {
        EnquiriesEntity entity = new EnquiriesEntity();
        BeanUtils.copyProperties(request, entity);
        if (request.getBorrowDate() != null) {
            entity.setBorrowDate(DateUtil.parseDate(request.getBorrowDate()));
        }
        /*if (ObjectUtil.isNotNull(intentionFile)){
            entity.setIntentionFile(storageProcessor.generateUploadFileName(intentionFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(valuationFile)){
            entity.setValuationFile(storageProcessor.generateUploadFileName(valuationFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(borrowFile)){
            entity.setBorrowFile(storageProcessor.generateUploadFileName(borrowFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(asicFile)){
            entity.setAsicFile(storageProcessor.generateUploadFileName(asicFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(idFile)){
            entity.setIdFile(storageProcessor.generateUploadFileName(idFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(houseFile)){
            entity.setHouseFile(storageProcessor.generateUploadFileName(houseFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(investFile)){
            entity.setInvestFile(storageProcessor.generateUploadFileName(investFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(carFile)){
            entity.setCarFile(storageProcessor.generateUploadFileName(carFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(loanFile)){
            entity.setLoanFile(storageProcessor.generateUploadFileName(loanFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(leaseFile)){
            entity.setLeaseFile(storageProcessor.generateUploadFileName(leaseFile.getOriginalFilename()));
        }
        if (ObjectUtil.isNotNull(cardFile)){
            entity.setCardFile(storageProcessor.generateUploadFileName(cardFile.getOriginalFilename()));
        }*/
        Date now = new Date();
        entity.setCreatedAt(now);
        entity.setUpdatedAt(now);
        enquiriesMapper.insert(entity);
//        batchStoreFiles(entity, intentionFile, valuationFile, borrowFile, asicFile, idFile, houseFile, investFile, carFile, loanFile, leaseFile, cardFile);
        if (CollUtil.isNotEmpty(request.getBorrowList())) {
            List<BorrowProposedSecurity> borrowList = BeanUtil.copyToList(request.getBorrowList(), BorrowProposedSecurity.class);
            borrowList.forEach(b->b.setEnquiryId(entity.getId()));
            borrowService.saveBatch(borrowList);
        }
        CommonResponse<String> success = CommonResponse.success(request.getName());
        if (CharSequenceUtil.isBlank(request.getEmail())) {
            return success;
        }
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        try {
            List<BizMailReceiverDTO> bizMailReceiverDTOS = Lists.newArrayList(new BizMailReceiverDTO(request.getEmail(), request.getName()));
            mailjetSenderDTO.setMAILJET_API_KEY(staticProperties.getMAILJET_API_KEY());
            mailjetSenderDTO.setMAILJET_SECRET_KEY(staticProperties.getMAILJET_SECRET_KEY());
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
            mailjetSenderDTO.setSubject(MailJetConstants.NEW_ENQUIRY_EMAIL_SUBJECT);
            mailjetSenderDTO.setTemplateId(MailJetConstants.NEW_ENQUIRY_EMAIL_TEMPLATE_ID);
            JSONObject variables = new JSONObject().set("name", request.getName());
            DynamicProperties.BizSendUCEmailReceiversDTO receivers = dynamicProperties.getSendEnquiryEmailReceivers();
            if (ObjectUtil.equals(request.getType(), 2)) {
                receivers = dynamicProperties.getSendInvestmentEmailReceivers();
            }
            if (receivers != null){
                if (receivers.getCc() != null) {
                    mailjetSenderDTO.setCcReceivers(
                            receivers.getCc().stream().filter(Objects::nonNull)
                                    .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                            receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
                    );
                }
                if (receivers.getBcc() != null) {
                    mailjetSenderDTO.setBccReceivers(
                            receivers.getBcc().stream().filter(Objects::nonNull)
                                    .map((DynamicProperties.BizMailCCReceiverDTO receiverEmail) -> new BizMailReceiverDTO(
                                            receiverEmail.getEmail(), receiverEmail.getName())).collect(Collectors.toList())
                    );
                }
            }
            mailjetSenderDTO.setVariables(variables);
            MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
            mailjetUtil.sendMailWithTemplate(mailjetUtil);
        } catch (MailjetException e) {
            log.error("new client mail error, {}", JSONUtil.toJsonStr(mailjetSenderDTO), e);
        }
        return success;
    }

    @Override
    public CommonResponse<String> upload(MultipartFile files, HttpServletRequest httpServletRequest) throws IOException {
        log.info(files.getOriginalFilename());
        String store = storageProcessor.store(files.getInputStream(), "data", "data", "data", files.getOriginalFilename());
        String fundFileAllPath = new StringBuffer(CommonConstants.HTTPS_PREFIX)
                .append(ossClientConfig.getBucketName())
                .append(FileUtil.POINT_STR)
                .append(ossClientConfig.getEndpoint())
                .append(FileUtil.SLASH)
                .append(store)
                .toString();
        return CommonResponse.success(fundFileAllPath);

    }

    private void batchStoreFiles(EnquiriesEntity entity, MultipartFile intentionFile, MultipartFile valuationFile, MultipartFile borrowFile, MultipartFile asicFile, MultipartFile idFile, MultipartFile houseFile, MultipartFile investFile, MultipartFile carFile, MultipartFile loanFile, MultipartFile leaseFile, MultipartFile cardFile) {
        try {
            if (ObjectUtil.isNotNull(intentionFile)) {
                storageProcessor.store(intentionFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getIntentionFile());
            }
            if (ObjectUtil.isNotNull(valuationFile)) {
                storageProcessor.store(valuationFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getValuationFile());
            }
            if (ObjectUtil.isNotNull(borrowFile)) {
                storageProcessor.store(borrowFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getBorrowFile());
            }
            if (ObjectUtil.isNotNull(asicFile)) {
                storageProcessor.store(asicFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getAsicFile());
            }
            if (ObjectUtil.isNotNull(idFile)) {
                storageProcessor.store(idFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getIdFile());
            }
            if (ObjectUtil.isNotNull(houseFile)) {
                storageProcessor.store(houseFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getHouseFile());
            }
            if (ObjectUtil.isNotNull(investFile)) {
                storageProcessor.store(investFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getInvestFile());
            }
            if (ObjectUtil.isNotNull(carFile)) {
                storageProcessor.store(carFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getCarFile());
            }
            if (ObjectUtil.isNotNull(loanFile)) {
                storageProcessor.store(loanFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getLoanFile());
            }
            if (ObjectUtil.isNotNull(leaseFile)) {
                storageProcessor.store(leaseFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getLeaseFile());
            }
            if (ObjectUtil.isNotNull(cardFile)) {
                storageProcessor.store(cardFile.getInputStream(), "enquiries", "enquiries", entity.getId().toString(), entity.getCardFile());
            }
        } catch (IOException e){
            log.info("enquiries file error");
        }
    }
}
