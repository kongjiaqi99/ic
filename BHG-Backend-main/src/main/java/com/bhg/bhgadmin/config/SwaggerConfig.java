package com.bhg.bhgadmin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * <Description> <br>
 *
 * @author luoluocaihong<br>
 * @version 1.0<br>
 * @taskId <br>
 * @CreateDate Oct 24, 2016 <br>
 * @since V8.1<br>
 */
@Configuration
// @EnableOpenApi
@EnableSwagger2
public class SwaggerConfig {
    /**
     *
     * Description: <br>
     *
     * @author luoluocaihong<br>
     * @taskId <br>
     * @return <br>
     */
    ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("BHG backend APIs")
                .description("")
                .license("")
                .licenseUrl("")
                .termsOfServiceUrl("")
                .version("1.0.0")
                .build();
    }

    /**
     *
     * Description: <br>
     *
     * @author luoluocaihong<br>
     * @taskId <br>
     * @return <br>
     */
    @Bean
    public Docket customImplementation() {
        return new Docket(DocumentationType.SWAGGER_2).groupName("Bhg-admin")
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.bhg.bhgadmin.controller"))
                .build()
                .directModelSubstitute(org.joda.time.LocalDate.class, java.sql.Date.class)
                .directModelSubstitute(org.joda.time.DateTime.class, java.util.Date.class)
                .apiInfo(apiInfo());
    }

    @Bean
    public Docket customImplementationApi() {
        return new Docket(DocumentationType.SWAGGER_2).groupName("Client-Api")
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.bhg.bhgadmin.api"))
                .build()
                .directModelSubstitute(org.joda.time.LocalDate.class, java.sql.Date.class)
                .directModelSubstitute(org.joda.time.DateTime.class, java.util.Date.class)
                .apiInfo(apiInfo());
    }
    
    // @Bean
    // public OpenAPI customOpenAPI() {
    //     return new OpenAPI()
    //         .info(new Info()
    //             .title("Tag API")
    //             .version("1.0")
    //             .description("API for handling referral operations"));
    // }

}