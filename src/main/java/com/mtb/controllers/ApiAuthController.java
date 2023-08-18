/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mtb.pojo.User;
import com.mtb.service.AuthService;

/**
 *
 * @author Duc Hung
 */
@RestController
@RequestMapping("/api")
public class ApiAuthController {

    @Autowired
    private AuthService service;

    @CrossOrigin
    @PostMapping("/login/")
    public ResponseEntity<List<User>> login(@RequestBody Map<String, String> payload) {
        String username = payload.get("username");
        String password = payload.get("password");

        ResponseEntity<List<User>> responseEntity = new ResponseEntity<>(this.service.loginApi(username, password),
                HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @PostMapping("/register/")
    public ResponseEntity<List<User>> register(@RequestBody Map<String, String> payload) {
        String username = payload.get("username");
        String password = payload.get("password");
        String first_name = payload.get("first_name");
        String last_name = payload.get("last_name");
        String avatar = payload.get("avatar");

        ResponseEntity<List<User>> responseEntity = new ResponseEntity<>(
                this.service.registerApi(username, password, first_name, last_name, avatar),
                HttpStatus.OK);
        return responseEntity;
    }
}
