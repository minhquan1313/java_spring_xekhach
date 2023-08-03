package com.mtb.controllers;

import com.mtb.service.RoleService;
import com.mtb.service.UserService;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@ControllerAdvice
@PropertySource("classpath:configs.properties")
public class IndexController {
      @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private Environment env;
    
    @ModelAttribute
    public void commonAttr(Model model) {
        model.addAttribute("roles", this.roleService.getRoles());
    }


    @RequestMapping("/")
    public String index(Model model, @RequestParam Map<String, String> params) {

        return "index";
    }
}
