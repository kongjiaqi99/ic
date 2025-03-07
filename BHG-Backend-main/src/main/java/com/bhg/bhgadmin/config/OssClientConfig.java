package com.bhg.bhgadmin.config;

import com.aliyun.oss.OSSClient;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;

import java.io.Serializable;
import java.util.Objects;

@Data
@SpringBootConfiguration
@ConfigurationProperties(prefix = "static-properties.oss")
public class OssClientConfig implements Serializable {
    private static final long serialVersionUID = -5370228155207535548L;

    private String endpoint;
    private String accessKeyId;
    private String accessKeySecret;
    private String bucketName;

    @Bean(value = "ossClient")
    public OSSClient ossClient() {
        if (StringUtils.isAnyBlank(endpoint, accessKeyId, accessKeySecret, bucketName)) {
            throw new RuntimeException("the oss config is missed!");
        }
        return new OSSClient(endpoint, accessKeyId, accessKeySecret);
    }

    public OssClientConfig() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        OssClientConfig that = (OssClientConfig) o;
        return Objects.equals(endpoint, that.endpoint) &&
                Objects.equals(accessKeyId, that.accessKeyId) &&
                Objects.equals(accessKeySecret, that.accessKeySecret) &&
                Objects.equals(bucketName, that.bucketName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(endpoint, accessKeyId, accessKeySecret, bucketName);
    }

    @Override
    public String toString() {
        return "OssClientConfig{" +
                "endpoint='" + endpoint + '\'' +
                ", accessKeyId='" + accessKeyId + '\'' +
                ", accessKeySecret='" + accessKeySecret + '\'' +
                ", bucketName='" + bucketName + '\'' +
                '}';
    }

}
