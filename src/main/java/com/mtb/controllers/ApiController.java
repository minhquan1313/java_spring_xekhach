package com.mtb.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.repository.BusRepository;
import com.mtb.service.RouteService;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private RouteService routeService;

    @Autowired
    BusRepository busRepository;

    @DeleteMapping("/routes/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteRoute(@PathVariable(value = "id") int id) {
        this.routeService.deleteById(id);
    }

    @DeleteMapping("/buses/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteBus(@PathVariable(value = "id") int id) {
        this.busRepository.deleteById(id);
    }
}
