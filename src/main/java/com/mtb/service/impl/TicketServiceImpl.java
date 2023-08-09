package com.mtb.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.Ticket;
import com.mtb.pojo.TicketDetail;
import com.mtb.repository.TicketRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TicketDetailService;
import com.mtb.service.TicketService;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository repository;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Override
    public List<Ticket> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public Ticket getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean add(Ticket item, BusSeats busSeats) {
        // boolean isAdded = true;

        Calendar c = Calendar.getInstance(new Locale("vi"));

        Date current = c.getTime();

        item.setCreatedAt(current);

        boolean isAdded = repository.addOrUpdate(item);

        busSeats.getArray().forEach(pos -> {
            TicketDetail ticketDetail = new TicketDetail();
            BusSeatTrip b = busSeatTripService.getById(pos.getId());

            b.setAvailable(false);
            busSeatTripService.addOrUpdate(b);

            ticketDetail.setTicketId(item);
            ticketDetail.setBusSeatTripId(b);

            ticketDetailService.addOrUpdate(ticketDetail);
        });

        return isAdded;
    }

    @Override
    public boolean update(Ticket item, BusSeats busSeats) {
        boolean isAdded = repository.addOrUpdate(item);

        return isAdded;
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

}
