package com.bhg.bhgadmin.dto.biz;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import lombok.Data;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-18 15:26
 **/
@Data
public class BizMailjetSenderDTO {

    private String MAILJET_API_KEY;

    private String MAILJET_SECRET_KEY;

    private JSONArray receiverArrays;

    private JSONArray ccReceiverArrays;

    private JSONArray bccReceiverArrays;

    private List<BizMailReceiverDTO> receivers;

    private List<BizMailReceiverDTO> ccReceivers;

    private List<BizMailReceiverDTO> bccReceivers;

    private String subject;

    private String textPart;

    private String htmlPart;

    private String templateId;

    private JSONObject variables;

    private JSONArray attachements;

}
