package com.ic.icadmin.properties.email;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-24 11:16
 **/
@Data
@Component
@ConfigurationProperties(prefix = "passwordresetemail")
@RefreshScope
public class PasswordResetEmailProperties {

    private String subject;

    private String textPart;

    private String htmlPart;
}
