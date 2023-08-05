package com.mtb.service;

import java.util.List;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTrip;

public interface BusSeatTripService {
    List<BusSeatTrip> getListByBusAndTripId(int busId, int tripId);

    BusSeats getBusSeats(int busId, int tripId);

    boolean makeOrEditMultipleSeatTrip(int busId, int tripId, BusSeats busSeats);

    boolean editMultipleSeatTrip(int busId, int tripId, BusSeats busSeats);

    boolean delMultipleSeatTrip(int busId, int tripId);

    int countSeatById(int busId, int tripId);
}
