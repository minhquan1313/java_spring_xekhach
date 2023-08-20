package com.mtb.controllers;

import java.util.ArrayList;
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
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TripService;

@RestController
@RequestMapping("/api")
public class ApiTripController {

    @Autowired
    private TripService tripService;

    @CrossOrigin
    @GetMapping("/trips/")
    public ResponseEntity<List<Trip>> list(@RequestParam Map<String, String> params) {
        List<Trip> list = this.tripService.getList(params);

        ResponseEntity<List<Trip>> responseEntity = new ResponseEntity<>(list,
                HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @GetMapping("/trips/{id}")
    public ResponseEntity<List<Trip>> get(@PathVariable(value = "id") int id) {
        List<Trip> arrayList = new ArrayList<Trip>() {
            {
                add(tripService.getById(id));
            }
        };
        ResponseEntity<List<Trip>> responseEntity = new ResponseEntity<>(arrayList, HttpStatus.OK);

        return responseEntity;
    }
}
