package com.mtb.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
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

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Ticket;
import com.mtb.pojo.TicketDetail;
import com.mtb.pojo.Trip;
import com.mtb.pojo.User;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TicketDetailService;
import com.mtb.service.TicketService;
import com.mtb.service.TripService;
import com.mtb.service.UserService;

@Controller
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Autowired
    private UserService userService;

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

        Trip trip = trips.get(0);
        String tripId = params.get("tripId");
        if (tripId != null && !tripId.isEmpty()) {
            int tId = Integer.parseInt(tripId);

            for (Trip t : trips)
                if (t.getId() == tId) {
                    trip = t;
                    break;
                }
        }
        int bId = trip.getBusId().getId();
        int tId = trip.getId();
        trip.getBusId().setBusSeatTripSet(new HashSet<>(busSeatTripService.getListByBusAndTripId(bId, tId)));
        model.addAttribute("trip", trip);

        model.addAttribute("seats", busSeatTripService.getBusSeats(bId, tId));

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "4");
        List<User> bookingUsers = userService.getUsers(userParams);
        model.addAttribute("bookingUsers", bookingUsers);

        int extraPrice = 10;
        model.addAttribute("extraPriceTitle", "Phí tết");
        model.addAttribute("extraPrice", extraPrice);

        return "tickets.add";
    }

    @GetMapping("/tickets/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        // return addOrEditForm(model, id);

        return "/tickets";
        // return "tickets.edit";
    }

    @PostMapping(value = "/tickets/add")
    public String addOrUpdate(@ModelAttribute(value = "ticket") @Valid Ticket item,
            BindingResult rs,
            HttpServletRequest formData) {

        String selectedSeats = formData.getParameter("selectedSeats");
        BusSeats busSeats = new BusSeats();
        if (selectedSeats != null && !selectedSeats.isEmpty()) {
            busSeats.addMultiPosFromInputWithIdAndAvailable(selectedSeats, false);
        }

        if (!rs.hasErrors() && !selectedSeats.isEmpty()) {
            if (ticketService.add(item, busSeats)) {
                return "redirect:/tickets";
            }
        }

        return "tickets.add";
    }

    @GetMapping("/tickets/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {
        Ticket ticket = ticketService.getById(id);
        Trip trip = ticket.getTripId();
        int bId = trip.getBusId().getId();
        int tId = trip.getId();
        trip.getBusId().setBusSeatTripSet(new HashSet<>(busSeatTripService.getListByBusAndTripId(bId, tId)));
        model.addAttribute("ticket", ticket);
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        List<TicketDetail> ticketsDetail = ticketDetailService.getListByTicketId(tId);
        List<Integer> ticketsDetailSeatId = new ArrayList<>();
        for (TicketDetail ticketDetail : ticketsDetail) {
            ticketsDetailSeatId.add(ticketDetail.getBusSeatTripId().getId());
        }

        BusSeats seats = busSeatTripService.getBusSeats(bId, tId);
        seats.getArray().forEach(r -> {
            if (ticketsDetailSeatId.contains(r.getId())) {
                r.setUserChosen(true);
            }
        });
        // model.addAttribute("ticketsDetail", ticketsDetail);
        model.addAttribute("seats", seats);
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        return "tickets.detail";
    }
}