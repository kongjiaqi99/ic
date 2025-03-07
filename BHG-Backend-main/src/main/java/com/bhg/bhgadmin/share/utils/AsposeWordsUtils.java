package com.bhg.bhgadmin.share.utils;

import com.aspose.words.Document;
import com.aspose.words.License;
import com.aspose.words.SaveFormat;
import com.bhg.bhgadmin.share.constants.FileConstant;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

/**
 * @author PDX
 * @website https://blog.csdn.net/Gaowumao
 * @Date 2022-05-18 23:42
 * @Description Aspose 工具类
 */
public class AsposeWordsUtils {
    /**
     * Word转PDF操作
     *
     * @param doc        源文件
     * @param targetFile 目标文件
     */
    public static void doc2pdf(Document doc, String targetFile) {
        try {
            long old = System.currentTimeMillis();
            //新建一个空白pdf文档
            File file = new File(targetFile);
            FileOutputStream os = new FileOutputStream(file);
            //全面支持DOC, DOCX, OOXML, RTF HTML, OpenDocument, PDF, EPUB, XPS, SWF 相互转换
            doc.save(os, SaveFormat.PDF);
            os.close();
            long now = System.currentTimeMillis();
            //转化用时
            System.out.println("共耗时：" + ((now - old) / 1000.0) + "秒");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        InputStream is = Document.class
                .getResourceAsStream("/com.aspose.words.lic_2999.xml");
        License asposeLicense = new License();
        asposeLicense.setLicense(is);
        System.out.println("Aspose isLicensed: " + asposeLicense.isLicensed());

    }

    public static void doc2pdf(Document doc, String s, HttpServletResponse response) {
        response.reset();
        HttpUtil.addCorsResponseHeader(response);
        // 设置response的Header
        response.setCharacterEncoding("UTF-8");
        //Content-Disposition的作用：告知浏览器以何种方式显示响应返回的文件，用浏览器打开还是以附件的形式下载到本地保存
        //attachment表示以附件方式下载 inline表示在线打开 "Content-Disposition: inline; filename=文件名.mp3"
        // filename表示文件的默认名称，因为网络传输只支持URL编码的相关支付，因此需要将文件名URL编码后进行传输,前端收到后需要反编码才能获取到真正的名称
        try {
            response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(s, "UTF-8"));
            //关闭缓存
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
            response.setHeader(FileConstant.CONTENT_TYPE_STR, "application/octet-stream");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // 告知浏览器文件的大小

        //设置响应格式，已文件流的方式返回给前端。
        response.setContentType("application/octet-stream");
        //生成压缩文件
        ServletOutputStream os = null;
        try {
            os = response.getOutputStream();
            doc.save(os, SaveFormat.PDF);
//            response.addHeader("Content-Length", String.valueOf(999));
            os.flush();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
