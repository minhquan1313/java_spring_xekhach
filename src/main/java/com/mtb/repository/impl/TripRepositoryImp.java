package com.mtb.repository.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateError;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mtb.pojo.BusSeatTrip;
import com.mtb.pojo.Route;
import com.mtb.pojo.Trip;
import com.mtb.pojo.Trip_;
import com.mtb.repository.TripRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.RouteService;
import com.mtb.service.TicketService;

@Repository
@Transactional
public class TripRepositoryImp implements TripRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private RouteService routeService;

    @Autowired
    private TicketService ticketService;

    /**
     * params: startLocation | endLocation | busId | fromPrice | toPrice |
     * driverId | timeFrom | timeTo | id
     */
    @Override
    public List<Trip> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Trip> cq = cb.createQuery(Trip.class);
        Root trip = cq.from(Trip.class);

        if (params != null && !params.isEmpty()) {
            List<Predicate> predicates = new ArrayList<>();

            String startLocation = params.get("startLocation");
            if (startLocation != null && !startLocation.isEmpty()) {
                // IN Clause 1st method
                Map<String, String> routeParams = new HashMap<>();
                routeParams.put("start_location", startLocation);
                List<Route> routesToMatch = routeService.getList(routeParams);

                In<Integer> inClause = cb.in(trip.get("routeId"));
                for (Route r : routesToMatch) {
                    inClause.value(r.getId());
                }

                predicates.add(inClause);
            }

            String endLocation = params.get("endLocation");
            if (endLocation != null && !endLocation.isEmpty()) {
                // IN Clause 2nd method
                Expression<String> routeId = trip.get(Trip_.routeId);
                Map<String, String> routeParams = new HashMap<>();
                routeParams.put("end_location", endLocation);

                List<Route> routesToMatch = routeService.getList(routeParams);
                List<Integer> routeIdToMatch = new ArrayList<>();
                for (Route r : routesToMatch) {
                    routeIdToMatch.add(r.getId());
                }

                predicates.add(routeId.in(routeIdToMatch));

            }

            String id = params.get("id");
            if (id != null && !id.isEmpty()) {
                predicates.add(cb.equal(trip.get("id"), Integer.parseInt(id)));
            }

            String busId = params.get("busId");
            if (busId != null && !busId.isEmpty()) {
                predicates.add(cb.equal(trip.get("busId"), Integer.parseInt(busId)));
            }

            String fromPrice = params.get("fromPrice");
            if (fromPrice != null && !fromPrice.isEmpty()) {
                predicates.add(cb.greaterThanOrEqualTo(trip.get("price"), Integer.parseInt(fromPrice)));
            }

            String toPrice = params.get("toPrice");
            if (toPrice != null && !toPrice.isEmpty()) {
                predicates.add(cb.lessThanOrEqualTo(trip.get("price"), Integer.parseInt(toPrice)));
            }

            String driverId = params.get("driverId");
            if (driverId != null && !driverId.isEmpty()) {
                predicates.add(cb.equal(trip.get("driverId"), Integer.parseInt(driverId)));
            }

            String timeFrom = params.get("timeFrom");
            if (timeFrom != null && !timeFrom.isEmpty()) {
                Date time = new Date(Long.parseLong(timeFrom));
                predicates.add(cb.greaterThanOrEqualTo(trip.get("startAt"), time));
            }

            String timeTo = params.get("timeTo");
            if (timeTo != null && !timeTo.isEmpty()) {
                Date time = new Date(Long.parseLong(timeTo));
                predicates.add(cb.lessThanOrEqualTo(trip.get("startAt"), time));
            }

            cq.where(predicates.toArray(Predicate[]::new));
        }

        Query query = session.createQuery(cq);

        List<Trip> list = query.getResultList();

        list.forEach(_trip -> {
            int bId = _trip.getBusId().getId();
            int tId = _trip.getId();

            _trip.getBusId()
                    .setBusSeatTripCount(busSeatTripService.countSeatById(bId, tId));
        });

        if (params != null) {
            if (params.get("getSeats") != null) {
                list.forEach(r -> {
                    int bid = r.getBusId().getId();
                    int tid = r.getId();
                    r.getBusId().setBusSeats(busSeatTripService.getBusSeats(bid, tid));
                });
            }

            if (params.get("extraPrice") != null) {
                list.forEach(r -> {
                    r.setExtraPrice(ticketService.getExtraPrice(r.getStartAt()));
                });
            }
        }

        return list;
    }

    @Override
    public Trip getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        Trip trip = session.get(Trip.class, id);

        Integer busId = trip.getBusId().getId();
        List<BusSeatTrip> listByBusAndTripId = busSeatTripService.getListByBusAndTripId(busId, id);
        trip.getBusId().setBusSeatTripSet(new HashSet<>(listByBusAndTripId));

        return trip;
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
            busSeatTripService.delMultipleSeatTrip(p.getBusId().getId(), p.getId());
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

    @Override
    public int getLowestPrice() {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(
                        "SELECT MIN(price) FROM Trip");

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    public int getHightestPrice() {
        Session session = this.factory.getObject().getCurrentSession();
        Query query = session
                .createQuery(
                        "SELECT MAX(price) FROM Trip");

        try {
            int parseInt = Integer.parseInt(query.getSingleResult().toString());
            return parseInt;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Object[]> countTripsByRoute() {
        String queryString = "SELECT t.routeId.id, COUNT(*) AS trip_count FROM Trip t GROUP BY t.routeId";
        Query query = entityManager.createQuery(queryString);

        return query.getResultList();
    }
}
