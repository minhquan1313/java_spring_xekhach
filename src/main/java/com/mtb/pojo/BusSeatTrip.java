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
@Table(name = "bus_seat_trip")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BusSeatTrip.findAll", query = "SELECT b FROM BusSeatTrip b"),
    @NamedQuery(name = "BusSeatTrip.findById", query = "SELECT b FROM BusSeatTrip b WHERE b.id = :id"),
    @NamedQuery(name = "BusSeatTrip.findByBusSeatX", query = "SELECT b FROM BusSeatTrip b WHERE b.busSeatX = :busSeatX"),
    @NamedQuery(name = "BusSeatTrip.findByBusSeatY", query = "SELECT b FROM BusSeatTrip b WHERE b.busSeatY = :busSeatY"),
    @NamedQuery(name = "BusSeatTrip.findByAvailable", query = "SELECT b FROM BusSeatTrip b WHERE b.available = :available")})
public class BusSeatTrip implements Serializable {

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
    @Basic(optional = false)
    @NotNull
    @Column(name = "available")
    private boolean available;
    @JoinColumn(name = "bus_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Bus busId;
    @JoinColumn(name = "trip_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Trip tripId;

    public BusSeatTrip() {
    }

    public BusSeatTrip(Integer id) {
        this.id = id;
    }

    public BusSeatTrip(Integer id, int busSeatX, int busSeatY, boolean available) {
        this.id = id;
        this.busSeatX = busSeatX;
        this.busSeatY = busSeatY;
        this.available = available;
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

    public boolean getAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public Bus getBusId() {
        return busId;
    }

    public void setBusId(Bus busId) {
        this.busId = busId;
    }

    public Trip getTripId() {
        return tripId;
    }

    public void setTripId(Trip tripId) {
        this.tripId = tripId;
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
        if (!(object instanceof BusSeatTrip)) {
            return false;
        }
        BusSeatTrip other = (BusSeatTrip) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.mtb.pojo.BusSeatTrip[ id=" + id + " ]";
    }

}
