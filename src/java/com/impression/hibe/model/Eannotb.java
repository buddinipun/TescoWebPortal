/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.hibe.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Intern_pc
 */
@Entity
@Table(name = "eannotb")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Eannotb.findAll", query = "SELECT e FROM Eannotb e"),
    @NamedQuery(name = "Eannotb.findByEanno", query = "SELECT e FROM Eannotb e WHERE e.eanno = :eanno"),
    @NamedQuery(name = "Eannotb.findByUkSize", query = "SELECT e FROM Eannotb e WHERE e.ukSize = :ukSize"),
    @NamedQuery(name = "Eannotb.findByCeSize", query = "SELECT e FROM Eannotb e WHERE e.ceSize = :ceSize"),
    @NamedQuery(name = "Eannotb.findByStyleType", query = "SELECT e FROM Eannotb e WHERE e.styleType = :styleType"),
    @NamedQuery(name = "Eannotb.findById", query = "SELECT e FROM Eannotb e WHERE e.id = :id")})
public class Eannotb implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "EANNO")
    private String eanno;
    @Column(name = "uk_size")
    private String ukSize;
    @Column(name = "ce_size")
    private String ceSize;
    @Column(name = "style_type")
    private String styleType;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    public Eannotb() {
    }

    public Eannotb(Integer id) {
        this.id = id;
    }

    public String getEanno() {
        return eanno;
    }

    public void setEanno(String eanno) {
        this.eanno = eanno;
    }

    public String getUkSize() {
        return ukSize;
    }

    public void setUkSize(String ukSize) {
        this.ukSize = ukSize;
    }

    public String getCeSize() {
        return ceSize;
    }

    public void setCeSize(String ceSize) {
        this.ceSize = ceSize;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        if (!(object instanceof Eannotb)) {
            return false;
        }
        Eannotb other = (Eannotb) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Eannotb[ id=" + id + " ]";
    }
    
}
