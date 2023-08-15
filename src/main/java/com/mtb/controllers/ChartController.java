/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.mtb.myObject.TitleAndValue;
import com.mtb.myObject.TitleAndValue.TitleAndValueChartJs;
import com.mtb.pojo.Route;
import com.mtb.service.RouteService;
import com.mtb.service.TripService;

/**
 *
 * @author Duc Hung
 */
@Controller
public class ChartController {

    @Autowired
    private TripService tripService;

    @Autowired
    private RouteService routeService;

    @GetMapping("/trips/chart")
    public String showChart(Model model, Map<String, String> params) {
        List<TitleAndValue> routeData = new ArrayList<>();
        List<Object[]> tripDataList = tripService.countTripsByRoute();
        List<Route> listRoute = routeService.getList(params);

        for (Object[] tripData : tripDataList) {
            String routeId = String.valueOf(tripData[0]);
            Integer tripCount = Integer.parseInt(String.valueOf(tripData[1]));

            Route r = listRoute.stream().filter(x -> x.getId() == Integer.parseInt(routeId)).toList().get(0);

            routeData.add(new TitleAndValue(r.getStartLocation() + " - " + r.getEndLocation(), tripCount));
        }

        TitleAndValueChartJs routeChartJs = TitleAndValue.parseToChartJsData(routeData);
        routeChartJs.setDataOf("Số chuyến");
        routeChartJs.setTableName("Mật độ chuyến xe");
        routeChartJs.setChartType("bar");
        model.addAttribute("routeChartJs", routeChartJs);

        return "trips.chart";
    }
}