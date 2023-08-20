package com.mtb.repository.impl;

import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

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

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;
import com.mtb.pojo.Ticket;
import com.mtb.repository.TicketRepository;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.TicketDetailService;

@Repository
@Transactional
public class TicketRepositoryImpl implements TicketRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Override
    public List<Ticket> getList(Map<String, String> params) {
        Session session = this.factory.getObject().getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Ticket> cq = cb.createQuery(Ticket.class);
        Root ticket = cq.from(Ticket.class);
        cq.select(ticket);

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();

            String id = params.get("id");
            if (id != null && !id.isEmpty()) {
                predicates.add(cb.equal(ticket.get("id"), Integer.parseInt(id)));
            }

            String userId = params.get("userId");
            if (userId != null && !userId.isEmpty()) {
                predicates.add(cb.equal(ticket.get("userId"), Integer.parseInt(userId)));
            }

            // String totalSeat = params.get("totalSeat");
            // if (totalSeat != null && !totalSeat.isEmpty()) {
            // predicates.add(cb.equal(ticket.get("userId"), Integer.parseInt(userId)));
            // }

            cq.where(predicates.toArray(Predicate[]::new));
        }

        Query query = session.createQuery(cq);

        List<Ticket> list = query.getResultList();

        if (params != null) {

            String totalSeat = params.get("totalSeat");
            if (totalSeat != null) {

                list.forEach(r -> {
                    int c = ticketDetailService.countByTicketId(r.getId());

                    r.setTotalSeat(c);
                });
            }

            String busSeat = params.get("busSeat");
            if (busSeat != null) {

                list.forEach(r -> {

                    int busId = r.getTripId().getBusId().getId();
                    int tripId = r.getTripId().getId();
                    int ticketId = r.getId();

                    r.getTripId().getBusId().setBusSeats(busSeatTripService.getBusSeats(busId, tripId, ticketId));
                });
            }

        }

        return list;
    }

    @Override
    public Ticket getById(int id) {
        Session session = this.factory.getObject().getCurrentSession();
        return session.get(Ticket.class, id);
    }

    @Override
    public boolean addOrUpdate(Ticket item) {
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
        Ticket p = this.getById(id);

        try {
            session.delete(p);
            return true;
        } catch (HibernateException e) {
            return false;
        }
    }

    @Override
    public void exportTicketsToPdf(Ticket t, OutputStream outputStream) throws DocumentException {
        Document document = new Document();
        PdfWriter.getInstance(document, outputStream);
        document.open();

        URL fontUrl = getClass().getClassLoader().getResource("vuArial.ttf");
        String fontPath = fontUrl.getPath();
        BaseFont bf = null;
        try {
            bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        } catch (IOException ex) {
            Logger.getLogger(UserRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        Font f = new Font(bf, 25, Font.BOLD, Color.blue);
        Font f1 = new Font(bf, 20, Font.NORMAL);
        Font f2 = new Font(bf, 15, Font.ITALIC, Color.CYAN);
        Font f3 = new Font(bf, 15, Font.NORMAL);

        Chunk txt1 = new Chunk("(Giá đã bao gồm thuế VAT và BHHK)", f2);

        Date timeNow = new Date();
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
        String formatTime = format.format(timeNow);

        Paragraph title = new Paragraph("VÉ XE KHÁCH JAVA SPRING", f);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20f);
        document.add(title);

        Paragraph id = new Paragraph("Mã vé: " + t.getId(), f1);
        id.setAlignment(Element.ALIGN_LEFT);
        id.setIndentationLeft(50f);
        document.add(id);

        Paragraph fullName = new Paragraph(
                "Họ tên hành khách: " + t.getUserId().getLastName() + " " + t.getUserId().getFirstName(), f1);
        fullName.setAlignment(Element.ALIGN_LEFT);
        fullName.setIndentationLeft(50f);
        document.add(fullName);

        Paragraph routeTitle = new Paragraph("Tuyến: " + t.getTripId().getRouteId().getStartLocation() + " - "
                + t.getTripId().getRouteId().getEndLocation(), f1);
        routeTitle.setAlignment(Element.ALIGN_LEFT);
        routeTitle.setIndentationLeft(50f);
        document.add(routeTitle);

        Paragraph bus = new Paragraph("Số xe: " + t.getTripId().getBusId().getLicensePlate(), f1);
        bus.setAlignment(Element.ALIGN_LEFT);
        bus.setIndentationLeft(50f);
        document.add(bus);

        String formatTimeStart = format.format(t.getTripId().getStartAt());
        Paragraph timeStart = new Paragraph("Giờ khởi hành: " + formatTimeStart, f1);
        timeStart.setAlignment(Element.ALIGN_LEFT);
        timeStart.setIndentationLeft(50f);
        document.add(timeStart);

        Paragraph paidPrice = new Paragraph("Giá tiền: " + t.getPaidPrice() + " VNĐ", f1);
        paidPrice.setAlignment(Element.ALIGN_LEFT);
        paidPrice.setIndentationLeft(50f);
        paidPrice.add(" ");
        paidPrice.add(txt1);
        document.add(paidPrice);

        Paragraph paidWith = new Paragraph("Phương thức thanh toán: " + t.getPaidWith(), f1);
        paidWith.setAlignment(Element.ALIGN_LEFT);
        paidWith.setIndentationLeft(50f);
        paidWith.setSpacingAfter(20f);
        document.add(paidWith);

        Paragraph time = new Paragraph("Thời gian in vé: " + formatTime, f3);
        time.setAlignment(Element.ALIGN_RIGHT);
        time.setIndentationRight(50f);
        document.add(time);

        Paragraph txt2 = new Paragraph("NGƯỜI BÁN", f3);
        txt2.setAlignment(Element.ALIGN_RIGHT);
        txt2.setIndentationRight(130f);
        document.add(txt2);

        Paragraph staff = new Paragraph(t.getStaffId().getLastName() + " " + t.getStaffId().getFirstName(), f3);
        staff.setAlignment(Element.ALIGN_RIGHT);
        staff.setIndentationRight(140f);
        document.add(staff);

        document.close();
    }
}
