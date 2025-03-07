package com.bhg.bhgadmin;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSONObject;
import com.bhg.bhgadmin.dto.biz.BizMailReceiverDTO;
import com.bhg.bhgadmin.dto.biz.BizMailjetSenderDTO;
import com.bhg.bhgadmin.share.utils.MailjetUtil;
import com.bhg.bhgadmin.share.utils.MyHttpUtil;
import com.mailjet.client.errors.MailjetException;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.tomcat.util.descriptor.web.SecurityCollection;
import org.apache.tomcat.util.descriptor.web.SecurityConstraint;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.freemarker.FreeMarkerAutoConfiguration;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@SpringBootApplication(exclude = { FreeMarkerAutoConfiguration.class })
@MapperScan(basePackages = "com.bhg.bhgadmin.mapper")
//@ServletComponentScan(basePackages = "com.bhg.bhgadmin.filter.CorsFilter")
public class BhgAdminApplication {

    public static void main(String[] args) throws InterruptedException{
        SpringApplication.run(BhgAdminApplication.class, args);
    }
//
//    @Bean
//    //配置http某个端口自动跳转https
//    public TomcatServletWebServerFactory servletContainer() {
//
//        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory() {
//
//            @Override
//            protected void postProcessContext(Context context) {
//                SecurityConstraint securityConstraint = new SecurityConstraint();
//                securityConstraint.setUserConstraint("CONFIDENTIAL");
//                SecurityCollection collection = new SecurityCollection();
//                collection.addPattern("/*");
//                securityConstraint.addCollection(collection);
//                context.addConstraint(securityConstraint);
//            }
//        };
//        tomcat.addAdditionalTomcatConnectors(initiateHttpConnector());
//        return tomcat;
//    }
//
//    private Connector initiateHttpConnector() {
//        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
//        connector.setScheme("http");
//        //监听的http端口
//        connector.setPort(18082);
//        connector.setSecure(false);
//        //跳转的https端口
//        connector.setRedirectPort(18081);
//        return connector;
//    }

    private static void queryLaifushi() throws InterruptedException {
        Map<String, Object> parm = new HashMap<>();
        //        parm.put("Cookie", "JSESSIONID=A9B21788E615C13F03B38F1B9AD0CF0E");
        while (true){
            String dateArray[] = {"02","03","04","05","06","07","08","09","10","11","12","13"};
            for (String date : dateArray) {
                String jsonString = sendGet(parm, date);
                JSONObject r = JSONObject.parseObject(jsonString);
                if (ObjectUtil.isNull(r)){
                    for (int num =0; num <= 5; num++){
                        r = JSONObject.parseObject(sendGet(parm, date));
                        Thread.sleep(1000*5);
                    }
                    log.error("======2022-12-{}数据查询为空======",date);
                }
                if (r.get("code").equals(200)) {
                    List<Object> data1 = (List<Object>) r.get("data");
                    data1.forEach(d -> {
                        if ((Integer) JSONObject.parseObject(d.toString()).get("seat") > 0) {
                            try {
                                log.info("====12-{}号 {}余位：{}", date, JSONObject.parseObject(d.toString()).get("startTime").toString()+
                                             "~"+JSONObject.parseObject(d.toString()).get("endTime"), JSONObject.parseObject(d.toString()).get("seat"));
                                sendEmail(date, JSONObject.parseObject(d.toString()).get("startTime").toString()+
                                    "~"+JSONObject.parseObject(d.toString()).get("endTime"),
                                          JSONObject.parseObject(d.toString()).get("seat").toString());
                            } catch (MailjetException e) {
                                log.error("=====莱佛士有位邮件发送失败====");
                                e.printStackTrace();
                            }
                        }
                    });
                    log.info("=====2022-12-{}号查询成功====",date);
                } else {
                    try {
                        log.error("=====莱佛士体检中心Get请求失败====");
                        sendFailEmail();
                    } catch (MailjetException e) {
                        e.printStackTrace();
                    }
                }
                Thread.sleep(1000*2);
            }
            Thread.sleep(1000*60*3);
        }
    }

    private static String sendGet(Map<String, Object> parm, String date) {
        return MyHttpUtil.sendGet("https://pd.wx-xcx.com/wx/period/listByNational/1/2022-12-" + date, parm, "UTF-8");
    }

    static void sendEmail(String date, String time, String seat) throws MailjetException {
        // generate Email
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY("5cdfc1c60bc044568b2988b0982fc01c");
        mailjetSenderDTO.setMAILJET_SECRET_KEY("9ecbec77676c14091537e37923cfd8a8");
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
            new BizMailReceiverDTO("jason_wtx@hotmail.com", "Jason Wu"),
            new BizMailReceiverDTO("993318409@qq.com", "Kiko Wu"));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject("莱佛士体检中心有位了");
        mailjetSenderDTO.setTextPart("2022-12-"+date+" ，"+time+" ,余位:"+seat);

        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        mailjetUtil.sendMail(mailjetUtil);
    }

    static void sendFailEmail() throws MailjetException {
        // generate Email
        BizMailjetSenderDTO mailjetSenderDTO = new BizMailjetSenderDTO();
        mailjetSenderDTO.setMAILJET_API_KEY("5cdfc1c60bc044568b2988b0982fc01c");
        mailjetSenderDTO.setMAILJET_SECRET_KEY("9ecbec77676c14091537e37923cfd8a8");
        List<BizMailReceiverDTO> bizMailReceiverDTOS = Arrays.asList(
            new BizMailReceiverDTO("jason_wtx@hotmail.com", "Jason Wu"));
        mailjetSenderDTO.setReceivers(bizMailReceiverDTOS);
        mailjetSenderDTO.setSubject("莱佛士体检中心Get请求失败");
        mailjetSenderDTO.setTextPart("莱佛士体检中心Get请求失败");

        MailjetUtil mailjetUtil = new MailjetUtil(mailjetSenderDTO);
        mailjetUtil.sendMail(mailjetUtil);
    }

}
