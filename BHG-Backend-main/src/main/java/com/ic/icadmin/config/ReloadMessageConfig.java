package com.ic.icadmin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import java.util.Locale;

//security提示信息语言配置类
@Configuration
public class ReloadMessageConfig {
    @Bean //加载中文认证提示信息
    public ReloadableResourceBundleMessageSource messageSource(){
//        Locale.setDefault(Locale.ENGLISH);
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        //加载org/springframework/security包下的中文提示信息 配置文件
        messageSource.setBasename("classpath:messages_en");
        return messageSource;
    }
}