package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Ticket;

public interface TicketService {
    List<Ticket> getList(Map<String, String> params);

    Ticket getById(int id);

    boolean addOrUpdate(Ticket item);

    boolean deleteById(int id);
}
