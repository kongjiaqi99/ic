package com.ic.icadmin.share.utils;

import cn.hutool.core.text.StrBuilder;
import com.ic.icadmin.share.enums.EnvironmentTypeEnum;
import com.lowagie.text.DocumentException;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.CharEncoding;
import org.springframework.core.io.ClassPathResource;
import org.xhtmlrenderer.layout.SharedContext;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.Map;

/**
 * Html生成PDF文件
 */
@Slf4j
public class HtmlToPDFUtils {

    /**
     * 黑体
     */
    private static final String SIMHEI = "fonts/simhei.ttf";
    /**
     * 楷体
     */
    private static final String SIMKAI = "fonts/simkai.ttf";
    /**
     * 隶书
     */
    private static final String SIMLI = "fonts/SIMLI.TTF";
    /**
     * 宋体
     */
    private static final String SIMSUN = "fonts/simsun.ttc";
    //原始模版位置
    private final static String TEMPLATE_HTML_PATH = "templates/unitCertificate";
    //渲染数据后html的位置
    private final static String HTML_TEMP_PATH = "files/unitCertificate";


    /**
     * 1.用ClassPathResource的inputStream方法，获取初始html模板（因为jar包无法直接获取templates/unitCertificate下模板）
     * 2.渲染第一步生成的HTML模板，生成渲染后的html到htmlTempPath，即 files/unitCertificate/
     * 3.将第二步渲染后的html生成pdf
     * @param params     传递到模板的参数
     * @param oriTemplateHtmlName 原始模版文件名
     * @param targetFile 目标文件的地址
     */
    public static String createPdfFile(Map<String, Object> params, String oriTemplateHtmlName, String targetFile) {
        for (Map.Entry<String, Object> entry : params.entrySet()){
            entry.setValue(covertXML(entry.getValue().toString()));
        }
        Template template = null;
        String renderResult = "";
        //创建fm的配置
        Configuration config = new Configuration();
        //指定默认编码格式
        config.setDefaultEncoding(CharEncoding.UTF_8);
        // jar包无法直接获取templates/unitCertificate下模板，所以用ClassPathResource获取inputStream方法转一下
        InputStream templateInputStream = null;
        File templateTransferedHtmlFile = null;
        try {
            //按照oriTemplateHtmlPath generate InputStream类型的流
            templateInputStream =
                new ClassPathResource(StrBuilder.create(TEMPLATE_HTML_PATH).append(FileUtil.SLASH).append(oriTemplateHtmlName).toString()).getInputStream();
            //用ClassPathResource的inputStream方法，把html模板放到files/unitCertificate/目录下
            templateTransferedHtmlFile =
                new File(StrBuilder.create(HTML_TEMP_PATH).append(FileUtil.SLASH).append(oriTemplateHtmlName).toString());
            if (!templateTransferedHtmlFile.getParentFile().exists()){
                templateTransferedHtmlFile.getParentFile().mkdirs();
            }
            FileUtil.writeStreamToFile(templateInputStream, new FileOutputStream(templateTransferedHtmlFile), (long) templateInputStream.available());
//            copyInputStreamToFile(templateInputStream, templateTransferedHtmlFile);
            config.setDirectoryForTemplateLoading(templateTransferedHtmlFile.getParentFile());
            template = config.getTemplate(oriTemplateHtmlName, CharEncoding.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String outTempHtmlFilePath =
            StrBuilder.create(HTML_TEMP_PATH).append(FileUtil.SLASH).append(LocalDate.now()).append(FileUtil.SLASH).append(System.currentTimeMillis()).append(".html").toString();
        File writeFile = new File(outTempHtmlFilePath);
        File fileParent = writeFile.getParentFile();
        if (!fileParent.exists()) {
            fileParent.mkdirs();
        }
        try {
            writeFile.createNewFile();
            Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writeFile), CharEncoding.UTF_8));
            template.process(params, writer);
            FileInputStream inputStream = new FileInputStream(outTempHtmlFilePath);
            int length = inputStream.available();
            byte bytes[] = new byte[length];
            inputStream.read(bytes);
            inputStream.close();
            renderResult = new String(bytes, StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
        try {
            createPdf(renderResult, targetFile);
            // delete ori template HTML
            if (templateTransferedHtmlFile.exists()){
                templateTransferedHtmlFile.delete();
            }
            // delete temp html
            if (writeFile.exists()) {
                writeFile.delete();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return outTempHtmlFilePath;
    }

    public static void createPdf(String content, String dest) throws IOException, com.lowagie.text.DocumentException {
        if (!EnvironmentTypeEnum.PROD.getMessage().equals(SpringUtils.getActiveProfile())) {
            log.info("createPdf----------environment:{}------", SpringUtils.getActiveProfile());
            log.info("-----------------------content-----------------------");
            log.info(content);
            log.info("-----------------------content-----------------------");
        }
        ITextRenderer renderer = new ITextRenderer();
        SharedContext sharedContext = renderer.getSharedContext();
        // 解决base64图片支持问题
        sharedContext.setReplacedElementFactory(new Base64ImgReplacedElementFactory());
        sharedContext.getTextRenderer().setSmoothingThreshold(0);

        //        ITextFontResolver fontResolver = renderer.getFontResolver();
        //        fontResolver.addFont(SIMHEI, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        //        fontResolver.addFont(SIMLI, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        //        fontResolver.addFont(SIMKAI, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        //        fontResolver.addFont(SIMSUN, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        // 解析html生成pdf
        renderer.setDocumentFromString(content);
        //解决图片相对路径的问题
        renderer.layout();
        renderer.createPDF(new FileOutputStream(dest));
    }

    /**
     * 将字符串中的XML特殊字符转义
     * & -> &amp;
     * < -> &lt;
     * > -> &gt;
     * " -> &quot;
     * ' -> &apos;
     * **/
    public static String covertXML(String content) {
        char[] originContentChars = content.toCharArray();
        int finalContentCharLength = 0;//转义后字符串长度
        for (char contentChar : originContentChars) {
            switch (contentChar) {
                case '&':
                    finalContentCharLength = finalContentCharLength + 5;
                    continue;
                case '"':
                case '\'':
                    finalContentCharLength = finalContentCharLength + 6;
                    continue;
                case '<':
                case '>':
                    finalContentCharLength = finalContentCharLength + 4;
                    continue;
                default:
                    finalContentCharLength = finalContentCharLength + 1;
            }

        }
        char[] newContentChars = new char[finalContentCharLength];
        int newContentCharsPos = 0;
        for (char originContentChar : originContentChars) {
            switch (originContentChar) {
                case '&':
                    //& -> &amp;
                    newContentChars[newContentCharsPos] = '&';
                    newContentChars[newContentCharsPos + 1] = 'a';
                    newContentChars[newContentCharsPos + 2] = 'm';
                    newContentChars[newContentCharsPos + 3] = 'p';
                    newContentChars[newContentCharsPos + 4] = ';';
                    newContentCharsPos += 5;
                    continue;
                case '"':
                    //" -> &quot;
                    newContentChars[newContentCharsPos] = '&';
                    newContentChars[newContentCharsPos + 1] = 'q';
                    newContentChars[newContentCharsPos + 2] = 'u';
                    newContentChars[newContentCharsPos + 3] = 'o';
                    newContentChars[newContentCharsPos + 4] = 't';
                    newContentChars[newContentCharsPos + 5] = ';';
                    newContentCharsPos += 6;
                    continue;
                case '\'':
                    //' -> &apos;
                    newContentChars[newContentCharsPos] = '&';
                    newContentChars[newContentCharsPos + 1] = 'a';
                    newContentChars[newContentCharsPos + 2] = 'p';
                    newContentChars[newContentCharsPos + 3] = 'o';
                    newContentChars[newContentCharsPos + 4] = 's';
                    newContentChars[newContentCharsPos + 5] = ';';
                    newContentCharsPos += 6;
                    continue;
                case '<':
                    //< -> &lt;
                    newContentChars[newContentCharsPos] = '&';
                    newContentChars[newContentCharsPos + 1] = 'l';
                    newContentChars[newContentCharsPos + 2] = 't';
                    newContentChars[newContentCharsPos + 3] = ';';
                    newContentCharsPos += 4;
                    continue;
                case '>':
                    //> -> &gt;
                    newContentChars[newContentCharsPos] = '&';
                    newContentChars[newContentCharsPos + 1] = 'g';
                    newContentChars[newContentCharsPos + 2] = 't';
                    newContentChars[newContentCharsPos + 3] = ';';
                    newContentCharsPos += 4;
                    continue;
                default:
                    newContentChars[newContentCharsPos] = originContentChar;
                    newContentCharsPos++;
            }
        }
        return new String(newContentChars);
    }

    // InputStream -> File (deprecated, use FileUtil now)
    private static void copyInputStreamToFile(InputStream inputStream, File file) throws IOException {

        try (FileOutputStream outputStream = new FileOutputStream(file)) {

            int read;
            byte[] bytes = new byte[1024];

            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }

            // commons-io
            //IOUtils.copy(inputStream, outputStream);
        }
    }
}

