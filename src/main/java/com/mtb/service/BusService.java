package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Bus;

public interface BusService {
    /**
     * params:
     * getSeats : boolean |
     */
    List<Bus> getList(Map<String, String> params);

    Bus getById(int id);

    boolean addOrUpdate(Bus item, BusSeats busSeats);

    boolean deleteById(int id);
}
