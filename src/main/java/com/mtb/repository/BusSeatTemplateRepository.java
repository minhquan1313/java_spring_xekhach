package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTemplate;

public interface BusSeatTemplateRepository {
    BusSeats getBusSeatsByBusId(int id);

    public List<BusSeatTemplate> getListById(int id, Map<String, String> params);

    int countSeatByBusId(int id);
}
