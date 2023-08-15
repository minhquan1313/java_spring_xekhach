/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import com.mtb.pojo.Route;

public class RouteFormatter implements Formatter<Route> {
    @Override
    public String print(Route item, Locale locale) {
        return String.valueOf(item.getId());
    }

    @Override
    public Route parse(String itemId, Locale locale) throws ParseException {
        return new Route(Integer.parseInt(itemId));
    }
}
