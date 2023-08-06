package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Trip;

public interface TripRepository {
    List<Trip> getList(Map<String, String> params);

    Trip getById(int id);

    boolean addOrUpdate(Trip item);

    boolean deleteById(int id);

}
