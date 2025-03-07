package com.ic.icadmin.config;
//package com.ic.icadmin.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import springfox.documentation.builders.ApiInfoBuilder;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.service.Contact;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger2.annotations.EnableSwagger2WebMvc;
//
///**
// * *
// *
// * @author auto_generator
// * @date 2019/7/23
// */
//@Configuration
//@EnableSwagger2WebMvc
//public class Knife4jConfig {
//
//    /**
//     * 定义分隔符
//     */
//    private static final String splitor = ";";
//
//    // 创建Docket存入容器，Docket代表一个接口文档
//    @Bean
//    public Docket webApiConfig(){
//        return new Docket(DocumentationType.SWAGGER_2)
//            .groupName("ic-admin")
//            // 创建接口文档的具体信息
//            .apiInfo(apiInfo())
//            // 创建选择器，控制哪些接口被加入文档
//            .select()
//            // 指定@ApiOperation标注的接口被加入文档
//            .apis(RequestHandlerSelectors.basePackage("com.ic.icadmin.controller"))
//            .paths(PathSelectors.any())
//            .build();
//    }
//
//    // 对外client官网接口
//    @Bean
//    public Docket webApiConfigApi(){
//        return new Docket(DocumentationType.SWAGGER_2)
//            .groupName("Client-Api")
//            // 创建接口文档的具体信息
//            .apiInfo(apiInfo())
//            // 创建选择器，控制哪些接口被加入文档
//            .select()
//            // 指定@ApiOperation标注的接口被加入文档
//            .apis(RequestHandlerSelectors.basePackage("com.ic.icadmin.api"))
//            .paths(PathSelectors.any())
//            .build();
//    }
//
//
//    private ApiInfo apiInfo() {
//        return new ApiInfoBuilder()
//            .title("ic-admin")
//            .description("ic-admin API调试文档")
//            .contact(
//                new Contact("jason wu", "", "")
//            )
//            .version("v1.0")
//            .build();
//    }
//}
//
