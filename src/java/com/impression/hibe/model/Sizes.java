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
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Intern_pc
 */
@Entity
@Table(name = "sizes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Sizes.findAll", query = "SELECT s FROM Sizes s"),
    @NamedQuery(name = "Sizes.findByDId", query = "SELECT s FROM Sizes s WHERE s.dId = :dId"),
    @NamedQuery(name = "Sizes.findByDCode", query = "SELECT s FROM Sizes s WHERE s.dCode = :dCode"),
    @NamedQuery(name = "Sizes.findByDept", query = "SELECT s FROM Sizes s WHERE s.dept = :dept")})
public class Sizes implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "d_id")
    private Integer dId;
    @Column(name = "d_code")
    private String dCode;
    @Column(name = "dept")
    private String dept;
    @Lob
    @Column(name = "uk")
    private String uk;
    @Lob
    @Column(name = "ce")
    private String ce;
    @Lob
    @Column(name = "us")
    private String us;
    @Lob
    @Column(name = "mx")
    private String mx;
    @Lob
    @Column(name = "opt_sec_one")
    private String optSecOne;
    @Lob
    @Column(name = "opt_sec_two")
    private String optSecTwo;
    @Lob
    @Column(name = "opt_sec_three")
    private String optSecThree;
    @Lob
    @Column(name = "opt_sec_four")
    private String optSecFour;
    @Lob
    @Column(name = "opt_sec_five")
    private String optSecFive;
    @Lob
    @Column(name = "opt_sec_size")
    private String optSecSize;
    @Lob
    @Column(name = "opt_sec_seven")
    private String optSecSeven;
    @Lob
    @Column(name = "opt_sec_eight")
    private String optSecEight;
    @Lob
    @Column(name = "opt_sec_nine")
    private String optSecNine;
    @Lob
    @Column(name = "opt_sec_ten")
    private String optSecTen;
    @Lob
    @Column(name = "opt_sec_eleven")
    private String optSecEleven;
    @Lob
    @Column(name = "opt_sec_twelve")
    private String optSecTwelve;
    @Lob
    @Column(name = "uk_code")
    private String ukCode;
    @Lob
    @Column(name = "ce_code")
    private String ceCode;

    public Sizes() {
    }

    public Sizes(Integer dId) {
        this.dId = dId;
    }

    public Integer getDId() {
        return dId;
    }

    public void setDId(Integer dId) {
        this.dId = dId;
    }

    public String getDCode() {
        return dCode;
    }

    public void setDCode(String dCode) {
        this.dCode = dCode;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getUk() {
        return uk;
    }

    public void setUk(String uk) {
        this.uk = uk;
    }

    public String getCe() {
        return ce;
    }

    public void setCe(String ce) {
        this.ce = ce;
    }

    public String getUs() {
        return us;
    }

    public void setUs(String us) {
        this.us = us;
    }

    public String getMx() {
        return mx;
    }

    public void setMx(String mx) {
        this.mx = mx;
    }

    public String getOptSecOne() {
        return optSecOne;
    }

    public void setOptSecOne(String optSecOne) {
        this.optSecOne = optSecOne;
    }

    public String getOptSecTwo() {
        return optSecTwo;
    }

    public void setOptSecTwo(String optSecTwo) {
        this.optSecTwo = optSecTwo;
    }

    public String getOptSecThree() {
        return optSecThree;
    }

    public void setOptSecThree(String optSecThree) {
        this.optSecThree = optSecThree;
    }

    public String getOptSecFour() {
        return optSecFour;
    }

    public void setOptSecFour(String optSecFour) {
        this.optSecFour = optSecFour;
    }

    public String getOptSecFive() {
        return optSecFive;
    }

    public void setOptSecFive(String optSecFive) {
        this.optSecFive = optSecFive;
    }

    public String getOptSecSize() {
        return optSecSize;
    }

    public void setOptSecSize(String optSecSize) {
        this.optSecSize = optSecSize;
    }

    public String getOptSecSeven() {
        return optSecSeven;
    }

    public void setOptSecSeven(String optSecSeven) {
        this.optSecSeven = optSecSeven;
    }

    public String getOptSecEight() {
        return optSecEight;
    }

    public void setOptSecEight(String optSecEight) {
        this.optSecEight = optSecEight;
    }

    public String getOptSecNine() {
        return optSecNine;
    }

    public void setOptSecNine(String optSecNine) {
        this.optSecNine = optSecNine;
    }

    public String getOptSecTen() {
        return optSecTen;
    }

    public void setOptSecTen(String optSecTen) {
        this.optSecTen = optSecTen;
    }

    public String getOptSecEleven() {
        return optSecEleven;
    }

    public void setOptSecEleven(String optSecEleven) {
        this.optSecEleven = optSecEleven;
    }

    public String getOptSecTwelve() {
        return optSecTwelve;
    }

    public void setOptSecTwelve(String optSecTwelve) {
        this.optSecTwelve = optSecTwelve;
    }

    public String getUkCode() {
        return ukCode;
    }

    public void setUkCode(String ukCode) {
        this.ukCode = ukCode;
    }

    public String getCeCode() {
        return ceCode;
    }

    public void setCeCode(String ceCode) {
        this.ceCode = ceCode;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (dId != null ? dId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sizes)) {
            return false;
        }
        Sizes other = (Sizes) object;
        if ((this.dId == null && other.dId != null) || (this.dId != null && !this.dId.equals(other.dId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Sizes[ dId=" + dId + " ]";
    }
    
}
