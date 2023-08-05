/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.format.Formatter;

import com.mtb.pojo.User;

public class UserFormatter implements Formatter<User> {
    @Override
    public String print(User item, Locale locale) {
        return String.valueOf(item.getId());
    }

    @Override
    public User parse(String itemId, Locale locale) throws ParseException {
        return new User(Integer.parseInt(itemId));
    }
}
