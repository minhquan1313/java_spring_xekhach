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

import com.mtb.pojo.Route;
import com.mtb.repository.RouteRepository;

@Repository
@Transactional
public class RouteRepositoryImpl implements RouteRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Route> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Route> cq = cb.createQuery(Route.class);
        Root root = cq.from(Route.class);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String orderBy = params.get("orderBy");
            String order = params.get("order");

            if (order != null && !order.isEmpty()) {
                if (order != null && order == "desc")
                    cq.orderBy(cb.desc(root.get(orderBy)));
                else
                    cq.orderBy(cb.asc(root.get(orderBy)));

                cq.where(predicates.toArray(Predicate[]::new));
            }
        }

        Query query = session.createQuery(cq);

        List<Route> list = query.getResultList();

        return list;

        // Session session = this.factory.getObject().getCurrentSession();
        // Query q = session.createQuery("FROM Route");

        // return q.getResultList();
    }

    @Override
    public Route getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Route.class, id);
    }

    @Override
    public boolean addOrUpdate(Route item) {
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
        Route p = this.getById(id);

        try {
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }
}
