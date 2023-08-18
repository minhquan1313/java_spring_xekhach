package com.mtb.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.mtb.pojo.User;

public interface AuthService extends UserDetailsService {
    List<User> loginApi(String username, String password);

    List<User> registerApi(
            String username,
            String password,
            String first_name,
            String last_name,
            String avatar);
}
