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
@Table(name = "garmant")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Garmant.findAll", query = "SELECT g FROM Garmant g"),
    @NamedQuery(name = "Garmant.findBySupNo", query = "SELECT g FROM Garmant g WHERE g.supNo = :supNo"),
    @NamedQuery(name = "Garmant.findBySupId", query = "SELECT g FROM Garmant g WHERE g.supId = :supId")})
public class Garmant implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "sup_no")
    private Integer supNo;
    @Column(name = "sup_id")
    private String supId;

    public Garmant() {
    }

    public Garmant(Integer supNo) {
        this.supNo = supNo;
    }

    public Integer getSupNo() {
        return supNo;
    }

    public void setSupNo(Integer supNo) {
        this.supNo = supNo;
    }

    public String getSupId() {
        return supId;
    }

    public void setSupId(String supId) {
        this.supId = supId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (supNo != null ? supNo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Garmant)) {
            return false;
        }
        Garmant other = (Garmant) object;
        if ((this.supNo == null && other.supNo != null) || (this.supNo != null && !this.supNo.equals(other.supNo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Garmant[ supNo=" + supNo + " ]";
    }
    
}
