package com.mtb.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
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

import com.lowagie.text.DocumentException;
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

    @Autowired
    private MessageSource messageResource;

    @ModelAttribute
    public void commonAttr(Model model) {
        List<String> paidWithTemplate = new ArrayList<>() {
            {
                add("Tiền mặt");
                add("Momo");
                add("Chuyển khoản");
            }
        };
        model.addAttribute("paidWithTemplate", paidWithTemplate);
    }

    @RequestMapping("/tickets")
    public String index(Model model, @RequestParam Map<String, String> params) {
        List<Ticket> list = ticketService.getList(params);
        list.forEach(r -> {
            int c = ticketDetailService.countByTicketId(r.getId());
            r.setTotalSeat(c);
        });
        model.addAttribute("tickets", list);

        return "tickets";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    @GetMapping("/tickets/add")
    public String addForm(Model model, @RequestParam Map<String, String> params, Locale locale) {
        Ticket ticket = new Ticket();
        model.addAttribute("ticket", ticket);

        List<Trip> trips = tripService.getList(null);
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
        trip.getBusId().setBusSeatTripCount(busSeatTripService.countSeatById(bId, tId));
        model.addAttribute("trip", trip);

        BusSeats busSeats = busSeatTripService.getBusSeats(bId, tId);
        model.addAttribute("seats", busSeats);

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "4");
        List<User> bookingUsers = userService.getUsers(userParams);
        model.addAttribute("bookingUsers", bookingUsers);

        Map<String, String> staffParams = new HashMap<>();
        staffParams.put("roleId", "2");
        List<User> staffUsers = userService.getUsers(staffParams);
        model.addAttribute("staffUsers", staffUsers);

        int extraPrice = 10;
        String multiLangExtraCharge = messageResource.getMessage("ui.ticket.extra_charge", null, locale);
        model.addAttribute("extraPriceTitle", multiLangExtraCharge);
        model.addAttribute("extraPrice", extraPrice);

        return "tickets.add";
    }

    @GetMapping("/tickets/update/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id, @RequestParam Map<String, String> params,
            Locale locale) {
        Ticket ticket = ticketService.getById(id);
        model.addAttribute("ticket", ticket);

        List<Trip> trips = tripService.getList(null);
        model.addAttribute("trips", trips);

        Trip trip = trips.get(0);
        String tripId = params.get("tripId");
        int _tId;
        if (tripId != null && !tripId.isEmpty()) {
            _tId = Integer.parseInt(tripId);
        } else {
            _tId = ticket.getTripId().getId();
        }
        for (Trip t : trips)
            if (t.getId() == _tId) {
                trip = t;
                break;
            }

        int bId = trip.getBusId().getId();
        int tId = trip.getId();
        trip.getBusId().setBusSeatTripCount(busSeatTripService.countSeatById(bId, tId));
        model.addAttribute("trip", trip);

        BusSeats busSeats = busSeatTripService.getBusSeats(bId, tId, ticket.getId());
        model.addAttribute("seats", busSeats);

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "4");
        List<User> bookingUsers = userService.getUsers(userParams);
        model.addAttribute("bookingUsers", bookingUsers);

        Map<String, String> staffParams = new HashMap<>();
        staffParams.put("roleId", "2");
        List<User> staffUsers = userService.getUsers(staffParams);
        model.addAttribute("staffUsers", staffUsers);

        int extraPrice = 10;
        String multiLangExtraCharge = messageResource.getMessage("ui.ticket.extra_charge", null, locale);
        model.addAttribute("extraPriceTitle", multiLangExtraCharge);
        model.addAttribute("extraPrice", extraPrice);

        return "tickets.update";
    }

    @PostMapping(value = "/tickets/add")
    public String addOrUpdate(@ModelAttribute(value = "ticket") @Valid Ticket item,
            BindingResult rs,
            HttpServletRequest formData) {

        String selectedSeats = formData.getParameter("selectedSeats");
        BusSeats busSeats = new BusSeats();
        if (selectedSeats != null && !selectedSeats.isEmpty()) {
            busSeats.addMultiPosFromInputFull(selectedSeats);
        } else {
            ObjectError error = new ObjectError("selectedSeats", "Select at least 1 seat");
            rs.addError(error);
        }

        if (!rs.hasErrors() && !selectedSeats.isEmpty()) {
            if (item.getId() == null) {
                if (ticketService.add(item, busSeats)) {
                    return "redirect:/tickets/";
                }
            } else {
                if (ticketService.update(item, busSeats)) {
                    return "redirect:/tickets/";
                }
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

        trip.getBusId().setBusSeatTripCount(busSeatTripService.countSeatById(bId, tId));
        model.addAttribute("ticket", ticket);
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        List<TicketDetail> ticketsDetail = ticketDetailService.getListByTicketId(tId);
        List<Integer> ticketsDetailSeatId = new ArrayList<>();
        for (TicketDetail ticketDetail : ticketsDetail) {
            ticketsDetailSeatId.add(ticketDetail.getBusSeatTripId().getId());
        }

        BusSeats busSeats = busSeatTripService.getBusSeats(bId, tId, ticket.getId());
        model.addAttribute("seats", busSeats);
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        return "tickets.detail";
    }

    @GetMapping("/tickets/export/{id}")
    public void exportTicketsToPdf(@PathVariable int id, HttpServletResponse response) throws DocumentException {
        try {
            Ticket t = ticketService.getById(id);
            if (t != null && (t.getIsPaid() && t.getStaffId() != null)) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=\"ticket_" + id + ".pdf\"");
                ticketService.exportTicketToPdf(id, response.getOutputStream());
            } else {
                response.getWriter().write("Error!!!");
            }

        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}