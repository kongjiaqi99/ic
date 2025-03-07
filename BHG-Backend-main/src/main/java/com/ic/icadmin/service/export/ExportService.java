package com.ic.icadmin.service.export;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import com.ic.icadmin.share.constants.FileConstant;
import com.ic.icadmin.share.utils.FileUtil;
import com.ic.icadmin.share.utils.HttpUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@Slf4j
@Service
public class ExportService {


    /**
     * 查询函数
     */
    public <T> void exportList(List<T> list, String fileName, HttpServletResponse response, Class clazz) throws
                                                                                                           IOException {
        //1.调用任务接口增加记录,

        //2.设置批次号,oss上传成功或失败,需再次发消息，更新状态
        String dir = "files";
        String path = dir + File.separator;
        File saveFile = new File(path);
        if (!saveFile.exists()){
            saveFile.mkdirs();
        }
        FileOutputStream output = null;
        addCommonResponseHeader(response, FileConstant.APPLICATION_OCTET_STREAM_STR);
        Boolean success = false;
        //3.excel 文件生成
        try {
            ExportParams exportParams = new ExportParams();
            exportParams.setType(ExcelType.XSSF);
            Workbook workbook = ExcelExportUtil.exportExcel(exportParams, clazz, list);
            output = new FileOutputStream(path + fileName);
            workbook.write(output);
            response.setHeader(FileConstant.CONTENT_DISPOSITION_STR, FileConstant.CONTENT_DISPOSITION_VALUE_PREFIX_STR + fileName);
            //关闭缓存
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
            success = true;
        } catch (Exception e) {
            log.error("文件导出异常", e);
        } finally {
            if (output != null) {
                try {
                    output.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        if (success){
            File f = new File(path, fileName);
            FileUtil.writeFileToStream(new FileInputStream(f), response.getOutputStream(), f.length());
            if (f.exists()){
                f.delete();
            }
//            return path+fileName;
        }
//        return "";
    }

    /**
     * 添加公用的响应头
     *
     * @param response
     * @param contentTypeValue
     */
    private void addCommonResponseHeader(HttpServletResponse response, String contentTypeValue) {
        response.reset();
        HttpUtil.addCorsResponseHeader(response);
        response.setHeader(FileConstant.CONTENT_TYPE_STR, contentTypeValue);
        response.setContentType(contentTypeValue);
    }
}
