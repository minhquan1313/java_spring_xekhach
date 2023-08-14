/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.pojo.Role;
import com.mtb.service.RoleService;

/**
 *
 * @author Duc Hung
 */
@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    @ModelAttribute
    public void commonAttr(Model model) {
        model.addAttribute("route_name", "Vai trò");
    }

    @RequestMapping("/roles")
    public String list(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("roles", this.roleService.getRoles(params));
        return "roles";
    }

    @GetMapping("/roles/add")
    public String addForm(Model model) {
        model.addAttribute("role", new Role());
        return "roles.addOrUpdate";
    }

    @GetMapping("/roles/{id}")
    public String update(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("role", this.roleService.getRoleById(id));
        return "roles.addOrUpdate";
    }

    @PostMapping("/roles")
    public String add(@ModelAttribute(value = "role") @Valid Role r, BindingResult rs) {
        if (!rs.hasErrors()) {
            if (this.roleService.addOrUpdateRole(r) == true) {
                return "redirect:/roles";
            }
        }

        return "roles.addOrUpdate";
    }
}
