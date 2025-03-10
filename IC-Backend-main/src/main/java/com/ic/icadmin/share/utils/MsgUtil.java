package com.ic.icadmin.share.utils;

import cn.hutool.json.JSONUtil;
import com.aliyun.auth.credentials.Credential;
import com.aliyun.auth.credentials.provider.StaticCredentialProvider;
import com.aliyun.sdk.service.dysmsapi20180501.AsyncClient;
import com.aliyun.sdk.service.dysmsapi20180501.models.BatchSendMessageToGlobeRequest;
import com.aliyun.sdk.service.dysmsapi20180501.models.BatchSendMessageToGlobeResponse;
import com.ic.icadmin.properties.StaticProperties;
import com.google.common.collect.Lists;
import com.google.gson.Gson;
import darabonba.core.client.ClientOverrideConfiguration;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.concurrent.CompletableFuture;

@Component
public class MsgUtil {

    @Resource
    StaticProperties properties;


    public void send(String to, String from, String message) throws Exception {


        // Configure Credentials authentication information, including ak, secret, token
        StaticCredentialProvider provider = StaticCredentialProvider.create(Credential.builder()
                // Please ensure that the environment variables ALIBABA_CLOUD_ACCESS_KEY_ID and ALIBABA_CLOUD_ACCESS_KEY_SECRET are set.
                .accessKeyId((properties.MSG_ACCESSKEY_ID))
                .accessKeySecret((properties.MSG_ACCESSKEY_SECRET))
                //.securityToken(System.getenv("ALIBABA_CLOUD_SECURITY_TOKEN")) // use STS token
                .build());

        // Configure the Client
        AsyncClient client = AsyncClient.builder()
                //.httpClient(httpClient) // Use the configured HttpClient, otherwise use the default HttpClient (Apache HttpClient)
                .credentialsProvider(provider)
                //.serviceConfiguration(Configuration.create()) // Service-level configuration
                // Client-level configuration rewrite, can set Endpoint, Http request parameters, etc.
                .overrideConfiguration(
                        ClientOverrideConfiguration.create()
                                // Endpoint 请参考 https://api.aliyun.com/product/Dysmsapi
                                .setEndpointOverride(properties.MSG_REGION)
                        //.setConnectTimeout(Duration.ofSeconds(30))
                )
                .build();

        // Parameter settings for API request
        BatchSendMessageToGlobeRequest batchSendMessageToGlobeRequest = BatchSendMessageToGlobeRequest.builder()
                .to(JSONUtil.toJsonStr(Lists.newArrayList(to)))
                .from(from)
                .message(JSONUtil.toJsonStr(Lists.newArrayList(message)))
                .build();
        // Asynchronously get the return value of the API request
        CompletableFuture<BatchSendMessageToGlobeResponse> response = client.batchSendMessageToGlobe(batchSendMessageToGlobeRequest);
        // Synchronously get the return value of the API request
        BatchSendMessageToGlobeResponse resp = response.get();
        System.out.println(new Gson().toJson(resp));
        // Asynchronous processing of return values
        // Finally, close the client
        client.close();
    }
}
