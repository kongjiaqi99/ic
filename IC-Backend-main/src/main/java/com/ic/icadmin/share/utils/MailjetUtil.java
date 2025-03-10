package com.ic.icadmin.share.utils;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.ic.icadmin.dto.biz.BizMailjetSenderDTO;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.resource.Emailv31;
import lombok.extern.slf4j.Slf4j;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-17 17:23
 **/
@Slf4j
public class MailjetUtil extends BizMailjetSenderDTO {

    public MailjetUtil(BizMailjetSenderDTO mailjetSenderDTO) {
        this.setMAILJET_API_KEY(mailjetSenderDTO.getMAILJET_API_KEY());
        this.setMAILJET_SECRET_KEY(mailjetSenderDTO.getMAILJET_SECRET_KEY());
        JSONArray receivers = new JSONArray();
        mailjetSenderDTO.getReceivers().forEach(r->{
            receivers.put(new JSONObject()
                              .set("Email", r.getReceiverEmail())
                              .set("Name", r.getReceiverName()));
        });
        this.setReceiverArrays(receivers);
        if (CollectionUtil.isNotEmpty(mailjetSenderDTO.getCcReceivers())) {
            JSONArray ccReceivers = new JSONArray();
            mailjetSenderDTO.getCcReceivers().forEach(r -> {
                ccReceivers.put(new JSONObject().set("Email", r.getReceiverEmail()).set("Name", r.getReceiverName()));
            });
            this.setCcReceiverArrays(ccReceivers);
        }
        if (CollectionUtil.isNotEmpty(mailjetSenderDTO.getBccReceivers())) {
            JSONArray bccReceivers = new JSONArray();
            mailjetSenderDTO.getBccReceivers().forEach(r -> {
                bccReceivers.put(new JSONObject().set("Email", r.getReceiverEmail()).set("Name", r.getReceiverName()));
            });
            this.setBccReceiverArrays(bccReceivers);
        }
        this.setSubject(mailjetSenderDTO.getSubject());
        this.setTextPart(mailjetSenderDTO.getTextPart());
        this.setHtmlPart(mailjetSenderDTO.getHtmlPart());
        this.setTemplateId(mailjetSenderDTO.getTemplateId());
        this.setVariables(mailjetSenderDTO.getVariables());
        this.setAttachements(mailjetSenderDTO.getAttachements());
    }
    /**
     * This call sends a message to one recipient.
     */
    public Boolean sendMail(MailjetUtil mailjetUtil) throws MailjetException {
        MailjetClient client;
        MailjetRequest request;
        MailjetResponse response;
        client = new MailjetClient(mailjetUtil.getMAILJET_API_KEY(), mailjetUtil.getMAILJET_SECRET_KEY());
        request = new MailjetRequest(Emailv31.resource)
            .property(Emailv31.MESSAGES, new org.json.JSONArray()
                .put(new org.json.JSONObject()
                         .put(Emailv31.Message.FROM, new org.json.JSONObject()
                             .put("Email", "info@icglobal.com.au")
                             .put("Name", "ic Global"))
                         .put(Emailv31.Message.TO, mailjetUtil.getReceiverArrays())
                         .put(Emailv31.Message.SUBJECT, mailjetUtil.getSubject())
                         .put(Emailv31.Message.TEXTPART, mailjetUtil.getTextPart())
                         .put(Emailv31.Message.HTMLPART, mailjetUtil.getHtmlPart())));
        response = client.post(request);
        if (response.getStatus()==200) {
            log.info("===Email sent successfully:{}===", response.getData().toString());
            return Boolean.TRUE;
        } else {
            log.error("===Email sent unsuccessfully status:{}; data:{}===", response.getStatus(), response.getData().toString());
            return Boolean.FALSE;
        }
    }

    public Boolean sendMailWithTemplate(MailjetUtil mailjetUtil) throws MailjetException {
        MailjetClient client;
        MailjetRequest request;
        MailjetResponse response;
        client = new MailjetClient(mailjetUtil.getMAILJET_API_KEY(), mailjetUtil.getMAILJET_SECRET_KEY());
        request = new MailjetRequest(Emailv31.resource)
            .property(Emailv31.MESSAGES, new org.json.JSONArray()
                .put(new org.json.JSONObject()
                         .put(Emailv31.Message.FROM, new org.json.JSONObject()
                             .put("Email", "info@icglobal.com.au")
                             .put("Name", "ic Global"))
                         .put(Emailv31.Message.TO, mailjetUtil.getReceiverArrays())
                         .put(Emailv31.Message.CC, mailjetUtil.getCcReceiverArrays())
                         .put(Emailv31.Message.BCC, mailjetUtil.getBccReceiverArrays())
                         .put(Emailv31.Message.SUBJECT, mailjetUtil.getSubject())
                         .put(Emailv31.Message.TEMPLATEID, Integer.valueOf(mailjetUtil.getTemplateId()))
                         .put(Emailv31.Message.TEMPLATELANGUAGE, true)
                         .put(Emailv31.Message.VARIABLES, mailjetUtil.getVariables())
                         .put(Emailv31.Message.INLINEDATTACHMENTS, mailjetUtil.getAttachements())));
        response = client.post(request);
        if (response.getStatus()==200) {
            log.info("===Email sent successfully:{}===", response.getData().toString());
            return Boolean.TRUE;
        } else {
            log.error("===Email sent unsuccessfully status:{}; data:{}===", response.getStatus(), response.getData().toString());
            return Boolean.FALSE;
        }
    }
}
