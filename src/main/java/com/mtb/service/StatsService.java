package com.mtb.service;

import java.util.List;

public interface StatsService {
    int revenueByMonth(int month, int year);

    List<Integer> revenueByMonthsInYear(int year);

    int revenueByYear(int year);

    List<Integer> revenueByYears(int fromYear, int toYear, int step);

    int revenueByQuarter(int which, int year);

    List<Integer> revenueByQuarters(int year);
}
