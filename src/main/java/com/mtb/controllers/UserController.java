/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
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

import com.mtb.pojo.User;
import com.mtb.service.RoleService;
import com.mtb.service.UserService;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Duc Hung
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private RoleService roleService;
    
    @ModelAttribute
    public void commonAttr(Model model,@RequestParam Map<String, String> params) {
        model.addAttribute("roles", this.roleService.getRoles(params));
    }

    @RequestMapping("/users")
    public String list(Model model, @RequestParam Map<String, String> params, String kw, String roleId) {
        if ((kw != null && !kw.isEmpty()) || (roleId!=null&&!roleId.isEmpty())) {
            model.addAttribute("users", this.userService.searchUsers(params, kw, roleId));
        } else {
            model.addAttribute("users", this.userService.getUsers(params));
        }
        return "users";
    }

    @GetMapping("/users/add")
    public String addForm(Model model) {
        model.addAttribute("user", new User());
        return "users.addOrUpdate";
    }

    @GetMapping("/users/{id}")
    public String update(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("user", this.userService.getUserById(id));
        return "users.addOrUpdate";
    }

    @PostMapping("/users")
    public String add(@ModelAttribute(value = "user") @Valid User u, BindingResult rs) {

        if (!rs.hasErrors()) {
            if (this.userService.addOrUpdateUser(u) == true) {
                return "redirect:/users";
            }
        }

        return "users.addOrUpdate";
    }
    
     @GetMapping("/users/export/{id}")
    public void exportUserToPdf(@PathVariable int id, HttpServletResponse response) throws DocumentException {
        try {
                 
            response.setContentType("application/pdf");
            //response.setHeader("Content-Disposition", "attachment; filename=\"user_" + id + ".pdf\"");
            response.setHeader("Content-Disposition", "inline; filename=\"user_"+id+".pdf\"");

            

            userService.exportUserToPdf(id, response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
