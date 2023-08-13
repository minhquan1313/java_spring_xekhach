package com.mtb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.myObject.TitleAndValue;
import com.mtb.repository.StatsRepository;
import com.mtb.service.StatsService;

@Service
public class StatsServiceImpl implements StatsService {

    @Autowired
    private StatsRepository repository;

    // @Override
    // public int revenueByMonth(int month, int year) {
    // return repository.revenueByMonth(month, year);
    // }

    // @Override
    // public int revenueByYear(int year) {
    // return repository.revenueByYear(year);
    // }

    // @Override
    // public int revenueByQuarter(int which, int year) {
    // return repository.revenueByQuarter(which, year);
    // }

    @Override
    public List<TitleAndValue> revenueByMonthsInYear(int year) {
        List<TitleAndValue> list = new ArrayList<>();

        for (int i = 1; i <= 12; i++) {
            TitleAndValue t = new TitleAndValue("Tháng " + i + " năm " + year, repository.revenueByMonth(i, year));
            list.add(t);
        }

        return list;
    }

    @Override
    public List<TitleAndValue> revenueByYears(int fromYear, int toYear) {
        List<TitleAndValue> list = new ArrayList<>();

        for (int i = fromYear; i <= toYear; i++) {
            List<TitleAndValue> t = this.revenueByMonthsInYear(i);
            list.addAll(t);
        }

        return list;
    }

    @Override
    public List<TitleAndValue> revenueByQuarters(int year) {
        List<TitleAndValue> list = new ArrayList<>();

        for (int i = 1; i <= 4; i++) {
            TitleAndValue t = new TitleAndValue("Quý " + i + " năm " + year, repository.revenueByQuarter(i, year));
            list.add(t);
        }

        return list;
    }

}
