package com.mtb.repository;

public interface StatsRepository {
    int revenueByMonth(int month, int year);

    int revenueByYear(int year);

    int revenueByQuarter(int which, int year);
}
