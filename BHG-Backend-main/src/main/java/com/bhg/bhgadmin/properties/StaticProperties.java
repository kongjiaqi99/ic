package com.bhg.bhgadmin.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-05-05 17:27
 **/
@Data
@Component
@ConfigurationProperties(prefix = "static-properties")
public class StaticProperties {

    public String tokenHead;

    public String MAILJET_API_KEY;

    public String MAILJET_SECRET_KEY;

    public String encryptKey;

    public String RECAPTCHA2_SITE_KEY;

    public String RECAPTCHA2_SECRET_KEY;

    public String clientDefaultPassword;

    public String trulioo_username;

    public String trulioo_password;

    public String MSG_ACCESSKEY_ID = "LTAI5tRF6kfEqXFnjiHtYhwE";

    public String MSG_ACCESSKEY_SECRET = "I5GCcwXjLwm4CNWcEq9loHogskJhMw";

    public String MSG_REGION = "dysmsapi.ap-southeast-1.aliyuncs.com";

}
