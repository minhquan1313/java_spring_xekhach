package com.mtb.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@PropertySource("classpath:configs.properties")
public class BusController {
    @Autowired
    private Environment env;

    @RequestMapping("/bus")
    public String index(Model model, @RequestParam Map<String, String> params) {
        // model.addAttribute("routes", this.productService.getProducts(params));

        return "routes";
    }
}
