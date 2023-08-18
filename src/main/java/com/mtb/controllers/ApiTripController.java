package com.mtb.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.pojo.Trip;
import com.mtb.service.TripService;

@RestController
@RequestMapping("/api")
public class ApiTripController {

    @Autowired
    private TripService tripService;

    @CrossOrigin(origins = ("http://localhost:5173"))
    @GetMapping("/trips/")
    public ResponseEntity<List<Trip>> list(@RequestParam Map<String, String> params) {
        return new ResponseEntity<>(this.tripService.getList(params), HttpStatus.OK);
    }

    @CrossOrigin(origins = ("http://localhost:5173"))
    @GetMapping("/trips/{id}")
    public ResponseEntity<Trip> get(@PathVariable(value = "id") int id) {
        return new ResponseEntity<>(this.tripService.getById(id), HttpStatus.OK);
    }
}
