package com.ic.icadmin.api.service;

import com.ic.icadmin.api.dto.request.*;
import com.ic.icadmin.api.dto.response.ClientsLoginResponse;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.client.*;
import com.ic.icadmin.entity.ClientsEntity;
import com.ic.icadmin.entity.Notification;
import com.mailjet.client.errors.MailjetException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IApiClientService {

    /**
     * login by client
     * @param request
     * @param servletRequest
     * @return
     * @throws Exception
     */
    CommonResponse<ClientsLoginResponse> clientLogin(ClientLoginRequest request, HttpServletRequest servletRequest);

    /**
     * get Ip
     * @param httpServletRequest
     * @return
     */
    String getIpAddress(HttpServletRequest httpServletRequest);

    /**
     * logout
     * @return
     */
    CommonResponse<String> clientLogout();

    /**
     * 发送密码重置验证码
     * @param request
     * @return
     */
    CommonResponse<String> resetPasswordCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException;

    CommonResponse<String> resetPassword(ResetPasswordRequest request);

    CommonResponse<Long> editClient(ClientEditRequest request);

    CommonResponse<Long> editEntity(InvestmentCreateRequest request);

    CommonResponse<String> editPassword(EditPasswordRequest request);

    CommonResponse<Long> shareApp(ShareAppRequest request, HttpServletRequest httpServletRequest) throws Exception;

    CommonResponse<Long> editPushClientId(ClientPushIdRequest request);

    void pushMsg(Notification notification);

    void pushPurchasedMsg(ClientsEntity clientsEntity, Long pfId, Long fundId);

    void pushEventMsg(List<Long> clientId);

    CommonResponse<String> registerCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException;

    CommonResponse<Long> createClient(ClientCreateRequest request);

    CommonResponse<String> clientLogoff();

    CommonResponse<Boolean> isLogoff();

    CommonResponse<Boolean> isRegister();

    CommonResponse<String> resetPasswordCodeMsgSend(ResetPasswordCodeSendRequest request);

    CommonResponse<String> setPin(PinRequest request);

    CommonResponse<String> editPin(EditPinRequest request);

    CommonResponse<String> checkPin(PinRequest request);

    CommonResponse<String> visitorCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException;

    CommonResponse<ClientsLoginResponse> visitorLogin(ClientLoginRequest request);

    CommonResponse<String> visitorLogout();

    CommonResponse<String> resetPin(EditPinRequest request);

    CommonResponse<String> resetPinMsgSend();

    CommonResponse<String> resetPinCodeSend() throws MailjetException;
}
