package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Bus;

public interface BusService {
    /**
     * 
     * @param params
     *               getSeats,id
     * @return
     */
    List<Bus> getList(Map<String, String> params);

    Bus getById(int id);

    boolean addOrUpdate(Bus item, BusSeats busSeats);

    boolean deleteById(int id);
}
