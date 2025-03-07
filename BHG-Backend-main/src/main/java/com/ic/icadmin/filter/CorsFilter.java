package com.ic.icadmin.filter;
//package com.ic.icadmin.filter;
//
//import com.ic.icadmin.share.utils.HttpUtil;
//
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
///**
// * 跨域设置
// * Created by RubinChu on 2021/1/22 下午 4:11
// */
//@WebFilter(filterName = "icAdminFilter")
//public class CorsFilter implements Filter {
//
//    @Override
//    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
//        HttpServletResponse response = (HttpServletResponse) res;
//        HttpUtil.addCorsResponseHeader(response);
//        chain.doFilter(req, res);
//    }
//
//}
