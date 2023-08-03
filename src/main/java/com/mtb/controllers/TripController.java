package com.mtb.controllers;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TripController {
    @RequestMapping("/trips")
    public String index(Model model, @RequestParam Map<String, String> params) {

        return "trips";
    }
}
