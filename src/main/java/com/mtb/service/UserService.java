/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.service;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import com.lowagie.text.DocumentException;
import com.mtb.pojo.User;

/**
 *
 * @author Duc Hung
 */
public interface UserService {

    List<User> getUsers(Map<String, String> params);

    List<User> searchUsers(Map<String, String> params, String id, String kw, String role);

    int countUser();

    boolean addOrUpdateUser(User u);

    User getUserById(int id);

    boolean deleteUser(int id);

    void exportUserToPdf(int userId, OutputStream outputStream) throws DocumentException;

}
