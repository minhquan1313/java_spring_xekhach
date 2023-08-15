package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.mtb.pojo.Ticket;
import com.mtb.pojo.TicketDetail;
import com.mtb.repository.TicketDetailRepository;

@Repository
@Transactional
public class TicketDetailRepositoryImpl implements TicketDetailRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    /**
     * params: ticketId
     */
    @Override
    public List<TicketDetail> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<TicketDetail> cq = cb.createQuery(TicketDetail.class);
        Root ticketDetail = cq.from(TicketDetail.class);
        cq.select(ticketDetail);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String ticketId = params.get("ticketId");
            if (ticketId != null && !ticketId.isEmpty()) {
                predicates.add(cb.equal(ticketDetail.get("ticketId"), Integer.parseInt(ticketId)));
            }

            cq.where(predicates.toArray(Predicate[]::new));
        }

        Query query = session.createQuery(cq);

        List<TicketDetail> list = query.getResultList();

        return list;
    }

    @Override
    public List<TicketDetail> getListByTicketId(int ticketId) {
        Map<String, String> params = new HashMap<>();
        params.put("ticketId", String.valueOf(ticketId));

        return this.getList(params);
    }

    @Override
    public TicketDetail getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(TicketDetail.class, id);
    }

    @Override
    public boolean addOrUpdate(TicketDetail item) {
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
        TicketDetail p = this.getById(id);

        try {
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

    @Override
    public int countByTicket(Ticket ticketId) {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(String.join(" ",
                        "",
                        "SELECT COUNT(*)",
                        "FROM TicketDetail",
                        "WHERE ticketId = :tId"))
                .setParameter("tId", ticketId);

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (NumberFormatException e) {
            return 0;
        }

    }

}
