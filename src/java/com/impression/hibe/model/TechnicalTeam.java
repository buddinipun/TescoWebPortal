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
 * @author Intern
 */
@Entity
@Table(name = "technical_team")
@NamedQueries({
    @NamedQuery(name = "TechnicalTeam.findAll", query = "SELECT t FROM TechnicalTeam t")})
public class TechnicalTeam implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "tech_member_id")
    private Integer techMemberId;
    @Column(name = "email")
    private String email;
    @Column(name = "username")
    private String username;
    @Column(name = "contact_no")
    private String contactNo;
    @Column(name = "skype")
    private String skype;
    @Column(name = "viber")
    private String viber;
    @Column(name = "other")
    private String other;
    @Column(name = "country")
    private String country;
    @Column(name = "contact_no_dep")
    private String contactNoDep;
    @Column(name = "image_url")
    private String imageUrl;

    public TechnicalTeam() {
    }

    public TechnicalTeam(Integer techMemberId) {
        this.techMemberId = techMemberId;
    }

    public Integer getTechMemberId() {
        return techMemberId;
    }

    public void setTechMemberId(Integer techMemberId) {
        this.techMemberId = techMemberId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getSkype() {
        return skype;
    }

    public void setSkype(String skype) {
        this.skype = skype;
    }

    public String getViber() {
        return viber;
    }

    public void setViber(String viber) {
        this.viber = viber;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getContactNoDep() {
        return contactNoDep;
    }

    public void setContactNoDep(String contactNoDep) {
        this.contactNoDep = contactNoDep;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (techMemberId != null ? techMemberId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TechnicalTeam)) {
            return false;
        }
        TechnicalTeam other = (TechnicalTeam) object;
        if ((this.techMemberId == null && other.techMemberId != null) || (this.techMemberId != null && !this.techMemberId.equals(other.techMemberId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.TechnicalTeam[ techMemberId=" + techMemberId + " ]";
    }
    
}
