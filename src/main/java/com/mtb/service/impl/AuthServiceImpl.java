package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mtb.pojo.User;
import com.mtb.repository.UserRepository;
import com.mtb.service.AuthService;

@Service("userDetailsService")
public class AuthServiceImpl implements AuthService {

    @Autowired
    private UserRepository userRepo;

    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User u = this.userRepo.getUserByUsername(username);
        if (u == null) {
            throw new UsernameNotFoundException("Invalid user!");
        }

        Set<GrantedAuthority> authorities = new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(u.getRoleId().getTitle()));

        return new org.springframework.security.core.userdetails.User(u.getUsername(), u.getPassword(), authorities);
    }

    @Override
    public List<User> loginApi(String username, String password) {

        User u = userRepo.getUserByUsername(username);
        List<User> uList = new ArrayList<>();

        if (u != null) {
            boolean isMatch = passwordEncoder.matches(password, u.getPassword());

            if (isMatch)
                uList.add(u);
        }
        // User u = userRepo.getUserByUsernameAndPassword(username, encodedPassword);
        return uList;
    }

    @Override
    public List<User> registerApi(
            String username,
            String password,
            String first_name,
            String last_name,
            String avatar) {
        String encodedPassword = passwordEncoder.encode(password);
        User u = new User() {
            {
                setUsername(username);
                setPassword(encodedPassword);
                setFirstName(first_name);
                setLastName(last_name);
                setAvatar(avatar);
            }
        };

        List<User> uList = new ArrayList<>();

        if (userRepo.addOrUpdateUser(u)) {
            uList.add(u);
        }

        return uList;
    }

}
