package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTrip;

public interface BusSeatTripRepository {
    BusSeats getBusSeatsByBusId(int id);

    List<BusSeatTrip> getListById(int id, Map<String, String> params);

    boolean makeMultipleSeatTemplate(List<BusSeatTrip> list);

    boolean delMultipleSeatTemplateByBusId(int busId);

    int countSeatByBusId(int id);
}
