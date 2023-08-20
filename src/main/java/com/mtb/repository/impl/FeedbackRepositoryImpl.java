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
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.pojo.Feedback;
import com.mtb.repository.FeedbackRepository;

/**
 *
 * @author Duc Hung
 */
@Repository
@Transactional
public class FeedbackRepositoryImpl implements FeedbackRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Feedback> getFeedbacks(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Feedback> q = b.createQuery(Feedback.class);
        Root root = q.from(Feedback.class);
        q.select(root);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String comment = params.get("comment");
            if (comment != null && !comment.isEmpty()) {
                predicates.add(b.like(root.get("comment"), String.format("%%%s%%", comment)));
            }

            String ticketId = params.get("ticketId");
            if (ticketId != null && !ticketId.isEmpty()) {
                predicates.add(b.equal(root.get("ticketId"), Integer.parseInt(ticketId)));
            }
            q.where(predicates.toArray(Predicate[]::new));
        }

        // q.orderBy(b.desc(root.get("id")));
        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public Feedback getFeedbackById(int id) {
        Session s = this.factory.getObject().getCurrentSession();
        return s.get(Feedback.class, id);
    }

    @Override
    public boolean addOrUpdateFeedback(Feedback f) {
        Session s = this.factory.getObject().getCurrentSession();
        try {
            if (f.getId() == null) {
                s.save(f);
            } else {

                s.update(f);
            }

            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteFeedback(int id) {
        Session s = this.factory.getObject().getCurrentSession();
        Feedback f = this.getFeedbackById(id);
        try {
            s.delete(f);
            return true;
        } catch (HibernateException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Feedback> getFeedbacksForTrip(Map<String, String> params, String id) {
        Session s = this.factory.getObject().getCurrentSession();

        CriteriaBuilder b = s.getCriteriaBuilder();
        CriteriaQuery<Feedback> q = b.createQuery(Feedback.class);
        Root root = q.from(Feedback.class);
        q.select(root);
        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            if (id != null && !id.isEmpty()) {
                predicates.add(b.equal(root.get("ticketId").get("tripId"), Integer.parseInt(id)));
            }

            if (!predicates.isEmpty()) {
                q.where(b.and(predicates.toArray(Predicate[]::new)));
            }
        }
        Query query = s.createQuery(q);
        return query.getResultList();
    }

}
