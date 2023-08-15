/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.pojo;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Binh
 */
@Entity
@Table(name = "bus_seat_template")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BusSeatTemplate.findAll", query = "SELECT b FROM BusSeatTemplate b"),
    @NamedQuery(name = "BusSeatTemplate.findById", query = "SELECT b FROM BusSeatTemplate b WHERE b.id = :id"),
    @NamedQuery(name = "BusSeatTemplate.findByBusSeatX", query = "SELECT b FROM BusSeatTemplate b WHERE b.busSeatX = :busSeatX"),
    @NamedQuery(name = "BusSeatTemplate.findByBusSeatY", query = "SELECT b FROM BusSeatTemplate b WHERE b.busSeatY = :busSeatY")})
public class BusSeatTemplate implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "bus_seat_x")
    private int busSeatX;
    @Basic(optional = false)
    @NotNull
    @Column(name = "bus_seat_y")
    private int busSeatY;
    @JoinColumn(name = "bus_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Bus busId;

    public BusSeatTemplate() {
    }

    public BusSeatTemplate(Integer id) {
        this.id = id;
    }

    public BusSeatTemplate(Integer id, int busSeatX, int busSeatY) {
        this.id = id;
        this.busSeatX = busSeatX;
        this.busSeatY = busSeatY;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getBusSeatX() {
        return busSeatX;
    }

    public void setBusSeatX(int busSeatX) {
        this.busSeatX = busSeatX;
    }

    public int getBusSeatY() {
        return busSeatY;
    }

    public void setBusSeatY(int busSeatY) {
        this.busSeatY = busSeatY;
    }

    public Bus getBusId() {
        return busId;
    }

    public void setBusId(Bus busId) {
        this.busId = busId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BusSeatTemplate)) {
            return false;
        }
        BusSeatTemplate other = (BusSeatTemplate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.mtb.pojo.BusSeatTemplate[ id=" + id + " ]";
    }

}
