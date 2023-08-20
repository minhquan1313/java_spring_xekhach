package com.mtb.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.pojo.Feedback;
import com.mtb.pojo.Ticket;
import com.mtb.service.FeedbackService;
import com.mtb.service.TicketService;
import com.mtb.service.TripService;
import com.mtb.service.UserService;

@RestController
@RequestMapping("/api")
public class ApiFeedbackController {

    @Autowired
    TicketService service;

    @Autowired
    TripService tripService;

    @Autowired
    UserService userService;

    @Autowired
    TicketService ticketService;

    @Autowired
    FeedbackService feedbackService;

    @CrossOrigin
    @GetMapping("/feedbacks/")
    public ResponseEntity<List<Feedback>> getList(@RequestParam Map<String, String> params) {

        List<Feedback> list = feedbackService.getFeedbacks(params);

        ResponseEntity<List<Feedback>> responseEntity = new ResponseEntity<>(list, HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @PostMapping("/feedbacks/")
    public ResponseEntity<List<Feedback>> create(@RequestBody Map<String, String> payload) {

        List<Feedback> list = new ArrayList<>();

        String ticketId = payload.get("ticketId");
        String comment = payload.get("comment");

        if (ticketId != null && !ticketId.isEmpty()) {
            if (comment != null && !comment.isEmpty()) {
                Feedback feedback = new Feedback();

                int tId = Integer.parseInt(ticketId);
                Ticket ticket = ticketService.getById(tId);

                feedback.setTicketId(ticket);
                feedback.setComment(comment);

                if (feedbackService.addOrUpdateFeedback(feedback)) {
                    list.add(feedback);
                }
            }
        }

        ResponseEntity<List<Feedback>> responseEntity = new ResponseEntity<>(list, HttpStatus.OK);

        return responseEntity;
    }
}
