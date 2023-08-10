package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.BusSeats;
import com.mtb.myObject.BusSeats.Pos;
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
        Calendar c = Calendar.getInstance(new Locale("vi"));
        Date current = c.getTime();
        item.setCreatedAt(current);

        boolean isAdded = repository.addOrUpdate(item);

        busSeats.getArray().forEach(pos -> {
            TicketDetail ticketDetail = new TicketDetail();
            BusSeatTrip b = busSeatTripService.getById(pos.getId());

            ticketDetail.setTicketId(item);
            ticketDetail.setBusSeatTripId(b);

            ticketDetailService.addOrUpdate(ticketDetail);
        });

        return isAdded;
    }

    @Override
    public boolean update(Ticket item, BusSeats busSeats) {
        List<TicketDetail> alreadyCreatedInDBList = ticketDetailService.getListByTicketId(item.getId());
        List<Pos> toUpdateSeats = new ArrayList<>();

        busSeats.getArray().forEach(busSeatTripFromClient -> {
            TicketDetail newTicketDetail = new TicketDetail();

            for (TicketDetail ticketInDB : alreadyCreatedInDBList) {
                if (busSeatTripFromClient.getId() == ticketInDB.getBusSeatTripId().getId()) {
                    // Same ticket
                    newTicketDetail.setId(ticketInDB.getId());

                    alreadyCreatedInDBList.remove(ticketInDB);
                    return;
                }
            }

            // New ticket detail, but won't create a new in db, add to pending update list
            toUpdateSeats.add(busSeatTripFromClient);
            // TODO: Change the exist ticket with a new seat, not delete the ticket detail
            // and create a new ticket detail (WASTE OF ID)
        });

        // Delete seats that user un-checked
        for (TicketDetail ticketInDB : alreadyCreatedInDBList) {
            if (toUpdateSeats.size() > 0) {
                Pos toUpdateSeat = toUpdateSeats.get(0);
                toUpdateSeats.remove(toUpdateSeat);

                BusSeatTrip busSeatTrip = busSeatTripService.getById(toUpdateSeat.getId());
                ticketInDB.setBusSeatTripId(busSeatTrip);

                ticketDetailService.addOrUpdate(ticketInDB);
            } else {
                ticketDetailService.deleteById(ticketInDB.getId());
            }
        }

        // Add addition seats
        if (toUpdateSeats.size() > 0) {
            for (Pos toUpdateSeat : toUpdateSeats) {
                TicketDetail ticketDetail = new TicketDetail();
                ticketDetail.setTicketId(item);

                BusSeatTrip busSeatTrip = busSeatTripService.getById(toUpdateSeat.getId());
                ticketDetail.setBusSeatTripId(busSeatTrip);
                ticketDetailService.addOrUpdate(ticketDetail);
            }
        }

        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        List<TicketDetail> ticketDetails = ticketDetailService.getListByTicketId(id);
        for (TicketDetail ticketDetail : ticketDetails) {
            ticketDetailService.deleteById(ticketDetail.getId());
        }

        return repository.deleteById(id);
    }

}
