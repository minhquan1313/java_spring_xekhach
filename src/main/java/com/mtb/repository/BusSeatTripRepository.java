package com.mtb.repository;

import java.util.List;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTrip;

public interface BusSeatTripRepository {
    List<BusSeatTrip> getListByBusAndTripId(int busId, int tripId);

    BusSeatTrip getById(int id);

    BusSeats getBusSeatsByBusAndTripId(int busId, int tripId);

    BusSeats getBusSeats(int busId, int tripId, int ticketId);

    boolean addOrUpdate(BusSeatTrip item);

    boolean makeMultipleSeatTrip(List<BusSeatTrip> list);

    boolean editMultipleSeatTrip(List<BusSeatTrip> list);

    boolean delMultipleSeatTripByBusAndTripId(int busId, int tripId);

    int countSeatByBusAndTripId(int busId, int tripId);
}
