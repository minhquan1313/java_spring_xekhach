package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.pojo.Ticket;
import com.mtb.repository.TicketRepository;
import com.mtb.service.TicketService;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository repository;

    @Override
    public List<Ticket> getList(Map<String, String> params) {
        return repository.getList(params);
    }

    @Override
    public Ticket getById(int id) {
        return repository.getById(id);
    }

    @Override
    public boolean addOrUpdate(Ticket item) {
        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

}
