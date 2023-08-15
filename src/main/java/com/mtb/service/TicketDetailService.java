package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.TicketDetail;

public interface TicketDetailService {
    List<TicketDetail> getList(Map<String, String> params);

    List<TicketDetail> getListByTicketId(int ticketId);

    TicketDetail getById(int id);

    boolean addOrUpdate(TicketDetail item);

    boolean deleteById(int id);

    int countByTicketId(int ticketId);
}
