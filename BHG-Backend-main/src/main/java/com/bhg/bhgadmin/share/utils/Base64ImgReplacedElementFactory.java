package com.bhg.bhgadmin.share.utils;

import cn.hutool.core.codec.Base64Encoder;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.codec.Base64;
import org.springframework.util.StringUtils;
import org.w3c.dom.Element;
import org.xhtmlrenderer.extend.FSImage;
import org.xhtmlrenderer.extend.ReplacedElement;
import org.xhtmlrenderer.extend.ReplacedElementFactory;
import org.xhtmlrenderer.extend.UserAgentCallback;
import org.xhtmlrenderer.layout.LayoutContext;
import org.xhtmlrenderer.pdf.ITextFSImage;
import org.xhtmlrenderer.pdf.ITextImageElement;
import org.xhtmlrenderer.render.BlockBox;
import org.xhtmlrenderer.simple.extend.FormSubmissionListener;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *  * 图片base64支持，把图片转换为itext自己的图片对象
 *  * @author Administrator
 *  *
 *  
 */
public class Base64ImgReplacedElementFactory implements ReplacedElementFactory {

    /**
     * 实现createReplacedElement 替换html中的Img标签
     *
     * @param c         上下文
     * @param box       盒子
     * @param uac       回调
     * @param cssWidth  css宽
     * @param cssHeight css高
     * @return ReplacedElement
     */
    @Override
    public ReplacedElement createReplacedElement(LayoutContext c, BlockBox box, UserAgentCallback uac,
                                                 int cssWidth, int cssHeight) {
        Element e = box.getElement();
        if (e == null) {
            return null;
        }
        String nodeName = e.getNodeName();
        // 找到img标签
        if (nodeName.equals("img")) {
            String attribute = e.getAttribute("src");
            FSImage fsImage;
            try {
                // 生成itext图像
                fsImage = buildImage(attribute, uac);
            } catch (BadElementException e1) {
                fsImage = null;
            } catch (IOException e1) {
                fsImage = null;
            }
            if (fsImage != null) {
                // 对图像进行缩放
                if (cssWidth != -1 || cssHeight != -1) {
                    fsImage.scale(cssWidth, cssHeight);
                }
                return new ITextImageElement(fsImage);
            }
        }

        return null;
    }

    /**
     * 将base64编码解码并生成itext图像
     *
     * @param srcAttr 属性
     * @param uac     回调
     * @return FSImage
     * @throws IOException         io异常
     * @throws BadElementException BadElementException
     */
    protected FSImage buildImage(String srcAttr, UserAgentCallback uac) throws IOException,
            BadElementException {
        FSImage fsImage;
        if (srcAttr.startsWith("data:image/")) {
            String b64encoded = srcAttr.substring(srcAttr.indexOf("base64,") + "base64,".length(),
                    srcAttr.length());
            // 解码
            byte[] decodedBytes = Base64.decode(b64encoded);
            fsImage = new ITextFSImage(Image.getInstance(decodedBytes));
        } else {
            fsImage = uac.getImageResource(srcAttr).getImage();
        }
        return fsImage;
    }


    /**
     * 实现remove
     *
     * @param e 元素
     */
    @Override
    public void remove(Element e) {
    }

    /**
     * 实现reset
     */
    @Override
    public void reset() {
    }

    /**
     * 实现setFormSubmissionListener
     *
     * @param formsubmissionlistener 监听
     */
    @Override
    public void setFormSubmissionListener(FormSubmissionListener formsubmissionlistener) {
    }

    public String getBase64(String url) {
        if (!StringUtils.hasText(url)){
            return null;
        }
        InputStream in = null;
        final ByteArrayOutputStream data = new ByteArrayOutputStream();
        //读取图片字节数组
        try {
            URL convertedUrl = new URL(url);
            final byte[] by = new byte[1024];
            // 创建链接获取图片
            final HttpURLConnection conn = (HttpURLConnection) convertedUrl.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            in = conn.getInputStream();
            int len = -1;
            while ((len = in.read(by)) != -1) {
                data.write(by, 0, len);
            }
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //对字节数组Base64编码
        Base64Encoder encoder = new Base64Encoder();
        //返回Base64编码过的字节数组字符串
        String encode = encoder.encode(data.toByteArray());
        encode = encode.replaceAll("[\\s*\t\n\r]", "");
        return encode;
    }
}
