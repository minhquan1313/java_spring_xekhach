package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.pojo.Route;
import com.mtb.repository.RouteRepository;
import com.mtb.service.RouteService;

@Service
public class RouteServiceImpl implements RouteService {
    @Autowired
    private RouteRepository routeRepository;

    @Override
    public List<Route> getList(Map<String, String> params) {
        return routeRepository.getList(params);
    }
}
