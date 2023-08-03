/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.service.impl;

import com.mtb.pojo.Role;
import com.mtb.repository.RoleRepository;
import com.mtb.service.RoleService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Duc Hung
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepo;

    @Override
    public List<Role> getRoles(Map<String, String> params) {
        return this.roleRepo.getRoles();
    }

    @Override
    public boolean addOrUpdateRole(Role r) {
        return this.roleRepo.addOrUpdateRole(r);
    }

    @Override
    public Role getRoleById(int id) {
        return this.roleRepo.getRoleById(id);
    }

    @Override
    public boolean deleteRole(int id) {
        return this.roleRepo.deleteRole(id);
    }
}
