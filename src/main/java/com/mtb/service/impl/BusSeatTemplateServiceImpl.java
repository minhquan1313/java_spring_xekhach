package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTemplate;
import com.mtb.repository.BusSeatTemplateRepository;
import com.mtb.service.BusSeatTemplateService;

@Service
public class BusSeatTemplateServiceImpl implements BusSeatTemplateService {
    @Autowired
    BusSeatTemplateRepository busSeatTemplateRepository;

    @Override
    public BusSeats getBusSeatsByBusId(int id) {
        return this.busSeatTemplateRepository.getBusSeatsByBusId(id);
    }

    @Override
    public int countSeatByBusId(int id) {
        return this.busSeatTemplateRepository.countSeatByBusId(id);
    }

    @Override
    public List<BusSeatTemplate> getListById(int id, Map<String, String> params) {
        return this.busSeatTemplateRepository.getListById(id, params);
    }
}