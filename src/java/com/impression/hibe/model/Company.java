/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.hibe.model;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Intern_pc
 */
@Entity
@Table(name = "company")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Company.findAll", query = "SELECT c FROM Company c"),
    @NamedQuery(name = "Company.findByCompanyId", query = "SELECT c FROM Company c WHERE c.companyId = :companyId"),
    @NamedQuery(name = "Company.findByCompanyCode", query = "SELECT c FROM Company c WHERE c.companyCode = :companyCode"),
    @NamedQuery(name = "Company.findByCompanyDomain", query = "SELECT c FROM Company c WHERE c.companyDomain = :companyDomain"),
    @NamedQuery(name = "Company.findByCompanyName", query = "SELECT c FROM Company c WHERE c.companyName = :companyName"),
    @NamedQuery(name = "Company.findBySales", query = "SELECT c FROM Company c WHERE c.sales = :sales"),
    @NamedQuery(name = "Company.findByCs", query = "SELECT c FROM Company c WHERE c.cs = :cs"),
    @NamedQuery(name = "Company.findByArtwork", query = "SELECT c FROM Company c WHERE c.artwork = :artwork")})
public class Company implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "company_id")
    private Integer companyId;
    @Column(name = "company_code")
    private String companyCode;
    @Column(name = "company_domain")
    private String companyDomain;
    @Basic(optional = false)
    @Column(name = "company_name")
    private String companyName;
    @Column(name = "sales")
    private String sales;
    @Column(name = "cs")
    private String cs;
    @Column(name = "artwork")
    private String artwork;
    @OneToMany(mappedBy = "companyId")
    private Collection<SysUser> sysUserCollection;

    public Company() {
    }
    public Company(Integer companyId, String companyCode, String companyDomain, String companyName, String sales, String cs, String artwork) {
        this.companyId = companyId;
        this.companyCode = companyCode;
        this.companyDomain = companyDomain;
        this.companyName = companyName;
        this.sales = sales;
        this.cs = cs;
        this.artwork = artwork;
    }


    public Company(Integer companyId) {
        this.companyId = companyId;
    }

    public Company(Integer companyId, String companyName) {
        this.companyId = companyId;
        this.companyName = companyName;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }

    public String getCompanyDomain() {
        return companyDomain;
    }

    public void setCompanyDomain(String companyDomain) {
        this.companyDomain = companyDomain;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getSales() {
        return sales;
    }

    public void setSales(String sales) {
        this.sales = sales;
    }

    public String getCs() {
        return cs;
    }

    public void setCs(String cs) {
        this.cs = cs;
    }

    public String getArtwork() {
        return artwork;
    }

    public void setArtwork(String artwork) {
        this.artwork = artwork;
    }

    @XmlTransient
    public Collection<SysUser> getSysUserCollection() {
        return sysUserCollection;
    }

    public void setSysUserCollection(Collection<SysUser> sysUserCollection) {
        this.sysUserCollection = sysUserCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (companyId != null ? companyId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Company)) {
            return false;
        }
        Company other = (Company) object;
        if ((this.companyId == null && other.companyId != null) || (this.companyId != null && !this.companyId.equals(other.companyId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Company[ companyId=" + companyId + " ]";
    }
    
}
