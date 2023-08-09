package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.TicketDetail;

public interface TicketDetailRepository {
    List<TicketDetail> getList(Map<String, String> params);

    List<TicketDetail> getListByTicketId(int ticketId);

    TicketDetail getById(int id);

    boolean addOrUpdate(TicketDetail item);

    boolean deleteById(int id);
}
