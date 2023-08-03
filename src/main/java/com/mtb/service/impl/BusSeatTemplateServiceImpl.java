package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.myObject.BusSeats.Pos;
import com.mtb.pojo.Bus;
import com.mtb.pojo.BusSeatTemplate;
import com.mtb.repository.BusRepository;
import com.mtb.repository.BusSeatTemplateRepository;
import com.mtb.service.BusSeatTemplateService;

@Service
public class BusSeatTemplateServiceImpl implements BusSeatTemplateService {
    @Autowired
    BusSeatTemplateRepository busSeatTemplateRepository;
    @Autowired
    BusRepository busRepository;

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

    @Override
    public boolean makeMultipleSeatTemplate(int busId, BusSeats list) {
        Bus b = busRepository.getById(busId);
        List<BusSeatTemplate> l = new ArrayList<>();
        for (Pos pos : list.getArray()) {
            BusSeatTemplate item = new BusSeatTemplate();
            item.setBusId(b);
            item.setBusSeat(pos.toString());

            l.add(item);
        }

        return busSeatTemplateRepository.makeMultipleSeatTemplate(l);
    }

    @Override
    public boolean delMultipleSeatTemplateByBusId(int busId) {
        return busSeatTemplateRepository.delMultipleSeatTemplateByBusId(busId);
    }

}