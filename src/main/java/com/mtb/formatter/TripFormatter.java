/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import com.mtb.pojo.Trip;

public class TripFormatter implements Formatter<Trip> {

    @Override
    public String print(Trip item, Locale locale) {
        String s = String.valueOf(item.getId());
        return s;
    }

    @Override
    public Trip parse(String itemId, Locale locale) throws ParseException {
        return new Trip(Integer.parseInt(itemId));
    }
}
