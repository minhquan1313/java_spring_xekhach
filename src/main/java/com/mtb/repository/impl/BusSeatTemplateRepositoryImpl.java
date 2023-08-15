package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateError;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTemplate;
import com.mtb.repository.BusSeatTemplateRepository;

@Repository
@Transactional
public class BusSeatTemplateRepositoryImpl implements BusSeatTemplateRepository {
    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<BusSeatTemplate> getListByBusId(int busId) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<BusSeatTemplate> cq = cb.createQuery(BusSeatTemplate.class);
        Root root = cq.from(BusSeatTemplate.class);

        List<Predicate> predicates = new ArrayList<>();

        predicates.add(cb.equal(root.get("busId"), busId));

        cq.where(predicates.toArray(Predicate[]::new));
        Query query = session.createQuery(cq);

        List<BusSeatTemplate> list = query.getResultList();

        return list;
    }

    @Override
    public BusSeats getBusSeatsByBusId(int id) {
        List<BusSeatTemplate> list = this.getListByBusId(id);
        BusSeats busSeats = new BusSeats();

        int x = 1;
        int y = 1;

        for (BusSeatTemplate r : list) {
            int _x = r.getBusSeatX();
            int _y = r.getBusSeatY();

            if (x < _x)
                x = _x;
            if (y < _y)
                y = _y;

            busSeats.addPos(_x, _y);
        }

        busSeats.setCol(x);
        busSeats.setRow(y);

        return busSeats;
    }

    @Override
    public int countSeatByBusId(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(String.join(" ",
                        "",
                        "SELECT COUNT(*)",
                        "FROM BusSeatTemplate",
                        "WHERE busId.id=:busId"))
                .setParameter("busId", id);

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    public boolean makeMultipleSeatTemplate(List<BusSeatTemplate> list) {
        Session session = this.factory.getObject().getCurrentSession();

        try {
            for (BusSeatTemplate busSeatTemplate : list) {
                session.save(busSeatTemplate);
            }
            return true;
        } catch (HibernateError e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delMultipleSeatTemplateByBusId(int busId) {
        Session session = this.factory.getObject().getCurrentSession();

        List<BusSeatTemplate> list = this.getListByBusId(busId);
        try {
            for (BusSeatTemplate p : list) {
                session.delete(p);
            }
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }
}
