package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Bus;

public interface BusService {
    List<Bus> getList(Map<String, String> params);

    Bus getById(int id);

    boolean addOrUpdate(Bus item);

    boolean deleteById(int id);

    int countSeat(int id);
}
