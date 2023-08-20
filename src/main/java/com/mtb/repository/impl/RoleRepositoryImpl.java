/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.repository.impl;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.pojo.Role;
import com.mtb.repository.RoleRepository;

/**
 *
 * @author Duc Hung
 */
@Repository
@Transactional
public class RoleRepositoryImpl implements RoleRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Role> getRoles() {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From Role");

        return q.getResultList();
    }

    @Override
    public boolean addOrUpdateRole(Role r) {
        Session s = this.factory.getObject().getCurrentSession();
        try {
            if (r.getId() == null) {
                s.save(r);
            } else {
                s.update(r);
            }

            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }

    }

    @Override
    public Role getRoleById(int id) {
        Session s = this.factory.getObject().getCurrentSession();
        return s.get(Role.class, id);
    }

    @Override
    public boolean deleteRole(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        Role role = this.getRoleById(id);
        try {
            session.delete(role);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public Role getRoleByTitle(String title) {

        Session s = this.factory.getObject().getCurrentSession();
        Query q = s
                .createQuery(String.join(" ",
                        "",
                        "FROM Role",
                        "WHERE title=:un"))
                .setParameter("un", title);

        try {
            return (Role) q.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
