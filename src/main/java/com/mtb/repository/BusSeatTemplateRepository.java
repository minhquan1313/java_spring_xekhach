package com.mtb.repository;

import com.mtb.myObject.BusSeats;

public interface BusSeatTemplateRepository {
    BusSeats getBusSeatsByBusId(int id);

    int countSeatByBusId(int id);
}
