package com.ic.icadmin.handler;

import com.alibaba.fastjson.JSON;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.share.error.AdminUserErrorEnum;
import com.ic.icadmin.share.utils.WebUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
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
public class AccessDeniedHandlerImpl implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
        CommonResponse<Object> commonResponse = new CommonResponse<>();
        commonResponse.setSuccess(Boolean.FALSE);
        commonResponse.setErrorCode(String.valueOf(HttpStatus.METHOD_NOT_ALLOWED.value()));
//        commonResponse.setErrorMessage(StringUtils.isNotBlank(e.getLocalizedMessage()) ? e.getLocalizedMessage() : AdminUserErrorEnum.NO_PERMISSION.getErrorMessage());
        commonResponse.setErrorMessage(AdminUserErrorEnum.NO_PERMISSION.getErrorMessage());
        String json = JSON.toJSONString(commonResponse);
        WebUtils.renderString(httpServletResponse, json);
    }
}
