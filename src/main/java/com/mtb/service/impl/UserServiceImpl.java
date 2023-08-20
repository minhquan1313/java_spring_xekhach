/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mtb.pojo.User;
import com.mtb.repository.UserRepository;
import com.mtb.service.UserService;

/**
 *
 * @author Duc Hung
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private Cloudinary cloudinary;

    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Override
    public List<User> getUsers(Map<String, String> params) {
        return this.userRepo.getUsers(params);
    }

    @Override
    public int countUser() {
        return this.userRepo.countUser();
    }

    @Override
    public boolean addOrUpdateUser(User user) {
        if (user.getFile() != null && !user.getFile().isEmpty()) {
            try {
                Map res = this.cloudinary
                        .uploader()
                        .upload(user.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                user.setAvatar(res.get("secure_url").toString());
            } catch (IOException ex) {
                Logger.getLogger(UserServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (user.getId() == null) {
            String encodedPassword = passwordEncoder.encode(user.getPassword());
            user.setPassword(encodedPassword);
        }

        return this.userRepo.addOrUpdateUser(user);
    }

    @Override
    public User getUserById(int id) {
        return this.userRepo.getUserById(id);
    }

    @Override
    public boolean deleteUser(int id) {
        return this.userRepo.deleteUser(id);
    }

    @Override
    public List<User> searchUsers(Map<String, String> params, String id, String kw, String role) {
        return this.userRepo.searchUsers(params, id, kw, role);
    }
}
