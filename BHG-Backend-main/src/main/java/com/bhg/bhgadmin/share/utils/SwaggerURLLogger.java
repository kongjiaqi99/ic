package com.bhg.bhgadmin.share.utils;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;

import java.net.InetAddress;
import java.net.UnknownHostException;

@Component
public class SwaggerURLLogger implements ApplicationListener<ApplicationReadyEvent> {

    @Override
    public void onApplicationEvent(@NonNull ApplicationReadyEvent event) {
        String port = event.getApplicationContext().getEnvironment().getProperty("server.port", "8080");
        String contextPath = event.getApplicationContext().getEnvironment().getProperty("server.servlet.context-path", "");
        String hostAddress = "localhost";

        try {
            hostAddress = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            // Handle exception, default to localhost
        }

        System.out.println("\n----------------------------------------------------------");
        System.out.println("Swagger UI available at: http://" + hostAddress + ":" + port + contextPath + "/doc.html");
        // System.out.println("Swagger UI available at: http://" + hostAddress + ":" + port + contextPath + "/swagger-ui.html");
        System.out.println("----------------------------------------------------------\n");
    }
    
}

