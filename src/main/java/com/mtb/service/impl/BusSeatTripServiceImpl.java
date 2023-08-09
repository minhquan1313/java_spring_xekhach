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

    private List<BusSeatTrip> getBusSeatTripFromBusAndTripId(int busId, int tripId, BusSeats busSeats) {
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

        return l;
    }

    @Override
    public boolean makeOrEditMultipleSeatTrip(int busId, int tripId, BusSeats busSeats) {
        List<BusSeatTrip> l = this.getBusSeatTripFromBusAndTripId(busId, tripId, busSeats);

        return this.repository.makeMultipleSeatTrip(l);
    }

    @Override
    public boolean editMultipleSeatTrip(int busId, int tripId, BusSeats busSeats) {
        List<BusSeatTrip> l = this.getBusSeatTripFromBusAndTripId(busId, tripId, busSeats);

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

    @Override
    public BusSeatTrip getById(int id) {
        return this.repository.getById(id);
    }

    @Override
    public boolean addOrUpdate(BusSeatTrip item) {
        return repository.addOrUpdate(item);
    }

}
