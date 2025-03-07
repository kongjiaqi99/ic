package com.bhg.bhgadmin.config;

import com.bhg.bhgadmin.filter.JwtAuthenticationTokenFilter;
import com.bhg.bhgadmin.handler.AccessDeniedHandlerImpl;
import com.bhg.bhgadmin.handler.AuthenticationEntryPointImpl;
import com.bhg.bhgadmin.service.impl.UserDetailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private AuthenticationConfiguration authenticationConfiguration;

    @Autowired
    private JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter;

    @Autowired
    private AuthenticationEntryPointImpl authenticationEntryPoint;

    @Autowired
    private AccessDeniedHandlerImpl accessDeniedHandler;

    @Autowired
    private UserDetailServiceImpl userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                //前后端分离的项目需要关闭csrf
                .csrf().disable()
                //不通过Session获取SecurityContext
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(HttpMethod.GET, // 允许对于网站静态资源的无授权访问
                        "/",
                        "/*.html",
                        "/favicon.ico",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js",
                        "/swagger-resources/**",
                        "/v2/api-docs/**",
                        "/**/**/exportXml",
                        "/**/**/exportPdf",
                        "/**/**/exportJson",
                        "/api/v1/info/**",
                        "/definitions/**",
                        "/api/v1/funds/**",
                        "/api/v1/events/**",
                        "/api/v1/shareApp"
                ).permitAll()
                // 对于登录接口 允许匿名访问
                .antMatchers("/beaver-admin/**/login",
                        "/beaver-admin/admin-users/sendPasswordResetEmail",
                        "/beaver-admin/admin-users/resetPwdFromEmail",
                        "/api/v1/login",
                        "/api/v1/resetPasswordCodeSend",
                        "/api/v1/resetPasswordCodeMsgSend",
                        "/api/v1/resetPassword",
                        "/api/v1/account/kyc-callBack",
                        "/api/v1/isRegister",
                        "/api/v1/registerCodeSend",
                        "/api/v1/registerClient",
                        "/api/v1/visitorCodeSend",
                        "/api/v1/visitorLogin",
                        "/api/v1/investment/upload",
                        "/api/v1/info/**"
                ).anonymous()
                // 除上面外的所有请求全部都需要认证即可访问
                .anyRequest().authenticated();


        //关闭默认的注销功能
        http.logout().disable();

        //把token校验过滤器添加到过滤器链中
        http.addFilterAfter(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);
        http.exceptionHandling().authenticationEntryPoint(authenticationEntryPoint).accessDeniedHandler(accessDeniedHandler);
        // 允许跨域
        http.cors();
    }

    @Bean
    public AuthenticationManager authenticationManager() throws Exception {
        AuthenticationManager authenticationManager = authenticationConfiguration.getAuthenticationManager();
        return authenticationManager;
    }

/*    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(customerDaoAuthenticationProvider()).userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }*/

    @Bean
    public CustomerDaoAuthenticationProvider customerDaoAuthenticationProvider() {
        CustomerDaoAuthenticationProvider customerDaoAuthenticationProvider = new CustomerDaoAuthenticationProvider();
        customerDaoAuthenticationProvider.setUserDetailsService(userDetailsService);
        return customerDaoAuthenticationProvider;
    }

}