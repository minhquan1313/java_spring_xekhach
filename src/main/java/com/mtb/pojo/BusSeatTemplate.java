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
import javax.validation.constraints.Size;
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
    @NamedQuery(name = "BusSeatTemplate.findByBusSeat", query = "SELECT b FROM BusSeatTemplate b WHERE b.busSeat = :busSeat")})
public class BusSeatTemplate implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "bus_seat")
    private String busSeat;
    @JoinColumn(name = "bus_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Bus busId;

    public BusSeatTemplate() {
    }

    public BusSeatTemplate(Integer id) {
        this.id = id;
    }

    public BusSeatTemplate(Integer id, String busSeat) {
        this.id = id;
        this.busSeat = busSeat;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBusSeat() {
        return busSeat;
    }

    public void setBusSeat(String busSeat) {
        this.busSeat = busSeat;
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
