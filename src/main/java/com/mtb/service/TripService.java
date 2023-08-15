package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Trip;

public interface TripService {
    List<Trip> getList(Map<String, String> params);

    Trip getById(int id);

    boolean add(Trip item);

    boolean update(Trip item, BusSeats busSeats);

    int getLowestPrice();

    int getHightestPrice();

    boolean deleteById(int id);

    List<Object[]> countTripsByRoute();
}