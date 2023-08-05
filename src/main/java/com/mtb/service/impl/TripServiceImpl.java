package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Trip;
import com.mtb.repository.TripRepository;
import com.mtb.service.BusSeatTemplateService;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TripService;

@Service
public class TripServiceImpl implements TripService {

    @Autowired
    private TripRepository repository;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private BusSeatTemplateService busSeatTemplateService;

    @Override
    public List<Trip> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public Trip getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean add(Trip item) {
        boolean isTripAdded = repository.addOrUpdate(item);

        BusSeats busSeats = busSeatTemplateService.getBusSeatsByBusId(item.getBusId().getId());
        busSeats.getArray().forEach(r -> r.setAvailable(true));

        boolean isSeatsAdded = busSeatTripService
                .makeOrEditMultipleSeatTrip(item.getBusId().getId(), item.getId(), busSeats);

        return isTripAdded && isSeatsAdded;
    }

    @Override
    public boolean update(Trip item, BusSeats busSeats) {
        boolean isTripUpdated = repository.addOrUpdate(item);

        boolean isSeatsUpdated = busSeatTripService
                .editMultipleSeatTrip(item.getBusId().getId(), item.getId(), busSeats);

        return isTripUpdated && isSeatsUpdated;
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

}