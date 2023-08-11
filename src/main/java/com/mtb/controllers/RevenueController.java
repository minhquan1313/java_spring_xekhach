package com.mtb.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.service.StatsService;

@Controller
public class RevenueController {

    @Autowired
    private StatsService statsService;

    @RequestMapping("/revenue")
    public String index(Model model, @RequestParam Map<String, String> params) {

        return "revenue";
    }
}
