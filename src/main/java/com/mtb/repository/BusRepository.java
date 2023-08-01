package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Bus;

public interface BusRepository {
    List<Bus> getList(Map<String, String> params);

    Bus getById(int id);

    boolean addOrUpdate(Bus item);

    boolean deleteById(int id);

    int countSeat(int id);
}
