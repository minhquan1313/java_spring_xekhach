package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import com.mtb.pojo.Bus;
import com.mtb.pojo.BusSeatTemplate;
import com.mtb.repository.BusRepository;
import com.mtb.service.BusSeatTemplateService;
import com.mtb.service.BusSeatTripService;

@Repository
@Transactional
public class BusRepositoryImpl implements BusRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Autowired
    BusSeatTemplateService busSeatTemplateService;

    @Autowired
    BusSeatTripService busSeatTripService;

    @Override
    public List<Bus> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Bus> cq = cb.createQuery(Bus.class);
        Root bus = cq.from(Bus.class);
        cq.select(bus);

        if (params != null) {

            List<Predicate> predicates = new ArrayList<>();

            String id = params.get("id");
            if (id != null && !id.isEmpty()) {
                predicates.add(cb.equal(bus.get("id"), Integer.parseInt(id)));
            }

            cq.where(predicates.toArray(Predicate[]::new));
        }

        Query qBus = session.createQuery(cq);
        List<Bus> list = qBus.getResultList();

        if (params != null) {
            String getSeats = params.get("getSeats");
            if (getSeats != null) {
                list.forEach(r -> {
                    List<BusSeatTemplate> seatTemplates = busSeatTemplateService.getListByBusId(r.getId());
                    Set<BusSeatTemplate> targetSet = new HashSet<>(seatTemplates);
                    r.setBusSeatTemplateSet(targetSet);
                });
            }

            String busSeatTemplateCount = params.get("busSeatTemplateCount");
            if (busSeatTemplateCount != null) {
                list.forEach(r -> r.setBusSeatTemplateCount(busSeatTemplateService.countSeatByBusId(r.getId())));
            }
        }

        return list;
    }

    @Override
    public Bus getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Bus.class, id);
    }

    @Override
    public Bus addOrUpdate(Bus item) {
        Session session = this.factory.getObject().getCurrentSession();
        try {
            if (item.getId() == null) {
                // Create new
                session.save(item);
                return item;
            }

            // Update
            session.update(item);
            return item;
        } catch (HibernateError e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean deleteById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        Bus p = this.getById(id);

        try {
            busSeatTemplateService.delMultipleSeatTemplateByBusId(id);
            session.delete(p);

            return true;
        } catch (HibernateException e) {
            return false;
        }
    }
}
