package com.bhg.bhgadmin.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public interface UserDetailService {

    UserDetails loadUserByUsername(String adminUserEmail, Object detail) throws UsernameNotFoundException;
}
