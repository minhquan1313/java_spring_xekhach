package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.Ticket;
import com.mtb.pojo.TicketDetail;
import com.mtb.repository.TicketDetailRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TicketDetailService;
import com.mtb.service.TicketService;

@Service
public class TicketDetailServiceImpl implements TicketDetailService {

    @Autowired
    private TicketDetailRepository repository;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private TicketDetailService ticketDetailService;
    @Autowired
    private TicketService ticketService;

    @Override
    public List<TicketDetail> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public List<TicketDetail> getListByTicketId(int ticketId) {
        return repository.getListByTicketId(ticketId);
    }

    @Override
    public TicketDetail getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean addOrUpdate(TicketDetail item) {
        if (item.getId() != null) {
            // UPDATE
            TicketDetail original = ticketDetailService.getById(item.getId());

            Integer bId = original.getBusSeatTripId().getId();
            if (bId != item.getBusSeatTripId().getId()) {
                BusSeatTrip b = busSeatTripService.getById(bId);
                b.setAvailable(true);
                busSeatTripService.addOrUpdate(b);
            } else {
                return true;
            }
        }

        Integer bId = item.getBusSeatTripId().getId();
        BusSeatTrip b = busSeatTripService.getById(bId);
        b.setAvailable(false);
        busSeatTripService.addOrUpdate(b);

        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        TicketDetail item = ticketDetailService.getById(id);
        Integer bId = item.getBusSeatTripId().getId();
        BusSeatTrip b = busSeatTripService.getById(bId);
        b.setAvailable(true);
        busSeatTripService.addOrUpdate(b);

        return repository.deleteById(id);
    }

    @Override
    public int countByTicketId(int ticketId) {
        Ticket t = ticketService.getById(ticketId);

        return repository.countByTicket(t);
    }
}