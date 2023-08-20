package com.mtb.service.impl;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mtb.pojo.Role;
import com.mtb.pojo.User;
import com.mtb.repository.UserRepository;
import com.mtb.service.AuthService;
import com.mtb.service.RoleService;

@Service("userDetailsService")
public class AuthServiceImpl implements AuthService {

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private RoleService roleService;

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
    public User loginApi(String username, String password) {

        User u = userRepo.getUserByUsername(username);

        if (u != null) {
            boolean isMatch = passwordEncoder.matches(password, u.getPassword());

            if (isMatch)
                return u;
        }
        return null;
    }

    @Override
    public User registerApi(
            String username,
            String password,
            String first_name,
            String last_name) {
        String encodedPassword = passwordEncoder.encode(password);
        User u = new User();

        Role userRole = roleService.getRoleByTitle("User");

        u.setUsername(username);
        u.setPassword(encodedPassword);
        u.setFirstName(first_name);
        u.setLastName(last_name);
        u.setRoleId(userRole);

        if (userRepo.addOrUpdateUser(u)) {
            return u;
        }

        return null;
    }

}
