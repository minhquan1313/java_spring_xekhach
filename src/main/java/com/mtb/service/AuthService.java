package com.mtb.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.mtb.pojo.User;

public interface AuthService extends UserDetailsService {
    User loginApi(String username, String password);

    User registerApi(
            String username,
            String password,
            String first_name,
            String last_name,
            String avatar);
}
