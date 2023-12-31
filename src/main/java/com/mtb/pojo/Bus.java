/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.pojo;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mtb.myObject.BusSeats;

/**
 *
 * @author Binh
 */
@Entity
@Table(name = "bus")
@XmlRootElement
@NamedQueries({
        @NamedQuery(name = "Bus.findAll", query = "SELECT b FROM Bus b"),
        @NamedQuery(name = "Bus.findById", query = "SELECT b FROM Bus b WHERE b.id = :id"),
        @NamedQuery(name = "Bus.findByLicensePlate", query = "SELECT b FROM Bus b WHERE b.licensePlate = :licensePlate"),
        @NamedQuery(name = "Bus.findByImage", query = "SELECT b FROM Bus b WHERE b.image = :image") })
public class Bus implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull(message = "{bus.licensePlate.notNull}")
    @Size(min = 1, max = 50, message = "{bus.licensePlate.lenErr}")
    @Column(name = "license_plate")
    private String licensePlate;
    @Size(max = 200, message = "{bus.image.lenErr}")
    @Column(name = "image")
    private String image;
    @OneToMany(mappedBy = "busId")

    @JsonIgnore
    private Set<Trip> tripSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "busId")

    @JsonIgnore
    private Set<BusSeatTemplate> busSeatTemplateSet;

    @JsonIgnore
    @OneToMany(mappedBy = "busId")
    private Set<BusSeatTrip> busSeatTripSet;

    @Transient
    private Integer busSeatTemplateCount;
    @Transient
    private Integer busSeatTripCount;

    @JsonIgnore
    @Transient
    private MultipartFile file;

    @Transient
    private BusSeats busSeats;

    public Bus() {
    }

    public Bus(Integer id) {
        this.id = id;
    }

    public Bus(Integer id, String licensePlate) {
        this.id = id;
        this.licensePlate = licensePlate;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @XmlTransient
    public Set<Trip> getTripSet() {
        return tripSet;
    }

    public void setTripSet(Set<Trip> tripSet) {
        this.tripSet = tripSet;
    }

    @XmlTransient
    public Set<BusSeatTemplate> getBusSeatTemplateSet() {
        return busSeatTemplateSet;
    }

    public void setBusSeatTemplateSet(Set<BusSeatTemplate> busSeatTemplateSet) {
        this.busSeatTemplateSet = busSeatTemplateSet;
    }

    @XmlTransient
    public Set<BusSeatTrip> getBusSeatTripSet() {
        return busSeatTripSet;
    }

    public void setBusSeatTripSet(Set<BusSeatTrip> busSeatTripSet) {
        this.busSeatTripSet = busSeatTripSet;
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
        if (!(object instanceof Bus)) {
            return false;
        }
        Bus other = (Bus) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.mtb.pojo.Bus[ id=" + id + " ]";
    }

    public Integer getBusSeatTemplateCount() {
        return busSeatTemplateCount;
    }

    public void setBusSeatTemplateCount(Integer busSeatTemplateCount) {
        this.busSeatTemplateCount = busSeatTemplateCount;
    }

    public Integer getBusSeatTripCount() {
        return busSeatTripCount;
    }

    public void setBusSeatTripCount(Integer busSeatTripCount) {
        this.busSeatTripCount = busSeatTripCount;
    }

    public BusSeats getBusSeats() {
        return busSeats;
    }

    public void setBusSeats(BusSeats busSeats) {
        this.busSeats = busSeats;
    }

}
