/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import com.mtb.pojo.User;
import com.mtb.service.UserService;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Duc Hung
 */
@Controller
public class UserController {
      @Autowired
    private UserService userService;
    
      @GetMapping("/users")
    public String index(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("users", this.userService.getUsers(params));
        
        
      
        
        return "users";
    }

  

//    @GetMapping("/users")
//    public String list(Model model) {
//        model.addAttribute("user", new User());
//        return "users";
//    }
//
//    @GetMapping("/users/{id}")
//    public String update(Model model, @PathVariable(value = "id") int id) {
//        model.addAttribute("user", this.userService.getUserById(id));
//        return "users";
//    }
//
//    @PostMapping("/users")
//    public String add(@ModelAttribute(value = "user") @Valid User u,
//            BindingResult rs) {
//
//        if (!rs.hasErrors()) {
//            if (this.userService.addOrUpdateUser(u) == true) {
//                return "redirect:/";
//            }
//        }
//
//        return "users";
//    }
}