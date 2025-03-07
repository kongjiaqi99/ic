package com.bhg.bhgadmin.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 存储处理器顶级接口
 */
public interface IStorageProcessor {

    /**
     * 生成上传oss后的文件名
     * @param originFileName
     * @return
     */
    String generateUploadFileName(String originFileName);

    /**
     * 获取oss文件位置（不含文件名）
     * @param module
     * @param fileType
     * @param moduleId
     * @return
     */
    String getFilePathWithoutFileName(String module, String fileType, String moduleId);
    /**
     * 文件存储
     *
     * @param inputStream 文件输入流
     * @param name        文件原名
     *
     * @return 文件存储路径
     *
     * @throws IOException
     */
    String store(InputStream inputStream, String module, String fileType, String moduleId, String name) throws IOException;

    /**
     * 文件分片存储
     *
     * @param inputStream 文件输入流
     * @param md5         文件唯一标识
     * @param chunks      分片总数
     * @param chunk       当前分片下标 从0开始
     * @param size        文件总大小
     * @param chunkSize   分片文件大小
     * @param name        文件名称
     *
     * @return null 代表未传完 有值代表已经传输完毕
     *
     * @throws IOException
     */
//    String storeWithChunk(InputStream inputStream, String md5, Integer chunks, Integer chunk, Long size, Long chunkSize, String name) throws IOException;

    /**
     * 读取文件进输出流
     *
     * @param filePath     文件路径
     * @param outputStream 输出流
     *
     * @throws IOException
     */
//    void read2OutputStream(String filePath, OutputStream outputStream) throws IOException;

    /**
     * 删除文件
     *
     * @param filePath 文件路径
     *
     * @throws IOException
     */
    void delete(String filePath) throws IOException;
}
