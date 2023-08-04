package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.myObject.BusSeats.Pos;
import com.mtb.pojo.Bus;
import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.Trip;
import com.mtb.repository.BusSeatTripRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.BusService;
import com.mtb.service.TripService;

@Service
public class BusSeatTripServiceImpl implements BusSeatTripService {

    @Autowired
    BusSeatTripRepository repository;

    @Autowired
    BusService busService;

    @Autowired
    TripService tripService;

    @Override
    public List<BusSeatTrip> getListByBusAndTripId(int busId, int tripId) {
        return this.repository.getListByBusAndTripId(busId, tripId);
    }

    @Override
    public BusSeats getBusSeats(int busId, int tripId) {
        return this.repository.getBusSeatsByBusAndTripId(busId, tripId);
    }

    @Override
    public boolean makeMultipleSeatTrip(int busId, int tripId, BusSeats busSeats) {
        Bus b = busService.getById(busId);
        Trip t = tripService.getById(tripId);
        List<BusSeatTrip> l = new ArrayList<>();
        for (Pos pos : busSeats.getArray()) {
            BusSeatTrip item = new BusSeatTrip();

            item.setBusId(b);
            item.setTripId(t);
            item.setBusSeatX(pos.getX());
            item.setBusSeatY(pos.getY());
            item.setAvailable(true);

            l.add(item);
        }

        return this.repository.makeMultipleSeatTrip(l);
    }

    @Override
    public boolean editMultipleSeatTrip(int busId, int tripId, BusSeats busSeats) {
        List<BusSeatTrip> l = new ArrayList<>();

        Bus b = busService.getById(busId);
        Trip t = tripService.getById(tripId);

        for (Pos pos : busSeats.getArray()) {
            BusSeatTrip item = new BusSeatTrip();

            item.setBusId(b);
            item.setTripId(t);
            item.setBusSeatX(pos.getX());
            item.setBusSeatY(pos.getY());
            item.setAvailable(pos.isAvailable());

            l.add(item);
        }

        return this.repository.editMultipleSeatTrip(l);

    }

    @Override
    public boolean delMultipleSeatTrip(int busId, int tripId) {
        return this.repository.delMultipleSeatTripByBusAndTripId(busId, tripId);
    }

    @Override
    public int countSeatById(int busId, int tripId) {
        return this.repository.countSeatByBusAndTripId(busId, tripId);
    }

}
