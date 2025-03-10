package com.ic.icadmin.filter;

import cn.hutool.core.collection.CollectionUtil;
import com.ic.icadmin.entity.LoginUser;
import com.ic.icadmin.properties.DynamicProperties;
import com.ic.icadmin.share.constants.CommonConstants;
import com.ic.icadmin.share.constants.RedisConstants;
import com.ic.icadmin.share.error.AdminUserErrorEnum;
import com.ic.icadmin.share.utils.JwtUtil;
import com.ic.icadmin.share.utils.RedisCache;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

/**
 * @program: ic-admin
 * @description: 认证过滤器
 * @author: Jason.Wu1
 * @create: 2022-11-09 10:50
 * OncePerRequestFilter 只过滤一次，请求前
 **/
@Component
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private DynamicProperties dynamicProperties;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 获取token
        String token = request.getHeader("token");
        if (!StringUtils.hasText(token)) {
            // 放行，让后面过滤器执行
            filterChain.doFilter(request, response);
            return;
        }
        boolean isClient = token.startsWith(CommonConstants.TokenPrefix.CLIENT_TOKEN_PREFIX);
        if (isClient){
            token = token.replaceFirst(CommonConstants.TokenPrefix.CLIENT_TOKEN_PREFIX, "");
        }
        // 解析token
        String userId = "";
        try {
            Claims claims = JwtUtil.parseJWT(token);
            userId = claims.getSubject();
        } catch (Exception e) {
            filterChain.doFilter(request, response);
            return;
//            AdminUserErrorEnum.TOKEN_INVALID.throwException();
        }
        LoginUser loginUser = null;
        // 获取userid
        if (isClient){
            // if is client
            loginUser = redisCache.getCacheObject(RedisConstants.CLIENT_LOGIN_INFO + userId);
        } else {
            loginUser = redisCache.getCacheObject(RedisConstants.ADMIN_USER_LOGIN_INFO + userId);
        }
        if (Objects.isNull(loginUser)){
            filterChain.doFilter(request, response);
            return;
//            AdminUserErrorEnum.NOT_LOGIN.throwException();
        }

        // 封装Authentication
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
            new UsernamePasswordAuthenticationToken(loginUser, null, loginUser.getAuthorities());

        // 存入SecurityContextHolder
        SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);

        filterChain.doFilter(request, response);
    }

    private boolean handleExcludeUrl(HttpServletRequest req, List<String> excludes) {
        if (CollectionUtil.isEmpty(excludes)){
            return false;
        }
        String url = req.getRequestURI();
        for (String pattern : excludes) {
            if (url.contains(pattern)) {
                return true;
            }
        }
        return false;
    }
}
