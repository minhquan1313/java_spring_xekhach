package com.mtb.myObject;

import java.util.Arrays;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyCookies {

    public static String getCookies(HttpServletRequest request, String name) {
        try {
            return Arrays.stream(request.getCookies())
                    .filter(c -> c.getName().equals(name))
                    .findFirst()
                    .map(Cookie::getValue)
                    .orElse(null);
        } catch (Exception e) {
            return null;
        }
    }

    public static void setCookies(HttpServletResponse response, String name, String value) {
        Cookie cookie = new Cookie(name, value);

        response.addCookie(cookie);
    }
}
