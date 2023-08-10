package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.List;

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

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.TicketDetail;
import com.mtb.repository.BusSeatTripRepository;
import com.mtb.service.TicketDetailService;

@Repository
@Transactional
public class BusSeatTripRepositoryImp implements BusSeatTripRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Override
    public List<BusSeatTrip> getListByBusAndTripId(int busId, int tripId) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<BusSeatTrip> cq = cb.createQuery(BusSeatTrip.class);
        Root root = cq.from(BusSeatTrip.class);

        List<Predicate> predicates = new ArrayList<>();

        predicates.add(cb.equal(root.get("busId"), busId));
        predicates.add(cb.equal(root.get("tripId"), tripId));

        cq.where(predicates.toArray(Predicate[]::new));
        Query query = session.createQuery(cq);

        List<BusSeatTrip> list = query.getResultList();

        return list;
    }

    @Override
    public BusSeats getBusSeatsByBusAndTripId(int busId, int tripId) {
        List<BusSeatTrip> list = this.getListByBusAndTripId(busId, tripId);
        BusSeats busSeats = new BusSeats();

        int colTotal = 1;
        int rowTotal = 1;

        for (BusSeatTrip r : list) {
            int _x = r.getBusSeatX();
            int _y = r.getBusSeatY();
            int _id = r.getId();
            boolean available = r.getAvailable();

            if (colTotal < _x)
                colTotal = _x;
            if (rowTotal < _y)
                rowTotal = _y;

            busSeats.addPos(_id, _x, _y, available);
        }

        busSeats.setCol(colTotal);
        busSeats.setRow(rowTotal);

        return busSeats;
    }

    @Override
    public boolean makeMultipleSeatTrip(List<BusSeatTrip> list) {
        Session session = this.factory.getObject().getCurrentSession();

        try {
            for (BusSeatTrip item : list) {
                session.save(item);
            }
            return true;
        } catch (HibernateError e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean editMultipleSeatTrip(List<BusSeatTrip> list) {
        Session session = this.factory.getObject().getCurrentSession();

        try {
            for (BusSeatTrip item : list) {
                session.update(item);
            }
            return true;
        } catch (HibernateError e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delMultipleSeatTripByBusAndTripId(int busId, int tripId) {
        Session session = this.factory.getObject().getCurrentSession();

        List<BusSeatTrip> list = this.getListByBusAndTripId(busId, tripId);
        try {
            for (BusSeatTrip p : list) {
                session.delete(p);
            }
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

    @Override
    public int countSeatByBusAndTripId(int busId, int tripId) {
        Session session = this.factory.getObject().getCurrentSession();

        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
        Root root = cq.from(BusSeatTrip.class);

        List<Predicate> predicates = new ArrayList<>();

        predicates.add(cb.equal(root.get("busId"), busId));
        predicates.add(cb.equal(root.get("tripId"), tripId));

        cq.where(predicates.toArray(Predicate[]::new));
        cq.select(cb.count(root));
        Query query = session.createQuery(cq);

        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public BusSeatTrip getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(BusSeatTrip.class, id);
    }

    @Override
    public boolean addOrUpdate(BusSeatTrip item) {
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
    public BusSeats getBusSeats(int busId, int tripId, int ticketId) {
        BusSeats busSeats = this.getBusSeatsByBusAndTripId(busId, tripId);

        List<TicketDetail> ticketDetails = ticketDetailService.getListByTicketId(ticketId);
        List<Integer> seatIds = new ArrayList<>();
        for (TicketDetail ticketDetail : ticketDetails) {
            int seatId = ticketDetail.getBusSeatTripId().getId();
            seatIds.add(seatId);
        }

        busSeats.getArray().forEach(r -> {
            if (seatIds.contains(r.getId())) {
                r.setUserChosen(true);
            }
        });

        return busSeats;
    }
}
