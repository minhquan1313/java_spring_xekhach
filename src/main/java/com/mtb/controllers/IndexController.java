package com.mtb.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.myObject.SideBarUI;

@Controller
@ControllerAdvice
@PropertySource("classpath:configs.properties")
public class IndexController {

    @Autowired
    private Environment env;

    @Autowired
    private SideBarUI sideBarUI;

    @ModelAttribute
    public void commonAttr(Model model,
            @CookieValue(value = "sidebarExpanded", defaultValue = "unknown") String sidebarExpanded) {
        model.addAttribute("date_pattern", this.env.getProperty("date_pattern"));
        model.addAttribute("app_name", this.env.getProperty("app_name"));

        model.addAttribute("sidebarExpanded", sidebarExpanded.equals("true") ? true : false);
        model.addAttribute("sideBarUI", sideBarUI.getList());
    }

    @RequestMapping("/")
    public String index(Model model, @RequestParam Map<String, String> params) {

        return "index";
    }
}
