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
    private RouteRepository repository;

    @Override
    public List<Route> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public Route getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean addOrUpdate(Route item) {
        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

    @Override
    public List<Route> getListStart() {
        return repository.getListStart();

    }

    @Override
    public List<Route> getListEnd() {
        return repository.getListEnd();

    }
}
