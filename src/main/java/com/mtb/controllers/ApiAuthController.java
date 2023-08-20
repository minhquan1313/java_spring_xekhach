package com.mtb.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mtb.pojo.User;
import com.mtb.service.AuthService;
import com.mtb.service.UserService;

@RestController
@RequestMapping("/api")
public class ApiAuthController {

    @Autowired
    private AuthService service;

    @Autowired
    private UserService userService;

    @Autowired
    private Cloudinary cloudinary;

    @CrossOrigin
    @PostMapping("/login/")
    public ResponseEntity<List<User>> login(@RequestBody Map<String, String> payload) {
        String username = payload.get("username");
        String password = payload.get("password");

        List<User> arrayList = new ArrayList<User>();

        User u = service.loginApi(username, password);
        if (u != null)
            arrayList.add(u);

        ResponseEntity<List<User>> responseEntity = new ResponseEntity<>(arrayList, HttpStatus.OK);

        return responseEntity;
    }

    @CrossOrigin
    @PostMapping("/register/")
    public ResponseEntity<List<User>> register(@RequestBody Map<String, String> payload) {
        List<User> arrayList = new ArrayList<User>();

        String username = payload.get("username");
        String password = payload.get("password");
        String first_name = payload.get("firstName");
        String last_name = payload.get("lastName");

        User u = service.registerApi(username, password, first_name, last_name);
        if (u != null)
            arrayList.add(u);

        ResponseEntity<List<User>> responseEntity = new ResponseEntity<>(arrayList, HttpStatus.OK);
        return responseEntity;
    }

    @CrossOrigin
    @PostMapping("/avatar/")
    public Map<String, String> avatarUpload(@RequestParam("file") MultipartFile file,
            @RequestParam("userId") Integer userId) {
        Map<String, String> map = new HashMap<>();
        if (userId != null) {
            User user = userService.getUserById(userId);

            if (user != null) {
                if (file != null && !file.isEmpty()) {
                    try {
                        Map res = this.cloudinary
                                .uploader()
                                .upload(file.getBytes(), ObjectUtils.asMap("resource_type", "auto"));

                        String url = res.get("secure_url").toString();

                        user.setAvatar(url);

                        userService.addOrUpdateUser(user);

                        map.put("url", url);
                    } catch (IOException ex) {

                    }
                }
            }

        }

        return map;
    }

    @CrossOrigin
    @GetMapping("/test/")
    public Map<String, String> avatarGet() {
        Map<String, String> map = new HashMap<>();
        map.put("key", "value");
        map.put("foo", "bar");
        map.put("aa", "bb");

        return map;
    }
}
