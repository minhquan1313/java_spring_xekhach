package com.mtb.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.service.BusService;
import com.mtb.service.RouteService;
import com.mtb.service.TripService;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private RouteService routeService;

    @Autowired
    BusService busService;

    @Autowired
    TripService tripService;

    @DeleteMapping("/routes/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteRoute(@PathVariable(value = "id") int id) {
        this.routeService.deleteById(id);
    }

    @DeleteMapping("/buses/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteBus(@PathVariable(value = "id") int id) {
        this.busService.deleteById(id);
    }

    @DeleteMapping("/trips/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteTrip(@PathVariable(value = "id") int id) {
        this.tripService.deleteById(id);
    }
}
