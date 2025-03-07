package com.ic.icadmin.handler;

import com.alibaba.fastjson.JSON;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.share.error.AdminUserErrorEnum;
import com.ic.icadmin.share.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-16 13:28
 **/
@Component
public class AuthenticationEntryPointImpl implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        CommonResponse<Object> commonResponse = new CommonResponse<>();
        commonResponse.setSuccess(Boolean.FALSE);
        commonResponse.setErrorCode(String.valueOf(HttpStatus.UNAUTHORIZED.value()));
        commonResponse.setErrorMessage(StringUtils.isNotBlank(e.getLocalizedMessage()) ? e.getLocalizedMessage() :
                                           AdminUserErrorEnum.UNAUTHORIZED.getErrorMessage());
        String json = JSON.toJSONString(commonResponse);
        WebUtils.renderString(httpServletResponse, json);
    }
}
