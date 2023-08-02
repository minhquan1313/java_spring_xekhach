package com.mtb.repository.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.hibernate.HibernateError;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.pojo.Bus;
import com.mtb.repository.BusRepository;

@Repository
@Transactional
public class BusRepositoryImpl implements BusRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Bus> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        Query q = session.createQuery("FROM Bus");

        return q.getResultList();
    }

    @Override
    public Bus getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Bus.class, id);
    }

    @Override
    public boolean addOrUpdate(Bus item) {
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
        Bus p = this.getById(id);

        try {
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

}
