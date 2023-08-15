/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import com.mtb.pojo.Role;
import java.util.List;

/**
 *
 * @author Duc Hung
 */
public interface RoleRepository {

    List<Role> getRoles();

    boolean addOrUpdateRole(Role r);
    Role getRoleById(int id);
    boolean deleteRole(int id);
    
}
