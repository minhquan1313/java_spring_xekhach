package com.mtb.repository;

import com.lowagie.text.DocumentException;
import java.util.List;
import java.util.Map;

import com.mtb.pojo.Ticket;

public interface TicketRepository {
    List<Ticket> getList(Map<String, String> params);

    Ticket getById(int id);

    boolean addOrUpdate(Ticket item);

    boolean deleteById(int id);
    
    void exportTicketsToPdf(Ticket t, java.io.OutputStream outputStream)throws DocumentException;
}
