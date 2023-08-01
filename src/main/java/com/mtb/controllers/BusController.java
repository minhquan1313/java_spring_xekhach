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

import com.mtb.pojo.Bus;
import com.mtb.pojo.Route;
import com.mtb.service.BusService;

@Controller
// @PropertySource("classpath:configs.properties")
public class BusController {

    @Autowired
    private BusService busService;

    @RequestMapping("/buses")
    public String index(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("buses", busService.getList(null));
        // here here here here here here here here here here here here
        return "buses";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @GetMapping("/buses/add")
    public String addForm(Model model) {
        model.addAttribute("bus", new Route());

        return "buses.addOrUpdate";
    }

    @GetMapping("/buses/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("bus", busService.getById(id));

        return "buses.addOrUpdate";
    }

    @PostMapping(value = "/buses/add")
    public String addOrUpdate(Model model, @ModelAttribute(value = "bus") @Valid Bus item, BindingResult rs) {
        if (!rs.hasErrors()) {
            if (busService.addOrUpdate(item)) {
                return "redirect:/buses";
            }
        }

        return "buses.addOrUpdate";
    }
}
