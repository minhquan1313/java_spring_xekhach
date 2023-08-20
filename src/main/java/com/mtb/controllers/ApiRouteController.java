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

import com.mtb.pojo.Route;
import com.mtb.service.RouteService;

@RestController
@RequestMapping("/api")
public class ApiRouteController {

    @Autowired
    private RouteService service;

    @CrossOrigin
    @GetMapping("/routes/")
    public ResponseEntity<List<Route>> list(@RequestParam Map<String, String> params) {
        return new ResponseEntity<>(this.service.getList(params), HttpStatus.OK);
    }

    @CrossOrigin
    @GetMapping("/routes/{id}")
    public ResponseEntity<List<Route>> get(@PathVariable(value = "id") int id) {
        List<Route> arrayList = new ArrayList<Route>() {
            {
                add(service.getById(id));
            }
        };

        return new ResponseEntity<>(arrayList, HttpStatus.OK);
    }

    @CrossOrigin
    @GetMapping("/routes/start-location/")
    public ResponseEntity<List<Route>> getListStart() {
        ResponseEntity<List<Route>> responseEntity = new ResponseEntity<>(this.service.getListStart(), HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @GetMapping("/routes/end-location/")
    public ResponseEntity<List<Route>> getListEnd() {
        ResponseEntity<List<Route>> responseEntity = new ResponseEntity<>(this.service.getListEnd(), HttpStatus.OK);

        return responseEntity;
    }
}
