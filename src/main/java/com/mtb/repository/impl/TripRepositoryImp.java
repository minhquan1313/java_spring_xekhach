package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

import com.mtb.pojo.Trip;
import com.mtb.repository.TripRepository;

@Repository
@Transactional
public class TripRepositoryImp implements TripRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Trip> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Trip> cq = cb.createQuery(Trip.class);
        Root root = cq.from(Trip.class);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            cq.where(predicates.toArray(Predicate[]::new));
        }

        Query query = session.createQuery(cq);

        List<Trip> list = query.getResultList();

        return list;
    }

    @Override
    public Trip getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Trip.class, id);
    }

    @Override
    public boolean addOrUpdate(Trip item) {
        Session session = this.factory.getObject().getCurrentSession();
        try {
            if (item.getId() == null) {
                // Create new
                session.save(item);
                return true;
            }

            // Update
            session.update(item);
            return true;
        } catch (HibernateError e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        Trip p = this.getById(id);

        try {
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

}
