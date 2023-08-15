package com.mtb.service;

import java.util.List;

import com.mtb.myObject.TitleAndValue;

public interface StatsService {
    // int revenueByMonth(int month, int year);

    List<TitleAndValue> revenueByMonthsInYear(int year);

    List<TitleAndValue> revenueByMonthsInYear(int year, String msgBean);

    // int revenueByYear(int year);

    List<TitleAndValue> revenueByYears(int fromYear, int toYear);

    List<TitleAndValue> revenueByYears(int fromYear, int toYear, String msgBean);

    // int revenueByQuarter(int which, int year);

    List<TitleAndValue> revenueByQuarters(int year);

    List<TitleAndValue> revenueByQuarters(int year, String msgBean);
}
