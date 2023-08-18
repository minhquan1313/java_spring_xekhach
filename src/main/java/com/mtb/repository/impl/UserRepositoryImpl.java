/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.pojo.User;
import com.mtb.repository.UserRepository;

/**
 *
 * @author Duc Hung
 */
@Repository
@Transactional
@PropertySource("classpath:configs.properties")
public class UserRepositoryImpl implements UserRepository {

    @Autowired
    private LocalSessionFactoryBean factory;
    // @Autowired
    // private Environment env;

    public List<User> getUsers(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<User> q = b.createQuery(User.class);
        Root root = q.from(User.class);
        q.select(root);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String username = params.get("username");
            if (username != null && !username.isEmpty()) {
                predicates.add(b.equal(root.get("username"), username));
            }

            String firstName = params.get("firstName");
            if (firstName != null && !firstName.isEmpty()) {
                predicates.add(b.like(root.get("firstName"), String.format("%%%s%%", firstName)));
            }

            String lastName = params.get("lastName");
            if (lastName != null && !lastName.isEmpty()) {
                predicates.add(b.like(root.get("lastName"), String.format("%%%s%%", lastName)));
            }

            String password = params.get("password");
            if (password != null && !password.isEmpty()) {
                predicates.add(b.equal(root.get("password"), password));
            }

            String roleId = params.get("roleId");
            if (roleId != null && !roleId.isEmpty()) {
                predicates.add(b.equal(root.get("roleId"), Integer.parseInt(roleId)));
            }
            q.where(predicates.toArray(Predicate[]::new));
        }

        // q.orderBy(b.desc(root.get("id")));
        Query query = session.createQuery(q);

        // if (params != null) {
        // String p = params.get("page");
        // if (p != null && !p.isEmpty()) {
        // int pageNumber = Integer.parseInt(p);
        // int pageSize = Integer.parseInt(this.env.getProperty("PAGE_SIZE"));
        //
        // query.setMaxResults(pageSize);
        // query.setFirstResult((pageNumber - 1) * pageSize);
        // }
        // }
        return query.getResultList();
    }

    @Override
    public int countUser() {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session.createQuery("SELECT Count(*) FROM User");

        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public boolean addOrUpdateUser(User u) {
        Session s = this.factory.getObject().getCurrentSession();
        try {
            if (u.getId() == null) {
                s.save(u);
            } else {

                s.update(u);
            }

            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public User getUserById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(User.class, id);
    }

    @Override
    public boolean deleteUser(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        User user = this.getUserById(id);
        try {
            session.delete(user);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public List<User> searchUsers(Map<String, String> params, String id, String kw, String role) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<User> q = b.createQuery(User.class);
        Root root = q.from(User.class);
        q.select(root);
        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            if (id != null && !id.isEmpty()) {
                predicates.add(b.equal(root.get("id"), Integer.parseInt(id)));
            }

            if (kw != null && !kw.isEmpty()) {
                String pattern = "%" + kw + "%";
                predicates.add(b.or(
                        b.like(b.lower(root.get("username")), pattern),
                        b.like(b.lower(root.get("firstName")), pattern),
                        b.like(b.lower(root.get("lastName")), pattern)));

            }
            if (role != null && !role.isEmpty()) {
                predicates.add(b.equal(root.get("roleId"), Integer.parseInt(role)));
            }
            if (!predicates.isEmpty()) {
                q.where(b.and(predicates.toArray(Predicate[]::new)));
            }

        }
        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public User getUserByUsername(String username) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From User Where username=:un");
        q.setParameter("un", username);

        try {
            User singleResult = (User) q.getSingleResult();
            return singleResult;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public User getUserByUsernameAndPassword(String username, String password) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s
                .createQuery(String.join(" ",
                        "",
                        "FROM User",
                        "WHERE username=:un",
                        "AND password=:pass"))
                .setParameter("un", username)
                .setParameter("pass", password);

        try {
            return (User) q.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
