package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.repository.StatsRepository;
import com.mtb.service.StatsService;

@Service
public class StatsServiceImpl implements StatsService {

    @Autowired
    private StatsRepository repository;

    @Override
    public int revenueByMonth(int month, int year) {
        return repository.revenueByMonth(month, year);
    }

    @Override
    public int revenueByYear(int year) {
        return repository.revenueByYear(year);
    }

    @Override
    public int revenueByQuarter(int which, int year) {
        return repository.revenueByQuarter(which, year);
    }

    @Override
    public List<Integer> revenueByMonthsInYear(int year) {
        List<Integer> list = new ArrayList<>();

        for (int i = 1; i <= 12; i++) {
            list.add(repository.revenueByMonth(i, year));
        }

        return list;
    }

    @Override
    public List<Integer> revenueByYears(int fromYear, int toYear, int step) {
        List<Integer> list = new ArrayList<>();

        for (int i = fromYear; i <= toYear; i += step) {
            list.add(repository.revenueByYear(i));
        }

        return list;
    }

    @Override
    public List<Integer> revenueByQuarters(int year) {
        List<Integer> list = new ArrayList<>();

        for (int i = 1; i <= 4; i++) {
            list.add(repository.revenueByQuarter(i, year));
        }

        return list;
    }

}
