/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.service;

import com.mtb.pojo.Role;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Duc Hung
 */
public interface RoleService {
    List<Role> getRoles(Map<String, String> params);

    boolean addOrUpdateRole(Role r);
      Role getRoleById(int id);
    boolean deleteRole(int id);
}
