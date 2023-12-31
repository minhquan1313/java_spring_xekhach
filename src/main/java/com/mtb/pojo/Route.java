/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.pojo;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 *
 * @author Binh
 */
@Entity
@Table(name = "route")
@XmlRootElement
@NamedQueries({
        @NamedQuery(name = "Route.findAll", query = "SELECT r FROM Route r"),
        @NamedQuery(name = "Route.findById", query = "SELECT r FROM Route r WHERE r.id = :id"),
        @NamedQuery(name = "Route.findByStartLocation", query = "SELECT r FROM Route r WHERE r.startLocation = :startLocation"),
        @NamedQuery(name = "Route.findByEndLocation", query = "SELECT r FROM Route r WHERE r.endLocation = :endLocation") })
public class Route implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull(message = "{route.startLocation.notNull}")
    @Size(min = 1, max = 50, message = "{route.startLocation.lenErr}")
    @Column(name = "start_location")
    private String startLocation;
    @Basic(optional = false)
    @NotNull(message = "{route.endLocation.notNull}")
    @Size(min = 1, max = 50, message = "{route.endLocation.lenErr}")
    @Column(name = "end_location")
    private String endLocation;

    @JsonIgnore
    @OneToMany(mappedBy = "routeId")
    private Set<Trip> tripSet;

    public Route() {
    }

    public Route(Integer id) {
        this.id = id;
    }

    public Route(Integer id, String startLocation, String endLocation) {
        this.id = id;
        this.startLocation = startLocation;
        this.endLocation = endLocation;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getEndLocation() {
        return endLocation;
    }

    public void setEndLocation(String endLocation) {
        this.endLocation = endLocation;
    }

    @XmlTransient
    public Set<Trip> getTripSet() {
        return tripSet;
    }

    public void setTripSet(Set<Trip> tripSet) {
        this.tripSet = tripSet;
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
        if (!(object instanceof Route)) {
            return false;
        }
        Route other = (Route) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.mtb.pojo.Route[ id=" + id + " ]";
    }

}
