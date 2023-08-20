/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import java.util.List;

import com.mtb.pojo.Role;

/**
 *
 * @author Duc Hung
 */
public interface RoleRepository {

    List<Role> getRoles();

    boolean addOrUpdateRole(Role r);

    Role getRoleById(int id);

    boolean deleteRole(int id);

    Role getRoleByTitle(String title);

}
