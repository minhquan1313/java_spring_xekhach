package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.myObject.BusSeats.Pos;
import com.mtb.pojo.Bus;
import com.mtb.pojo.BusSeatTemplate;
import com.mtb.repository.BusSeatTemplateRepository;
import com.mtb.service.BusSeatTemplateService;
import com.mtb.service.BusService;

@Service
public class BusSeatTemplateServiceImpl implements BusSeatTemplateService {
    @Autowired
    BusSeatTemplateRepository busSeatTemplateRepository;

    @Autowired
    BusService busService;

    @Override
    public BusSeats getBusSeatsByBusId(int busId) {
        return this.busSeatTemplateRepository.getBusSeatsByBusId(busId);
    }

    @Override
    public int countSeatByBusId(int id) {
        return this.busSeatTemplateRepository.countSeatByBusId(id);
    }

    @Override
    public List<BusSeatTemplate> getListByBusId(int id) {
        return this.busSeatTemplateRepository.getListByBusId(id);
    }

    @Override
    public boolean makeMultipleSeatTemplate(int busId, BusSeats list) {
        Bus b = busService.getById(busId);
        List<BusSeatTemplate> l = new ArrayList<>();
        for (Pos pos : list.getArray()) {
            BusSeatTemplate item = new BusSeatTemplate();

            item.setBusId(b);
            item.setBusSeatX(pos.getX());
            item.setBusSeatY(pos.getY());

            l.add(item);
        }

        return busSeatTemplateRepository.makeMultipleSeatTemplate(l);
    }

    @Override
    public boolean delMultipleSeatTemplateByBusId(int busId) {
        return busSeatTemplateRepository.delMultipleSeatTemplateByBusId(busId);
    }

}