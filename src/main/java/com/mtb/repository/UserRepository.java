/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import com.mtb.pojo.User;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Duc Hung
 */
public interface UserRepository {
    List<User> getUsers(Map<String, String> params);
    int countUser();
    boolean addOrUpdateUser(User u);
    User getUserById(int id);
    boolean deleteUser(int id);
}