package com.mtb.controllers;

import java.util.HashMap;
import java.util.HashSet;
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

import com.mtb.pojo.Ticket;
import com.mtb.pojo.Trip;
import com.mtb.pojo.User;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.BusService;
import com.mtb.service.TicketService;
import com.mtb.service.TripService;
import com.mtb.service.UserService;

@Controller
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private UserService userService;

    @Autowired
    private BusService busService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private TripService tripService;

    @RequestMapping("/tickets")
    public String index(Model model, @RequestParam Map<String, String> params) {
        List<Ticket> list = ticketService.getList(params);
        model.addAttribute("tickets", list);

        return "tickets";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    @GetMapping("/tickets/add")
    public String addForm(Model model, @RequestParam Map<String, String> params) {
        Ticket ticket = new Ticket();
        model.addAttribute("ticket", ticket);

        List<Trip> trips = tripService.getList(null);
        trips.forEach(r -> {
            int bId = r.getBusId().getId();
            int tId = r.getId();
            r.getBusId().setBusSeatTripSet(new HashSet<>(busSeatTripService.getListByBusAndTripId(bId, tId)));
        });
        model.addAttribute("trips", trips);

        Trip trip;
        String tripId = params.get("tripId");
        if (tripId != null && !tripId.isEmpty()) {
            trip = tripService.getById(Integer.parseInt(tripId));
        } else {
            trip = trips.get(0);
        }
        model.addAttribute("trip", trip);

        // trip.getBusId().getBusSeatTripSet();

        // Map<String, String> busParams = new HashMap<>();
        // busParams.put("getSeats", "");
        // busParams.put("id", String.valueOf(trip.getBusId().getId()));
        // Bus bus = busService.getList(busParams).get(0);
        // model.addAttribute("bus", trip.getBusId());

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "4");
        List<User> bookingUsers = userService.getUsers(userParams);
        model.addAttribute("bookingUsers", bookingUsers);

        int extraPrice = 10;
        model.addAttribute("extraPrice", extraPrice);

        return "tickets.add";
    }

    @GetMapping("/tickets/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        // return addOrEditForm(model, id);

        return "tickets.edit";
    }

    @PostMapping(value = "/tickets/add")
    public String addOrUpdate(@ModelAttribute(value = "ticket") @Valid Ticket item,
            BindingResult rs) {
        if (!rs.hasErrors()) {
            // if (ticketService.addOrUpdate(item)) {
            // return "redirect:/tickets";
            // }
        }

        return "tickets.add";
    }

    @GetMapping("/tickets/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {

        return "tickets.detail";
    }
}