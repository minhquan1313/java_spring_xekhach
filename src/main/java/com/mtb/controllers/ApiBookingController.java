package com.mtb.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Ticket;
import com.mtb.pojo.Trip;
import com.mtb.service.TicketService;
import com.mtb.service.TripService;
import com.mtb.service.UserService;

@RestController
@RequestMapping("/api")
public class ApiBookingController {

    @Autowired
    TicketService service;

    @Autowired
    TripService tripService;

    @Autowired
    UserService userService;

    @Autowired
    TicketService ticketService;

    @CrossOrigin
    @PatchMapping("/booking/edit/")
    public ResponseEntity<List<Ticket>> bookingChange(@RequestBody Map<String, String> payload) {

        List<Ticket> arrayList = new ArrayList<Ticket>();

        String id = payload.get("id");
        String selectedSeats = payload.get("selectedSeats");

        if (id != null && !id.isEmpty()) {
            Ticket item = ticketService.getById(Integer.parseInt(id));

            if (item == null) {
                return new ResponseEntity<>(arrayList, HttpStatus.NOT_FOUND);
            }

            BusSeats busSeats = new BusSeats();
            if (selectedSeats != null && !selectedSeats.isEmpty()) {
                busSeats.addMultiPosFromInputFull(selectedSeats);
            }

            ticketService.update(item, busSeats);

        }

        ResponseEntity<List<Ticket>> responseEntity = new ResponseEntity<>(arrayList, HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @PostMapping("/booking/")
    public ResponseEntity<List<Ticket>> booking(@RequestBody Map<String, String> payload) {

        List<Ticket> arrayList = new ArrayList<Ticket>();

        Ticket item = new Ticket();

        String isPaid = payload.get("isPaid");
        String paidWith = payload.get("paidWith");
        String tripId = payload.get("tripId");
        String userId = payload.get("userId");
        String selectedSeats = payload.get("selectedSeats");

        if (paidWith != null && !paidWith.isEmpty()) {
            if (tripId != null && !tripId.isEmpty()) {
                if (userId != null && !userId.isEmpty()) {
                    Trip trip = tripService.getById(Integer.parseInt(tripId));
                    item.setTripId(trip);
                    item.setUserId(userService.getUserById(Integer.parseInt(userId)));

                    item.setPaidWith(paidWith);

                    if (isPaid != null && !isPaid.isEmpty()) {
                        if (isPaid.equals("true"))
                            item.setIsPaid(true);
                        else
                            item.setIsPaid(false);
                    }

                    BusSeats busSeats = new BusSeats();
                    if (selectedSeats != null && !selectedSeats.isEmpty()) {
                        busSeats.addMultiPosFromInputFull(selectedSeats);
                    }

                    if (service.add(item, busSeats)) {
                        arrayList.add(item);
                    } else {
                        ResponseEntity<List<Ticket>> responseEntity = new ResponseEntity<>(arrayList,
                                HttpStatus.CONFLICT);
                        return responseEntity;
                    }
                }
            }
        }

        ResponseEntity<List<Ticket>> responseEntity = new ResponseEntity<>(arrayList, HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @GetMapping("/tickets/")
    public ResponseEntity<List<Ticket>> getTicket(@RequestParam Map<String, String> params) {

        List<Ticket> list = ticketService.getList(params);

        ResponseEntity<List<Ticket>> responseEntity = new ResponseEntity<>(list, HttpStatus.OK);

        return responseEntity;
    }
}
