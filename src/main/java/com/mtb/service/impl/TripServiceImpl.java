package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.pojo.Trip;
import com.mtb.repository.TripRepository;
import com.mtb.service.TripService;

@Service
public class TripServiceImpl implements TripService {

    @Autowired
    private TripRepository repository;

    @Override
    public List<Trip> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public Trip getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean addOrUpdate(Trip item) {
        // auto create seats

        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

}
