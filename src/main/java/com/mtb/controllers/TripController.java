package com.mtb.controllers;

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

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Trip;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TripService;

@Controller
public class TripController {

    @Autowired
    private TripService tripService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @RequestMapping("/trips")
    public String index(Model model, @RequestParam Map<String, String> params) {
        List<Trip> list = tripService.getList(params);
        model.addAttribute("trips", list);

        return "trips";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @GetMapping("/trips/add")
    public String addForm(Model model) {
        model.addAttribute("trip", new Trip());

        return "trips.addOrUpdate";
    }

    @GetMapping("/trips/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        Trip trip = tripService.getById(id);
        model.addAttribute("trip", trip);

        return "trips.addOrUpdate";
    }

    @PostMapping(value = "/trips/add")
    public String addOrUpdate(Model model, @ModelAttribute(value = "bus") @Valid Trip item,
            BindingResult rs) {

        // BusSeats busSeats = new BusSeats();
        // String seatListStr = formData.getParameter("selectedSeats");
        // if (seatListStr != null && !seatListStr.isEmpty()) {
        // busSeats.addMultiPosFromInput(seatListStr);
        // }

        if (!rs.hasErrors()) {
            if (tripService.add(item)) {
                return "redirect:/trips";
            }
        }

        return "trips.addOrUpdate";
    }

    @GetMapping("/trips/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {
        Trip item = tripService.getById(id);
        BusSeats busSeats = busSeatTripService.getBusSeats(item.getBusId().getId(), item.getId());
        int count = busSeatTripService.countSeatById(item.getBusId().getId(), item.getId());

        model.addAttribute("trip", item);
        model.addAttribute("seats", busSeats);
        model.addAttribute("seatCount", count);

        return "trips.detail";
    }
}
