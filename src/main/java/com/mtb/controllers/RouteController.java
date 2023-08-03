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

import com.mtb.pojo.Route;
import com.mtb.service.RouteService;

@Controller
public class RouteController {

    @Autowired
    private RouteService routeService;

    @RequestMapping("/routes")
    public String index(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("routes", routeService.getList(null));

        return "routes";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @GetMapping("/routes/add")
    public String addForm(Model model) {
        model.addAttribute("route", new Route());

        return "routes.addOrUpdate";
    }

    @GetMapping("/routes/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("route", routeService.getById(id));

        return "routes.addOrUpdate";
    }

    @PostMapping(value = "/routes/add")
    public String addOrUpdate(Model model, @ModelAttribute(value = "route") @Valid Route item, BindingResult rs) {
        // model.addAttribute("debugValue", item);
        // return "debug";

        if (!rs.hasErrors()) {
            if (routeService.addOrUpdate(item)) {
                return "redirect:/routes";
            }
        }

        return "routes.addOrUpdate";
    }
}
