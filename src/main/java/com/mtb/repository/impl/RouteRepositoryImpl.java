package com.mtb.repository.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

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
        Query q = session.createQuery("FROM Route");

        return q.getResultList();
    }
}
