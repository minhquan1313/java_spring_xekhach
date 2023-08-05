/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import com.mtb.pojo.Bus;

public class BusFormatter implements Formatter<Bus> {
    @Override
    public String print(Bus role, Locale locale) {
        return String.valueOf(role.getId());
    }

    @Override
    public Bus parse(String roleId, Locale locale) throws ParseException {
        return new Bus(Integer.parseInt(roleId));
    }
}
