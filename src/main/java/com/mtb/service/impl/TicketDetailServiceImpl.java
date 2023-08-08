package com.mtb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.pojo.TicketDetail;
import com.mtb.repository.TicketDetailRepository;
import com.mtb.service.TicketDetailService;

@Service
public class TicketDetailServiceImpl implements TicketDetailService {

    @Autowired
    private TicketDetailRepository repository;

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
        return repository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        return repository.deleteById(id);
    }

}