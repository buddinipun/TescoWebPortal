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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Intern_pc
 */
@Entity
@Table(name = "lof_labeltechnicaldata")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LofLabeltechnicaldata.findAll", query = "SELECT l FROM LofLabeltechnicaldata l"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByCounter", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.counter = :counter"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByPLabel", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.pLabel = :pLabel"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByReference", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.reference = :reference"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByCareText", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.careText = :careText"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByWashSymbol", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.washSymbol = :washSymbol"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition1", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition1 = :fibreComposition1"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition2", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition2 = :fibreComposition2"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition3", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition3 = :fibreComposition3"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition4", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition4 = :fibreComposition4"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition5", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition5 = :fibreComposition5"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByFibreComposition6", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.fibreComposition6 = :fibreComposition6"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByPGroup", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.pGroup = :pGroup"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByDescription", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.description = :description"),
    @NamedQuery(name = "LofLabeltechnicaldata.findByAddress", query = "SELECT l FROM LofLabeltechnicaldata l WHERE l.address = :address")})
public class LofLabeltechnicaldata implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "counter")
    private Integer counter;
    @Column(name = "PLabel")
    private String pLabel;
    @Column(name = "Reference")
    private String reference;
    @Column(name = "Care_Text")
    private String careText;
    @Column(name = "Wash_Symbol")
    private String washSymbol;
    @Column(name = "Fibre_Composition_1")
    private String fibreComposition1;
    @Column(name = "Fibre_Composition_2")
    private String fibreComposition2;
    @Column(name = "Fibre_Composition_3")
    private String fibreComposition3;
    @Column(name = "Fibre_Composition_4")
    private String fibreComposition4;
    @Column(name = "Fibre_Composition_5")
    private String fibreComposition5;
    @Column(name = "Fibre_Composition_6")
    private String fibreComposition6;
    @Column(name = "PGroup")
    private String pGroup;
    @Column(name = "Description")
    private String description;
    @Column(name = "address")
    private String address;
    @JoinColumn(name = "web_order_no", referencedColumnName = "web_order_no")
    @ManyToOne(optional = false)
    private LofGeneraldata webOrderNo;

    public LofLabeltechnicaldata() {
    }

    public LofLabeltechnicaldata(Integer counter) {
        this.counter = counter;
    }

    public Integer getCounter() {
        return counter;
    }

    public void setCounter(Integer counter) {
        this.counter = counter;
    }

    public String getPLabel() {
        return pLabel;
    }

    public void setPLabel(String pLabel) {
        this.pLabel = pLabel;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getCareText() {
        return careText;
    }

    public void setCareText(String careText) {
        this.careText = careText;
    }

    public String getWashSymbol() {
        return washSymbol;
    }

    public void setWashSymbol(String washSymbol) {
        this.washSymbol = washSymbol;
    }

    public String getFibreComposition1() {
        return fibreComposition1;
    }

    public void setFibreComposition1(String fibreComposition1) {
        this.fibreComposition1 = fibreComposition1;
    }

    public String getFibreComposition2() {
        return fibreComposition2;
    }

    public void setFibreComposition2(String fibreComposition2) {
        this.fibreComposition2 = fibreComposition2;
    }

    public String getFibreComposition3() {
        return fibreComposition3;
    }

    public void setFibreComposition3(String fibreComposition3) {
        this.fibreComposition3 = fibreComposition3;
    }

    public String getFibreComposition4() {
        return fibreComposition4;
    }

    public void setFibreComposition4(String fibreComposition4) {
        this.fibreComposition4 = fibreComposition4;
    }

    public String getFibreComposition5() {
        return fibreComposition5;
    }

    public void setFibreComposition5(String fibreComposition5) {
        this.fibreComposition5 = fibreComposition5;
    }

    public String getFibreComposition6() {
        return fibreComposition6;
    }

    public void setFibreComposition6(String fibreComposition6) {
        this.fibreComposition6 = fibreComposition6;
    }

    public String getPGroup() {
        return pGroup;
    }

    public void setPGroup(String pGroup) {
        this.pGroup = pGroup;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LofGeneraldata getWebOrderNo() {
        return webOrderNo;
    }

    public void setWebOrderNo(LofGeneraldata webOrderNo) {
        this.webOrderNo = webOrderNo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (counter != null ? counter.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LofLabeltechnicaldata)) {
            return false;
        }
        LofLabeltechnicaldata other = (LofLabeltechnicaldata) object;
        if ((this.counter == null && other.counter != null) || (this.counter != null && !this.counter.equals(other.counter))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.LofLabeltechnicaldata[ counter=" + counter + " ]";
    }
    
}
