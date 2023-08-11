/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.pojo.Feedback;
import com.mtb.pojo.Ticket;
import com.mtb.service.FeedbackService;
import com.mtb.service.TicketService;
import org.springframework.web.bind.annotation.PathVariable;

/**
 *
 * @author Duc Hung
 */
@Controller
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private TicketService ticketService;

    @ModelAttribute
    public void commonAttr(Model model, @RequestParam Map<String, String> params) {
        model.addAttribute("tickets", this.ticketService.getList(params));
    }

    @RequestMapping("/feedbacks")
    public String list(Model model, @RequestParam Map<String, String> params, @RequestParam(name = "tripId", required = false) String tripId) {
        if (tripId != null && !tripId.isEmpty()) {
            model.addAttribute("feedbacks", this.feedbackService.getFeedbacksForTrip(params, tripId));
        } else {
            model.addAttribute("feedbacks", this.feedbackService.getFeedbacks(params));
        }
        return "feedbacks";
    }

    @GetMapping("/feedbacks/add")
    public String addForm(Model model, @RequestParam("ticketId") int ticketId) {
        Feedback feedback = new Feedback();
        Ticket ticket = ticketService.getById(ticketId);
        feedback.setTicketId(ticket);

        model.addAttribute("feedback", feedback);
        return "feedbacks.addOrUpdate";
    }

    @GetMapping("/feedbacks/edit")
    public String update(Model model, @RequestParam("feedbackId") int feedbackId, @RequestParam("tripId") int tripId) {
        Feedback f = feedbackService.getFeedbackById(feedbackId);
        model.addAttribute("feedback", f);
        model.addAttribute("tripId", tripId);
        return "feedbacks.addOrUpdate";
    }

    @PostMapping("/feedbacks")
    public String add(@ModelAttribute(value = "feedback") @Valid Feedback f, BindingResult rs) {

        if (!rs.hasErrors()) {
            if (this.feedbackService.addOrUpdateFeedback(f) == true) {
                return "redirect:/feedbacks";
            }
        }

        return "feedbacks.addOrUpdate";
    }
}
