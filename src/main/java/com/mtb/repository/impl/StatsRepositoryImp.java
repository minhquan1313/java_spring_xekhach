package com.mtb.repository.impl;

import java.text.SimpleDateFormat;

import javax.persistence.Query;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.repository.StatsRepository;

@Repository
@Transactional
public class StatsRepositoryImp implements StatsRepository {
    @Autowired
    private LocalSessionFactoryBean factory;

    @Autowired
    private SimpleDateFormat FORMAT;

    @Override
    public int revenueByMonth(int month, int year) {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(String.join(" ",
                        "",
                        "SELECT SUM(paidPrice)",
                        "FROM Ticket",
                        "WHERE YEAR(createdAt) = :year AND",
                        "MONTH(createdAt) = :month"))
                .setParameter("year", year)
                .setParameter("month", month);

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public int revenueByYear(int year) {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(String.join(" ",
                        "",
                        "SELECT SUM(paidPrice)",
                        "FROM Ticket",
                        "WHERE YEAR(createdAt) = :year"))
                .setParameter("year", year);

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public int revenueByQuarter(int which, int year) {
        Session session = this.factory.getObject().getCurrentSession();
        int from = 1, to = 1;

        switch (which) {
            case 1:
                from = 1;
                to = 3;
                break;
            case 2:
                from = 4;
                to = 6;
                break;
            case 3:
                from = 7;
                to = 9;
                break;
            case 4:
                from = 10;
                to = 12;
                break;
        }

        Query query = session
                .createQuery(String.join(" ",
                        "",
                        "SELECT SUM(paidPrice)",
                        "FROM Ticket",
                        "WHERE YEAR(createdAt) = :year AND",
                        "MONTH(createdAt) >= :from AND",
                        "MONTH(createdAt) <= :to"))
                .setParameter("year", year)
                .setParameter("from", from)
                .setParameter("to", to);

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (Exception e) {
            return 0;
        }
    }
}
