package com.mtb.controllers;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

        Route route = new Route();
        model.addAttribute("route", route);

        return "routes.addOrUpdate";
    }

    @GetMapping("/routes/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        Route route = routeService.getById(id);

        model.addAttribute("route", route);

        return "routes.addOrUpdate";
    }

    @PostMapping("/routes/add")
    public String addOrUpdate(@ModelAttribute(value = "route") @Valid Route item, BindingResult rs,
            HttpServletRequest formData) {
        String round_trip = formData.getParameter("round_trip");

        if (!rs.hasErrors()) {

            if (routeService.addOrUpdate(item)) {
                if (round_trip != null && !round_trip.isEmpty()) {
                    Route item2 = new Route();
                    item2.setStartLocation(item.getEndLocation());
                    item2.setEndLocation(item.getStartLocation());

                    if (routeService.addOrUpdate(item2)) {
                        return "redirect:/routes";
                    }
                }
                return "redirect:/routes";
            }
        }

        return "routes.addOrUpdate";
    }
}
