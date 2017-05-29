package com.impression.hibe.model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
 * @author Intern_pc
 */
@Entity
@Table(name = "reference")
@NamedQueries({
    @NamedQuery(name = "Reference.findAll", query = "SELECT r FROM Reference r")})
public class Reference implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ref_id")
    private Integer refId;
    @Basic(optional = false)
    @Column(name = "ref_type")
    private String refType;
    @Column(name = "ref")
    private String ref;
    @Column(name = "kaff")
    private String kaff;
    @Column(name = "washcare_symbols")
    private String washcareSymbols;
    @Column(name = "fiber_comp")
    private String fiberComp;
    @Column(name = "exclusive_of_trims")
    private String exclusiveOfTrims;
    @Column(name = "con_pa_non_text")
    private String conPaNonText;
    @Column(name = "kids_warning")
    private String kidsWarning;
    @Column(name = "aditional_washcare")
    private String aditionalWashcare;
    @Column(name = "part_of_set")
    private String partOfSet;

    public Reference() {
    }

    public Reference(Integer refId) {
        this.refId = refId;
    }

    public Reference(Integer refId, String refType) {
        this.refId = refId;
        this.refType = refType;
    }
    public Reference(String refType, String ref) {
        this.refType = refType;
        this.ref = ref;
    }

    public Integer getRefId() {
        return refId;
    }

    public void setRefId(Integer refId) {
        this.refId = refId;
    }

    public String getRefType() {
        return refType;
    }

    public void setRefType(String refType) {
        this.refType = refType;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref;
    }

    public String getKaff() {
        return kaff;
    }

    public void setKaff(String kaff) {
        this.kaff = kaff;
    }

    public String getWashcareSymbols() {
        return washcareSymbols;
    }

    public void setWashcareSymbols(String washcareSymbols) {
        this.washcareSymbols = washcareSymbols;
    }

    public String getFiberComp() {
        return fiberComp;
    }

    public void setFiberComp(String fiberComp) {
        this.fiberComp = fiberComp;
    }

    public String getExclusiveOfTrims() {
        return exclusiveOfTrims;
    }

    public void setExclusiveOfTrims(String exclusiveOfTrims) {
        this.exclusiveOfTrims = exclusiveOfTrims;
    }

    public String getConPaNonText() {
        return conPaNonText;
    }

    public void setConPaNonText(String conPaNonText) {
        this.conPaNonText = conPaNonText;
    }

    public String getKidsWarning() {
        return kidsWarning;
    }

    public void setKidsWarning(String kidsWarning) {
        this.kidsWarning = kidsWarning;
    }

    public String getAditionalWashcare() {
        return aditionalWashcare;
    }

    public void setAditionalWashcare(String aditionalWashcare) {
        this.aditionalWashcare = aditionalWashcare;
    }

    public String getPartOfSet() {
        return partOfSet;
    }

    public void setPartOfSet(String partOfSet) {
        this.partOfSet = partOfSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (refId != null ? refId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Reference)) {
            return false;
        }
        Reference other = (Reference) object;
        if ((this.refId == null && other.refId != null) || (this.refId != null && !this.refId.equals(other.refId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "reference.Reference[ refId=" + refId + " ]";
    }
    
}
