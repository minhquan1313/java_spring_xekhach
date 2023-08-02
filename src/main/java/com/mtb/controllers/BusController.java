package com.mtb.controllers;

import java.util.ArrayList;
import java.util.List;
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
import com.mtb.service.BusSeatTemplateService;
import com.mtb.service.BusService;

@Controller
// @PropertySource("classpath:configs.properties")
public class BusController {

    @Autowired
    private BusService busService;

    @Autowired
    private BusSeatTemplateService busSeatTemplateService;

    @RequestMapping("/buses")
    public String index(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("buses", busService.getList(null));
        List<Integer> listCho = new ArrayList<>();
        for (Bus b : busService.getList(null)) {
            listCho.add(busSeatTemplateService.countSeatByBusId(b.getId()));
        }
        model.addAttribute("seatCounts", listCho);
        return "buses";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @GetMapping("/buses/add")
    public String addForm(Model model) {
        model.addAttribute("bus", new Bus());

        return "buses.addOrUpdate";
    }

    @GetMapping("/buses/{id}")
    public String detail(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("bus", busService.getById(id));
        model.addAttribute("seats", busSeatTemplateService.getBusSeatsByBusId(id));
        model.addAttribute("seatCount", busSeatTemplateService.countSeatByBusId(id));

        return "bus.detail";
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
