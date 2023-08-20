/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Role;

/**
 *
 * @author Duc Hung
 */
public interface RoleService {
    List<Role> getRoles(Map<String, String> params);

    boolean addOrUpdateRole(Role r);

    Role getRoleById(int id);

    Role getRoleByTitle(String title);

    boolean deleteRole(int id);
}
