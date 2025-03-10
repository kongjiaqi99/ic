package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.*;
import com.ic.icadmin.api.dto.response.ClientsLoginResponse;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.client.ClientCreateRequest;
import com.ic.icadmin.dto.request.client.ClientEditRequest;
import com.ic.icadmin.dto.request.client.ClientPushIdRequest;
import com.ic.icadmin.dto.request.client.ShareAppRequest;
import com.mailjet.client.errors.MailjetException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@RequestMapping(path = "api/v1")
@Api(tags = "API-clients")
public interface IClients {

    @PostMapping("/login")
    @ApiOperation(value = "Client-Login", notes = "client-Login")
    CommonResponse<ClientsLoginResponse> clientLogin(@RequestBody @Validated
                                                         ClientLoginRequest request, HttpServletRequest servletRequest);

    @PostMapping("/logout")
    @ApiOperation(value = "Client-Logout", notes = "Client-Logout")
    CommonResponse<String> clientLogout();

    @PostMapping("/resetPasswordCodeSend")
    @ApiOperation(value = "Reset Password Code Send", notes = "resetPasswordCodeSend")
    CommonResponse<String> resetPasswordCodeSend(@RequestBody @Validated ResetPasswordCodeSendRequest request) throws
                                                                                                               MailjetException;
    @PostMapping("/resetPasswordCodeMsgSend")
    @ApiOperation(value = "Reset Password Code Send", notes = "resetPasswordCodeSend")
    CommonResponse<String> resetPasswordCodeMsgSend(@RequestBody @Validated ResetPasswordCodeSendRequest request) throws
            MailjetException;

    @PostMapping("/resetPassword")
    @ApiOperation(value = "Reset Password", notes = "resetPassword")
    CommonResponse<String> resetPassword(@RequestBody @Validated ResetPasswordRequest request);

    @PostMapping("/editPassword")
    @ApiOperation(value = "edit Password", notes = "editPassword")
    CommonResponse<String> editPassword(@RequestBody @Validated EditPasswordRequest request);

    @PostMapping("/editClient")
    @ApiOperation(value = "editClient", notes = "editClient")
    CommonResponse<Long> editClient(@RequestBody @Validated ClientEditRequest request);

    @PostMapping("/shareApp")
    @ApiOperation(value = "shareApp", notes = "editClient")
    CommonResponse<Long> shareApp(@RequestBody @Validated ShareAppRequest numRequest, HttpServletRequest request) throws Exception;

    @PostMapping("/editPushClientId")
    @ApiOperation(value = "editPushClientId", notes = "editPushClientId")
    CommonResponse<Long> editPushClientId(@RequestBody @Validated ClientPushIdRequest request);

    @PostMapping("/registerCodeSend")
    @ApiOperation(value = "register Code Send", notes = "registerCodeSend")
    CommonResponse<String> registerCodeSend(@RequestBody @Validated ResetPasswordCodeSendRequest request) throws
            MailjetException;

    @PostMapping("/registerClient")
    @ApiOperation(value = "register Client", notes = "registerClient")
    CommonResponse<Long> createClient(@RequestBody @Validated ClientCreateRequest request);

    @PostMapping("/logoff")
    @ApiOperation(value = "Client-Logoff", notes = "Client-Logoff")
    CommonResponse<String> clientLogoff();

    @PostMapping("/isLogoff")
    @ApiOperation(value = "is-Logoff", notes = "Is-Logoff")
    CommonResponse<Boolean> isLogoff();

    @PostMapping("/isRegister")
    @ApiOperation(value = "is-Register", notes = "Is-Register")
    CommonResponse<Boolean> isRegister();

    @PostMapping("/setPin")
    @ApiOperation(value = "set Pin", notes = "setPin")
    CommonResponse<String> setPin(@RequestBody @Validated PinRequest request);

    @PostMapping("/editPin")
    @ApiOperation(value = "edit Pin", notes = "editPin")
    CommonResponse<String> editPin(@RequestBody @Validated EditPinRequest request);

    @PostMapping("/resetPin")
    @ApiOperation(value = "edit Pin", notes = "editPin")
    CommonResponse<String> resetPin(@RequestBody @Validated EditPinRequest request);

    @PostMapping("/resetPinCodeSend")
    @ApiOperation(value = "reset Pin Send", notes = "registerCodeSend")
    CommonResponse<String> resetPinCodeSend() throws
            MailjetException;

    @PostMapping("/resetPinMsgSend")
    @ApiOperation(value = "Reset Pin Code Send", notes = "resetPasswordCodeSend")
    CommonResponse<String> resetPinMsgSend() throws
            MailjetException;

    @PostMapping("/checkPin")
    @ApiOperation(value = "check Pin", notes = "checkPin")
    CommonResponse<String> checkPin(@RequestBody @Validated PinRequest request);

    @PostMapping("/visitorCodeSend")
    @ApiOperation(value = "visitor Code Send", notes = "visitorCodeSend")
    CommonResponse<String> visitorCodeSend(@RequestBody @Validated ResetPasswordCodeSendRequest request) throws
            MailjetException;

    @PostMapping("/visitorLogin")
    @ApiOperation(value = "visitor Login", notes = "visitor Login")
    CommonResponse<ClientsLoginResponse> visitorLogin(@RequestBody @Validated ClientLoginRequest request) throws
            MailjetException;
}
