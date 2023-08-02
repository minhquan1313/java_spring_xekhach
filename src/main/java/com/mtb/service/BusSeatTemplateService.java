package com.mtb.service;

import com.mtb.myObject.BusSeats;

public interface BusSeatTemplateService {
    BusSeats getBusSeatsByBusId(int id);

    int countSeatByBusId(int id);
}
