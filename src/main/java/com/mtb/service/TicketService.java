package com.mtb.service;

import com.lowagie.text.DocumentException;
import java.util.List;
import java.util.Map;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Ticket;
import java.io.OutputStream;

public interface TicketService {
    List<Ticket> getList(Map<String, String> params);

    Ticket getById(int id);

    boolean add(Ticket item, BusSeats busSeats);

    boolean update(Ticket item, BusSeats busSeats);

    boolean deleteById(int id);
    
    void exportTicketToPdf(int id, OutputStream outputStream) throws DocumentException;
}
