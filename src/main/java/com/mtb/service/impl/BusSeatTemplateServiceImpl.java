package com.mtb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.repository.BusSeatTemplateRepository;
import com.mtb.service.BusSeatTemplateService;

@Service
public class BusSeatTemplateServiceImpl implements BusSeatTemplateService {
    @Autowired
    BusSeatTemplateRepository busSeatTemplateRepository;

    @Override
    public BusSeats getBusSeatsByBusId(int id) {
        return busSeatTemplateRepository.getBusSeatsByBusId(id);
    }

    @Override
    public int countSeatByBusId(int id) {
        return busSeatTemplateRepository.countSeatByBusId(id);
    }
}