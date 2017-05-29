/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.hibe.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Intern
 */
@Entity
@Table(name = "eannotb_backup")
@NamedQueries({
    @NamedQuery(name = "EannotbBackup.findAll", query = "SELECT e FROM EannotbBackup e")})
public class EannotbBackup implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "EANNO")
    private String eanno;
    @Basic(optional = false)
    @Column(name = "uk_size")
    private String ukSize;
    @Column(name = "ce_size")
    private String ceSize;
    @Basic(optional = false)
    @Column(name = "new_uk_size")
    private String newUkSize;
    @Column(name = "new_ce_size")
    private String newCeSize;
    @Column(name = "style_type")
    private String styleType;
    @Column(name = "changedat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date changedat;
    @Column(name = "action")
    private String action;

    public EannotbBackup() {
    }

    public EannotbBackup(Integer id) {
        this.id = id;
    }

    public EannotbBackup(Integer id, String eanno, String ukSize, String newUkSize) {
        this.id = id;
        this.eanno = eanno;
        this.ukSize = ukSize;
        this.newUkSize = newUkSize;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public String getNewUkSize() {
        return newUkSize;
    }

    public void setNewUkSize(String newUkSize) {
        this.newUkSize = newUkSize;
    }

    public String getNewCeSize() {
        return newCeSize;
    }

    public void setNewCeSize(String newCeSize) {
        this.newCeSize = newCeSize;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public Date getChangedat() {
        return changedat;
    }

    public void setChangedat(Date changedat) {
        this.changedat = changedat;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
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
        if (!(object instanceof EannotbBackup)) {
            return false;
        }
        EannotbBackup other = (EannotbBackup) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.EannotbBackup[ id=" + id + " ]";
    }
    
}
