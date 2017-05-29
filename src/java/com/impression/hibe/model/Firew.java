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
@Table(name = "firew")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Firew.findAll", query = "SELECT f FROM Firew f"),
    @NamedQuery(name = "Firew.findByFwId", query = "SELECT f FROM Firew f WHERE f.fwId = :fwId")})
public class Firew implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "fw_id")
    private Integer fwId;
    @Lob
    @Column(name = "fw_code")
    private String fwCode;
    @Lob
    @Column(name = "english")
    private String english;
    @Lob
    @Column(name = "french")
    private String french;
    @Lob
    @Column(name = "german")
    private String german;
    @Lob
    @Column(name = "spanish")
    private String spanish;
    @Lob
    @Column(name = "polish")
    private String polish;
    @Lob
    @Column(name = "czech")
    private String czech;
    @Lob
    @Column(name = "slovakian")
    private String slovakian;
    @Lob
    @Column(name = "hungarian")
    private String hungarian;
    @Lob
    @Column(name = "croatian")
    private String croatian;
    @Lob
    @Column(name = "swedish")
    private String swedish;
    @Lob
    @Column(name = "finnish")
    private String finnish;
    @Lob
    @Column(name = "russian")
    private String russian;
    @Lob
    @Column(name = "turkish")
    private String turkish;
    @Lob
    @Column(name = "vietnamese")
    private String vietnamese;
    @Lob
    @Column(name = "latina")
    private String latina;
    @Lob
    @Column(name = "arabic")
    private String arabic;

    public Firew() {
    }

    public Firew(Integer fwId) {
        this.fwId = fwId;
    }

    public Integer getFwId() {
        return fwId;
    }

    public void setFwId(Integer fwId) {
        this.fwId = fwId;
    }

    public String getFwCode() {
        return fwCode;
    }

    public void setFwCode(String fwCode) {
        this.fwCode = fwCode;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getFrench() {
        return french;
    }

    public void setFrench(String french) {
        this.french = french;
    }

    public String getGerman() {
        return german;
    }

    public void setGerman(String german) {
        this.german = german;
    }

    public String getSpanish() {
        return spanish;
    }

    public void setSpanish(String spanish) {
        this.spanish = spanish;
    }

    public String getPolish() {
        return polish;
    }

    public void setPolish(String polish) {
        this.polish = polish;
    }

    public String getCzech() {
        return czech;
    }

    public void setCzech(String czech) {
        this.czech = czech;
    }

    public String getSlovakian() {
        return slovakian;
    }

    public void setSlovakian(String slovakian) {
        this.slovakian = slovakian;
    }

    public String getHungarian() {
        return hungarian;
    }

    public void setHungarian(String hungarian) {
        this.hungarian = hungarian;
    }

    public String getCroatian() {
        return croatian;
    }

    public void setCroatian(String croatian) {
        this.croatian = croatian;
    }

    public String getSwedish() {
        return swedish;
    }

    public void setSwedish(String swedish) {
        this.swedish = swedish;
    }

    public String getFinnish() {
        return finnish;
    }

    public void setFinnish(String finnish) {
        this.finnish = finnish;
    }

    public String getRussian() {
        return russian;
    }

    public void setRussian(String russian) {
        this.russian = russian;
    }

    public String getTurkish() {
        return turkish;
    }

    public void setTurkish(String turkish) {
        this.turkish = turkish;
    }

    public String getVietnamese() {
        return vietnamese;
    }

    public void setVietnamese(String vietnamese) {
        this.vietnamese = vietnamese;
    }

    public String getLatina() {
        return latina;
    }

    public void setLatina(String latina) {
        this.latina = latina;
    }

    public String getArabic() {
        return arabic;
    }

    public void setArabic(String arabic) {
        this.arabic = arabic;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (fwId != null ? fwId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Firew)) {
            return false;
        }
        Firew other = (Firew) object;
        if ((this.fwId == null && other.fwId != null) || (this.fwId != null && !this.fwId.equals(other.fwId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Firew[ fwId=" + fwId + " ]";
    }
    
}