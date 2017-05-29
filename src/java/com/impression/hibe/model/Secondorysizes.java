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
@Table(name = "secondorysizes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Secondorysizes.findAll", query = "SELECT s FROM Secondorysizes s"),
    @NamedQuery(name = "Secondorysizes.findByDCode", query = "SELECT s FROM Secondorysizes s WHERE s.dCode = :dCode"),
    @NamedQuery(name = "Secondorysizes.findByDept", query = "SELECT s FROM Secondorysizes s WHERE s.dept = :dept"),
    @NamedQuery(name = "Secondorysizes.findBySecDefault", query = "SELECT s FROM Secondorysizes s WHERE s.secDefault = :secDefault"),
    @NamedQuery(name = "Secondorysizes.findBySecOne", query = "SELECT s FROM Secondorysizes s WHERE s.secOne = :secOne"),
    @NamedQuery(name = "Secondorysizes.findBySecTwo", query = "SELECT s FROM Secondorysizes s WHERE s.secTwo = :secTwo"),
    @NamedQuery(name = "Secondorysizes.findBySecThree", query = "SELECT s FROM Secondorysizes s WHERE s.secThree = :secThree"),
    @NamedQuery(name = "Secondorysizes.findBySecFour", query = "SELECT s FROM Secondorysizes s WHERE s.secFour = :secFour"),
    @NamedQuery(name = "Secondorysizes.findBySecFive", query = "SELECT s FROM Secondorysizes s WHERE s.secFive = :secFive"),
    @NamedQuery(name = "Secondorysizes.findBySecSix", query = "SELECT s FROM Secondorysizes s WHERE s.secSix = :secSix"),
    @NamedQuery(name = "Secondorysizes.findBySecSeven", query = "SELECT s FROM Secondorysizes s WHERE s.secSeven = :secSeven"),
    @NamedQuery(name = "Secondorysizes.findBySecEight", query = "SELECT s FROM Secondorysizes s WHERE s.secEight = :secEight"),
    @NamedQuery(name = "Secondorysizes.findBySecNine", query = "SELECT s FROM Secondorysizes s WHERE s.secNine = :secNine"),
    @NamedQuery(name = "Secondorysizes.findBySecTen", query = "SELECT s FROM Secondorysizes s WHERE s.secTen = :secTen"),
    @NamedQuery(name = "Secondorysizes.findBySecEleven", query = "SELECT s FROM Secondorysizes s WHERE s.secEleven = :secEleven"),
    @NamedQuery(name = "Secondorysizes.findBySecTwelve", query = "SELECT s FROM Secondorysizes s WHERE s.secTwelve = :secTwelve"),
    @NamedQuery(name = "Secondorysizes.findBySecThirteen", query = "SELECT s FROM Secondorysizes s WHERE s.secThirteen = :secThirteen"),
    @NamedQuery(name = "Secondorysizes.findBySecFourteen", query = "SELECT s FROM Secondorysizes s WHERE s.secFourteen = :secFourteen"),
    @NamedQuery(name = "Secondorysizes.findBySecFifteen", query = "SELECT s FROM Secondorysizes s WHERE s.secFifteen = :secFifteen")})
public class Secondorysizes implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "d_code")
    private String dCode;
    @Column(name = "dept")
    private String dept;
    @Column(name = "sec_default")
    private String secDefault;
    @Column(name = "sec_one")
    private String secOne;
    @Column(name = "sec_two")
    private String secTwo;
    @Column(name = "sec_three")
    private String secThree;
    @Column(name = "sec_four")
    private String secFour;
    @Column(name = "sec_five")
    private String secFive;
    @Column(name = "sec_six")
    private String secSix;
    @Column(name = "sec_seven")
    private String secSeven;
    @Column(name = "sec_eight")
    private String secEight;
    @Column(name = "sec_nine")
    private String secNine;
    @Column(name = "sec_ten")
    private String secTen;
    @Column(name = "sec_eleven")
    private String secEleven;
    @Column(name = "sec_twelve")
    private String secTwelve;
    @Column(name = "sec_thirteen")
    private String secThirteen;
    @Column(name = "sec_fourteen")
    private String secFourteen;
    @Column(name = "sec_fifteen")
    private String secFifteen;

    public Secondorysizes() {
    }

    public Secondorysizes(String dCode) {
        this.dCode = dCode;
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

    public String getSecDefault() {
        return secDefault;
    }

    public void setSecDefault(String secDefault) {
        this.secDefault = secDefault;
    }

    public String getSecOne() {
        return secOne;
    }

    public void setSecOne(String secOne) {
        this.secOne = secOne;
    }

    public String getSecTwo() {
        return secTwo;
    }

    public void setSecTwo(String secTwo) {
        this.secTwo = secTwo;
    }

    public String getSecThree() {
        return secThree;
    }

    public void setSecThree(String secThree) {
        this.secThree = secThree;
    }

    public String getSecFour() {
        return secFour;
    }

    public void setSecFour(String secFour) {
        this.secFour = secFour;
    }

    public String getSecFive() {
        return secFive;
    }

    public void setSecFive(String secFive) {
        this.secFive = secFive;
    }

    public String getSecSix() {
        return secSix;
    }

    public void setSecSix(String secSix) {
        this.secSix = secSix;
    }

    public String getSecSeven() {
        return secSeven;
    }

    public void setSecSeven(String secSeven) {
        this.secSeven = secSeven;
    }

    public String getSecEight() {
        return secEight;
    }

    public void setSecEight(String secEight) {
        this.secEight = secEight;
    }

    public String getSecNine() {
        return secNine;
    }

    public void setSecNine(String secNine) {
        this.secNine = secNine;
    }

    public String getSecTen() {
        return secTen;
    }

    public void setSecTen(String secTen) {
        this.secTen = secTen;
    }

    public String getSecEleven() {
        return secEleven;
    }

    public void setSecEleven(String secEleven) {
        this.secEleven = secEleven;
    }

    public String getSecTwelve() {
        return secTwelve;
    }

    public void setSecTwelve(String secTwelve) {
        this.secTwelve = secTwelve;
    }

    public String getSecThirteen() {
        return secThirteen;
    }

    public void setSecThirteen(String secThirteen) {
        this.secThirteen = secThirteen;
    }

    public String getSecFourteen() {
        return secFourteen;
    }

    public void setSecFourteen(String secFourteen) {
        this.secFourteen = secFourteen;
    }

    public String getSecFifteen() {
        return secFifteen;
    }

    public void setSecFifteen(String secFifteen) {
        this.secFifteen = secFifteen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (dCode != null ? dCode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Secondorysizes)) {
            return false;
        }
        Secondorysizes other = (Secondorysizes) object;
        if ((this.dCode == null && other.dCode != null) || (this.dCode != null && !this.dCode.equals(other.dCode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Secondorysizes[ dCode=" + dCode + " ]";
    }
    
}
