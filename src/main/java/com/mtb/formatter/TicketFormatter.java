/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.formatter;

import com.mtb.pojo.Ticket;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author Duc Hung
 */
public class TicketFormatter implements Formatter<Ticket>{

    @Override
    public String print(Ticket object, Locale locale) {
        return String.valueOf(object.getId());
    }

    @Override
    public Ticket parse(String text, Locale locale) throws ParseException {
        return new Ticket(Integer.parseInt(text));
    }
    
}
