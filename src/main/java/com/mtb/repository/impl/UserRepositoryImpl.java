/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.repository.impl;

import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
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

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
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

            String kw = params.get("kw");
            if (kw != null && !kw.isEmpty()) {
                predicates.add(b.like(root.get("username"), String.format("%%%s%%", kw)));
            }

            String username = params.get("username");
            if (username != null && !username.isEmpty()) {
                predicates.add(b.like(root.get("username"), String.format("%%%s%%", username)));
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
                predicates.add(b.like(root.get("password"), String.format("%%%s%%", password)));
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
    public void exportUsersToPdf(User u, OutputStream outputStream) throws DocumentException {
        Document document = new Document();
        PdfWriter.getInstance(document, outputStream);
        document.open();

        BaseFont bf = null;
        try {
            bf = BaseFont.createFont("D:\\java_spring_xekhach\\java_spring_xekhach\\src\\main\\resources\\vuArial.ttf",
                    BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
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

        Paragraph id = new Paragraph("Id: " + u.getId(), f1);
        id.setAlignment(Element.ALIGN_LEFT);
        id.setIndentationLeft(50f);
        document.add(id);

        Paragraph fullName = new Paragraph("Họ tên: " + u.getLastName() + " " + u.getFirstName(), f1);
        fullName.setAlignment(Element.ALIGN_LEFT);
        fullName.setIndentationLeft(50f);
        document.add(fullName);

        Paragraph username = new Paragraph("Tài khoản: " + u.getUsername(), f1);
        username.setAlignment(Element.ALIGN_LEFT);
        username.setIndentationLeft(50f);
        document.add(username);

        Paragraph password = new Paragraph("Password: " + u.getPassword(), f1);
        password.setAlignment(Element.ALIGN_LEFT);
        password.setIndentationLeft(50f);
        document.add(password);

        Paragraph role = new Paragraph("Vai trò: " + u.getRoleId().getTitle(), f1);
        role.setAlignment(Element.ALIGN_LEFT);
        role.setIndentationLeft(50f);
        role.setSpacingAfter(20f);
        role.add(" ");
        role.add(txt1);
        document.add(role);

        Paragraph time = new Paragraph("Thời gian in vé: " + formatTime, f3);
        time.setAlignment(Element.ALIGN_RIGHT);
        time.setIndentationRight(50f);
        document.add(time);

        Paragraph txt2 = new Paragraph("NGƯỜI BÁN", f3);
        txt2.setAlignment(Element.ALIGN_RIGHT);
        txt2.setIndentationRight(130f);
        document.add(txt2);

        document.close();
    }

    @Override
    public User getUserByUsername(String username) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From User Where username=:un");
        q.setParameter("un", username);

        return (User) q.getSingleResult();
    }
}
