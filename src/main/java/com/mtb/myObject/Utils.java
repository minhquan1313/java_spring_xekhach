package com.mtb.myObject;

import java.util.Date;

public class Utils {
    public static boolean isDateGreaterOrEqual(Date now, Date b) {
        return now.getTime() >= b.getTime();
    }

    public static boolean isDateBetween(Date now, Date a, Date b) {
        return a.getTime() >= now.getTime() && now.getTime() >= b.getTime();
    }

    public static String replaceFromMessageBean(String text, String... valueReplace) {
        String x = text;

        if (x != null)
            for (String str : valueReplace) {
                x = x.replaceFirst("\\$", str);
            }
        return x;
    }
}
