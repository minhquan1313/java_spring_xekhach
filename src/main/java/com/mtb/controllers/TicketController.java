package com.mtb.controllers;

import java.util.HashMap;
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
import com.mtb.pojo.Ticket;
import com.mtb.pojo.Trip;
import com.mtb.pojo.User;
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
    private TripService tripService;

    @RequestMapping("/tickets")
    public String index(Model model, @RequestParam Map<String, String> params) {
        List<Ticket> list = ticketService.getList(params);
        model.addAttribute("tickets", list);

        return "tickets";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    private String addOrEditForm(Model model, int id) {
        Ticket ticket = id == 0 ? new Ticket() : ticketService.getById(id);
        model.addAttribute("ticket", ticket);

        // List<Trip> trips = tripService.getList(null);
        // model.addAttribute("trips", trips);

        Map<String, String> busParams = new HashMap<>();
        busParams.put("getSeats", "");
        List<Bus> busList = busService.getList(busParams);
        model.addAttribute("buses", busList);

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "3");
        List<User> drivers = userService.getUsers(userParams);
        model.addAttribute("drivers", drivers);

        return "tickets.add";
    }

    @GetMapping("/tickets/add")
    public String addForm(Model model, @RequestParam Map<String, String> params) {
        // here here here
        String tripId = params.get("tripId");
        return addOrEditForm(model, 0);
    }

    @GetMapping("/tickets/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        return addOrEditForm(model, id);
    }

    @PostMapping(value = "/tickets/add")
    public String addOrUpdate(@ModelAttribute(value = "ticket") @Valid Ticket item,
            BindingResult rs) {
        if (!rs.hasErrors()) {
            if (ticketService.addOrUpdate(item)) {
                return "redirect:/tickets";
            }
        }

        return "tickets.add";
    }

    @GetMapping("/tickets/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {

        return "tickets.detail";
    }
}