package com.ic.icadmin.service.impl;

import cn.hutool.core.util.IdUtil;
import com.aliyun.oss.OSSClient;
import com.ic.icadmin.config.OssClientConfig;
import com.ic.icadmin.service.IStorageProcessor;
import com.ic.icadmin.share.enums.EnvironmentTypeEnum;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.SpringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-12-01 19:54
 **/
@Slf4j
@Service
public class StorageProcessorImpl implements IStorageProcessor {

    private static final String SLASH = "/";

    @Autowired
    @Qualifier(value = "ossClient")
    private OSSClient ossClient;

    @Autowired
    private OssClientConfig ossClientConfig;


    @Override
    public String generateUploadFileName(String originFileName) {
        return new StringBuffer(IdUtil.getSnowflakeNextIdStr()).append(
            FileUtil.getFileSuffix(originFileName)).toString();
    }

    @Override
    public String getFilePathWithoutFileName(String module, String fileType, String moduleId) {
        if (EnvironmentTypeEnum.PROD.getMessage().equals(SpringUtils.getActiveProfile())) {
            //     https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/event/main_img/30/142f453c8b620a50c5e9a1d452b9e2e6.png
            return new StringBuffer("uploads").append(SLASH).append(module).append(SLASH).append(fileType).append(SLASH).append(moduleId).append(SLASH).toString();
        } else {
            //    https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/test/uploads/event/main_img/4/e4d39af5f38fd129e4aa90e51b423dfd.jpg
            return new StringBuffer("test/uploads").append(SLASH).append(module).append(SLASH).append(fileType).append(SLASH).append(moduleId).append(SLASH).toString();
        }
    }

    @Override
    public String store(InputStream inputStream, String module, String fileType, String moduleId, String fileName) throws IOException {
        checkBucket();
        String filePath = getFilePath(module, fileType, moduleId, fileName);
        log.info("store====filePath:{}", filePath);
        ossClient.putObject(ossClientConfig.getBucketName(), filePath, inputStream);
        return filePath;
    }

    @Override
    public void delete(String filePath) throws IOException {
        ossClient.deleteObject(ossClientConfig.getBucketName(), filePath);
    }

//    ----------------------------------------------------------------------------

    /**
     * 校验并根据需要创建bucket
     */
    private void checkBucket() {
        boolean bucketExist = ossClient.doesBucketExist(ossClientConfig.getBucketName());
        if (!bucketExist) {
            ossClient.createBucket(ossClientConfig.getBucketName());
        }
    }

    /**
     * 生成文件存储路径
     *
     * @param fileName
     * @return
     */
    private String getFilePath(String module, String fileType, String moduleId,String fileName) {
        if (EnvironmentTypeEnum.PROD.getMessage().equals(SpringUtils.getActiveProfile())) {
//            https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/event/main_img/30/142f453c8b620a50c5e9a1d452b9e2e6.png
            return new StringBuffer("uploads").append(SLASH).append(module).append(SLASH).append(fileType).append(SLASH).append(moduleId).append(SLASH).append(fileName).toString();
        } else {
            https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/test/uploads/event/main_img/4/e4d39af5f38fd129e4aa90e51b423dfd.jpg
            return new StringBuffer("test/uploads").append(SLASH).append(module).append(SLASH).append(fileType).append(SLASH).append(moduleId).append(SLASH).append(fileName).toString();
        }
    }
}
