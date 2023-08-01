/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import com.mtb.pojo.User;

/**
 *
 * @author Duc Hung
 */
public interface UserRepository {
    User getUserByUsername(String username);
}
