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

/**
 *
 * @author User
 */
@Entity
@Table(name = "label_group")
@NamedQueries({
    @NamedQuery(name = "LabelGroup.findAll", query = "SELECT l FROM LabelGroup l")})
public class LabelGroup implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "label_id")
    private Integer labelId;
    @Column(name = "label_type")
    private String labelType;
    @Column(name = "grp")
    private String grp;

    public LabelGroup() {
    }

    public LabelGroup(String labelType, String grp) {
        this.labelType = labelType;
        this.grp = grp;
    }

    public LabelGroup(Integer labelId) {
        this.labelId = labelId;
    }

    public Integer getLabelId() {
        return labelId;
    }

    public void setLabelId(Integer labelId) {
        this.labelId = labelId;
    }

    public String getLabelType() {
        return labelType;
    }

    public void setLabelType(String labelType) {
        this.labelType = labelType;
    }

    public String getGrp() {
        return grp;
    }

    public void setGrp(String grp) {
        this.grp = grp;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (labelId != null ? labelId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LabelGroup)) {
            return false;
        }
        LabelGroup other = (LabelGroup) object;
        if ((this.labelId == null && other.labelId != null) || (this.labelId != null && !this.labelId.equals(other.labelId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.LabelGroup[ labelId=" + labelId + " ]";
    }
    
}
