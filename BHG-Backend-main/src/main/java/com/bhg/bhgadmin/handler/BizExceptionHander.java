package com.bhg.bhgadmin.handler;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.share.exception.CommonException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@ControllerAdvice
public class BizExceptionHander {
 
    @ResponseBody
    @ExceptionHandler(CommonException.class)  //该类为自定义异常类
    public CommonResponse orterExceptionHander(CommonException commonException){
        log.error("=====发生自定义异常原因：{}",commonException.getMessage());
        return CommonResponse.error(commonException.getErrorCode(), commonException.getErrorMessage());
    }
}