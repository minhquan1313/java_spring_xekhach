package com.mtb.service.impl;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lowagie.text.DocumentException;
import com.mtb.myObject.BusSeats;
import com.mtb.myObject.BusSeats.Pos;
import com.mtb.myObject.Utils;
import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.Ticket;
import com.mtb.pojo.TicketDetail;
import com.mtb.pojo.Trip;
import com.mtb.repository.TicketRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TicketDetailService;
import com.mtb.service.TicketService;
import com.mtb.service.TripService;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository repository;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private TripService tripService;

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

        Trip trip = tripService.getById(item.getTripId().getId());

        if (item.getPaidPrice() == null || item.getPaidPrice() == 0) {
            int paidPrice = tripService.countPaidPrice(trip, busSeats.getArray().size());
            item.setPaidPrice(paidPrice);
        }

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
        Trip trip = tripService.getById(item.getTripId().getId());

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

            // New ticket detail(other seat), but won't create a new in db, add to pending
            // update list
            toUpdateSeats.add(busSeatTripFromClient);
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

        if (item.getPaidPrice() == null || item.getPaidPrice() == 0) {
            int paidPrice = tripService.countPaidPrice(trip, busSeats.getArray().size());
            item.setPaidPrice(paidPrice);
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

    @Override
    public void exportTicketToPdf(int id, OutputStream outputStream) throws DocumentException {
        Ticket ticket = repository.getById(id);

        if (ticket != null) {
            repository.exportTicketsToPdf(ticket, outputStream);
        } else {
            throw new IllegalArgumentException("Không tìm thấy");
        }
    }

    @Override
    public int getExtraPrice(Date d) {
        int extra = 0;

        Calendar ref = Calendar.getInstance();
        ref.setTime(d);

        Calendar holidayTetFrom = Calendar.getInstance();
        holidayTetFrom.set(Calendar.YEAR, ref.get(Calendar.YEAR));
        holidayTetFrom.set(Calendar.MONTH, 0);
        holidayTetFrom.set(Calendar.DAY_OF_MONTH, 1);

        holidayTetFrom.set(Calendar.HOUR_OF_DAY, 0);
        holidayTetFrom.set(Calendar.MINUTE, 0);
        holidayTetFrom.set(Calendar.SECOND, 0);
        holidayTetFrom.set(Calendar.MILLISECOND, 0);

        Calendar holidayTetTo = Calendar.getInstance();
        holidayTetTo.set(Calendar.YEAR, ref.get(Calendar.YEAR));
        holidayTetTo.set(Calendar.MONTH, 1);
        holidayTetTo.set(Calendar.DAY_OF_MONTH, 1);

        holidayTetTo.set(Calendar.HOUR_OF_DAY, 0);
        holidayTetTo.set(Calendar.MINUTE, 0);
        holidayTetTo.set(Calendar.SECOND, 0);
        holidayTetTo.set(Calendar.MILLISECOND, 0);

        holidayTetTo.add(Calendar.SECOND, -1);

        Date from = holidayTetFrom.getTime();
        Date to = holidayTetTo.getTime();
        boolean isDateBetween = Utils.isDateBetween(
                d,
                from,
                to);

        if (isDateBetween)
            extra += 20000;

        return extra;
    }

}