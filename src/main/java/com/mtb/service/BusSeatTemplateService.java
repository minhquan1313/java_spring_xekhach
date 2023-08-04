package com.mtb.service;

import java.util.List;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTemplate;

public interface BusSeatTemplateService {
    BusSeats getBusSeatsByBusId(int id);

    public List<BusSeatTemplate> getListByBusId(int busId);

    boolean makeMultipleSeatTemplate(int busId, BusSeats busSeats);

    boolean delMultipleSeatTemplateByBusId(int busId);

    int countSeatByBusId(int id);
}
