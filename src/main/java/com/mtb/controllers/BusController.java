package com.mtb.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Bus;
import com.mtb.service.BusSeatTemplateService;
import com.mtb.service.BusService;

@Controller
public class BusController {

    @Autowired
    private BusService busService;

    @Autowired
    private BusSeatTemplateService busSeatTemplateService;

    @RequestMapping("/buses")
    public String index(Model model, @RequestParam Map<String, String> params) {
        params.put("busSeatTemplateCount", "");
        List<Bus> buses = busService.getList(params);
        model.addAttribute("buses", buses);

        return "buses";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @GetMapping("/buses/add")
    public String addForm(Model model) {
        model.addAttribute("bus", new Bus());

        return "buses.addOrUpdate";
    }

    @GetMapping("/buses/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("bus", busService.getById(id));

        return "buses.addOrUpdate";
    }

    @PostMapping(value = "/buses/add")
    public String addOrUpdate(Model model, @ModelAttribute(value = "bus") @Valid Bus item,
            BindingResult rs,
            HttpServletRequest formData) {

        BusSeats busSeats = new BusSeats();
        String seatListStr = formData.getParameter("selectedSeats");
        if (seatListStr != null && !seatListStr.isEmpty()) {
            busSeats.addMultiPosFromInput(seatListStr);
        } else {
            ObjectError error = new ObjectError("selectedSeats", "Select at least 1 seat");
            rs.addError(error);
        }

        if (!rs.hasErrors() && !seatListStr.isEmpty()) {
            if (busService.addOrUpdate(item, busSeats)) {
                return "redirect:/buses";
            }
        }

        return "buses.addOrUpdate";
    }

    @GetMapping("/buses/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("bus", busService.getById(id));
        model.addAttribute("seats", busSeatTemplateService.getBusSeatsByBusId(id));
        model.addAttribute("seatCount", busSeatTemplateService.countSeatByBusId(id));

        return "bus.detail";
    }
}
