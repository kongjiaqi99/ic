package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IClients;
import com.ic.icadmin.api.dto.request.*;
import com.ic.icadmin.api.dto.response.ClientsLoginResponse;
import com.ic.icadmin.api.service.IApiClientService;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.client.ClientCreateRequest;
import com.ic.icadmin.dto.request.client.ClientEditRequest;
import com.ic.icadmin.dto.request.client.ClientPushIdRequest;
import com.ic.icadmin.dto.request.client.ShareAppRequest;
import com.mailjet.client.errors.MailjetException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2023-01-13 12:37
 **/
@RestController
public class ClientController implements IClients {

    @Autowired
    private IApiClientService apiClientService;

    @Override
    public CommonResponse<ClientsLoginResponse> clientLogin(ClientLoginRequest request, HttpServletRequest servletRequest) {
        return apiClientService.clientLogin(request, servletRequest);
    }

    @Override
    public CommonResponse<String> clientLogout() {
        return apiClientService.clientLogout();
    }

    @Override
    public CommonResponse<String> resetPasswordCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        return apiClientService.resetPasswordCodeSend(request);
    }

    @Override
    public CommonResponse<String> resetPasswordCodeMsgSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        return apiClientService.resetPasswordCodeMsgSend(request);
    }

    @Override
    public CommonResponse<String> resetPassword(ResetPasswordRequest request) {
        return apiClientService.resetPassword(request);
    }

    @Override
    public CommonResponse<String> editPassword(EditPasswordRequest request) {
        return  apiClientService.editPassword(request);
    }

    @Override
    public CommonResponse<Long> editClient(ClientEditRequest request) {
        return apiClientService.editClient(request);
    }

    @Override
    public CommonResponse<Long> shareApp(ShareAppRequest numRequest, HttpServletRequest request) throws Exception {
        return apiClientService.shareApp(numRequest, request);
    }

    @Override
    public CommonResponse<Long> editPushClientId(ClientPushIdRequest request) {
        return apiClientService.editPushClientId(request);
    }

    @Override
    public CommonResponse<String> registerCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        return apiClientService.registerCodeSend(request);
    }

    @Override
    public CommonResponse<Long> createClient(ClientCreateRequest request) {
        return apiClientService.createClient(request);
    }

    @Override
    public CommonResponse<String> clientLogoff() {
        return apiClientService.clientLogoff();
    }

    @Override
    public CommonResponse<Boolean> isLogoff() {
        return apiClientService.isLogoff();
    }

    @Override
    public CommonResponse<Boolean> isRegister() {
        return apiClientService.isRegister();
    }

    @Override
    public CommonResponse<String> setPin(PinRequest request) {
        return apiClientService.setPin(request);
    }

    @Override
    public CommonResponse<String> editPin(EditPinRequest request) {
        return apiClientService.editPin(request);
    }

    @Override
    public CommonResponse<String> resetPin(EditPinRequest request) {
        return apiClientService.resetPin(request);
    }

    @Override
    public CommonResponse<String> resetPinCodeSend() throws MailjetException {
        return apiClientService.resetPinCodeSend();
    }

    @Override
    public CommonResponse<String> resetPinMsgSend() throws MailjetException {
        return apiClientService.resetPinMsgSend();
    }

    @Override
    public CommonResponse<String> checkPin(PinRequest request) {
        return apiClientService.checkPin(request);
    }

    @Override
    public CommonResponse<String> visitorCodeSend(ResetPasswordCodeSendRequest request) throws MailjetException {
        return apiClientService.visitorCodeSend(request);
    }

    @Override
    public CommonResponse<ClientsLoginResponse> visitorLogin(ClientLoginRequest request) throws MailjetException {
        return apiClientService.visitorLogin(request);
    }

}
