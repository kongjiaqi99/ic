package com.bhg.bhgadmin.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-05-05 17:27
 **/
@Data
@Component
@ConfigurationProperties(prefix = "dynamic-properties")
@RefreshScope
public class DynamicProperties {

    private Long tokenExpireTime;

    private Long resetPasswordTokenExpireTime;

    private String kycCallBackUrl;
    private String pushUrl;

    private BizSendUCEmailReceiversDTO sendUCEmailReceivers;

    private BizSendUCEmailReceiversDTO sendPFMonthlyEmailReceivers;

    private BizSendUCEmailReceiversDTO sendPFAnnualEmailReceivers;

    private BizSendUCEmailReceiversDTO sendEnquiryEmailReceivers;
    private BizSendUCEmailReceiversDTO sendInvestmentEmailReceivers;

    @Data
    public static class BizSendUCEmailReceiversDTO {

        public List<BizMailCCReceiverDTO> cc;

        public List<BizMailCCReceiverDTO> bcc;
    }

    @Data
    public static class BizMailCCReceiverDTO {

        public String name;

        public String email;
    }

}
