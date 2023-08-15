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
        Root route = cq.from(Route.class);
        cq.select(route);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String orderBy = params.get("orderBy");
            String orderByAlt = params.get("orderByAlt");
            String order = params.get("order");

            if (order != null && !order.isEmpty()) {
                if (order != null && order == "desc") {
                    if (orderByAlt != null && !orderByAlt.isEmpty()) {
                        cq.orderBy(cb.desc(route.get(orderBy)), cb.asc(route.get(orderByAlt)));
                    } else {
                        cq.orderBy(cb.desc(route.get(orderBy)));
                    }
                } else
                    cq.orderBy(cb.asc(route.get(orderBy)), cb.asc(route.get(orderByAlt)));

                cq.where(predicates.toArray(Predicate[]::new));
            }
            String start_location = params.get("start_location");
            if (start_location != null && !start_location.isEmpty()) {
                predicates.add(cb.like(route.get("startLocation"), "%%" + start_location + "%%"));

            }

            String end_location = params.get("end_location");
            if (end_location != null && !end_location.isEmpty()) {
                predicates.add(cb.like(route.get("endLocation"), "%%" + end_location + "%%"));
            }
            cq.where(predicates.toArray(Predicate[]::new));
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

    @Override
    public List<Route> getListStart() {
        Session session = this.factory.getObject().getCurrentSession();
        // SELECT *
        // FROM route
        // WHERE id IN (
        // SELECT MIN(id) as id
        // FROM route
        // GROUP BY start_location
        // )
        Query query = session
                .createQuery(
                        String.join(" ",
                                "",
                                "FROM Route",
                                "WHERE id IN",
                                "(",
                                "SELECT MIN(id) as id",
                                "FROM Route",
                                "GROUP BY startLocation",
                                ")",
                                "ORDER BY startLocation ASC"));
        List<Route> resultList = query.getResultList();
        return resultList;
    }

    @Override
    public List<Route> getListEnd() {
        Session session = this.factory.getObject().getCurrentSession();

        Query query = session
                .createQuery(
                        "FROM Route WHERE id IN (SELECT MIN(id) as id FROM Route GROUP BY endLocation) ORDER BY endLocation ASC");
        List<Route> resultList = query.getResultList();
        return resultList;
    }
}
