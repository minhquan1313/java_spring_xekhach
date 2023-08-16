package com.mtb.controllers;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.pojo.User;
import com.mtb.service.UserService;

@Controller
@ControllerAdvice
public class SecurityController {

    @Autowired
    private UserService userService;

    @ModelAttribute
    public void commonAttr(Model model, HttpServletRequest request) {
        model.addAttribute("isDebugging", 1);

        Principal principal = request.getUserPrincipal();
        if (principal == null)
            return;

        Map<String, String> userParams = new HashMap<>();
        userParams.put("username", principal.getName());
        User user = userService.getUsers(userParams).get(0);

        model.addAttribute("authenticated_user", user);
    }

    @GetMapping("/login")
    public String login(Model model, @RequestParam Map<String, String> params) {
        String accessDenied = params.get("accessDenied");
        if (accessDenied != null) {
            return "login.denied";
        }

        return "login";
    }
}
