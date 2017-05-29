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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Intern_pc
 */
@Entity
@Table(name = "company_branch")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CompanyBranch.findAll", query = "SELECT c FROM CompanyBranch c"),
    @NamedQuery(name = "CompanyBranch.findByCompanyBranchId", query = "SELECT c FROM CompanyBranch c WHERE c.companyBranchId = :companyBranchId"),
    @NamedQuery(name = "CompanyBranch.findByBranchCode", query = "SELECT c FROM CompanyBranch c WHERE c.branchCode = :branchCode"),
    @NamedQuery(name = "CompanyBranch.findByBranchName", query = "SELECT c FROM CompanyBranch c WHERE c.branchName = :branchName"),
    @NamedQuery(name = "CompanyBranch.findByBranchAddressLineOne", query = "SELECT c FROM CompanyBranch c WHERE c.branchAddressLineOne = :branchAddressLineOne"),
    @NamedQuery(name = "CompanyBranch.findByBranchAddressLineTwo", query = "SELECT c FROM CompanyBranch c WHERE c.branchAddressLineTwo = :branchAddressLineTwo"),
    @NamedQuery(name = "CompanyBranch.findByBranchAddressLineThree", query = "SELECT c FROM CompanyBranch c WHERE c.branchAddressLineThree = :branchAddressLineThree"),
    @NamedQuery(name = "CompanyBranch.findByBranchEmail", query = "SELECT c FROM CompanyBranch c WHERE c.branchEmail = :branchEmail"),
    @NamedQuery(name = "CompanyBranch.findByContactNo", query = "SELECT c FROM CompanyBranch c WHERE c.contactNo = :contactNo"),
    @NamedQuery(name = "CompanyBranch.findByFaxNo", query = "SELECT c FROM CompanyBranch c WHERE c.faxNo = :faxNo"),
    @NamedQuery(name = "CompanyBranch.findByBranchHeadMobile", query = "SELECT c FROM CompanyBranch c WHERE c.branchHeadMobile = :branchHeadMobile"),
    @NamedQuery(name = "CompanyBranch.findByBranchHeadEmail", query = "SELECT c FROM CompanyBranch c WHERE c.branchHeadEmail = :branchHeadEmail"),
    @NamedQuery(name = "CompanyBranch.findByBranchHeadTp", query = "SELECT c FROM CompanyBranch c WHERE c.branchHeadTp = :branchHeadTp"),
    @NamedQuery(name = "CompanyBranch.findByCompany", query = "SELECT c FROM CompanyBranch c WHERE c.company = :company")})
public class CompanyBranch implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "company_branch_id")
    private Integer companyBranchId;
    @Basic(optional = false)
    @Column(name = "branch_code")
    private String branchCode;
    @Basic(optional = false)
    @Column(name = "branch_name")
    private String branchName;
    @Basic(optional = false)
    @Column(name = "branch_address_line_one")
    private String branchAddressLineOne;
    @Basic(optional = false)
    @Column(name = "branch_address_line_two")
    private String branchAddressLineTwo;
    @Column(name = "branch_address_line_three")
    private String branchAddressLineThree;
    @Column(name = "branch_email")
    private String branchEmail;
    @Column(name = "contact_no")
    private String contactNo;
    @Column(name = "fax_no")
    private String faxNo;
    @Column(name = "branch_head_mobile")
    private String branchHeadMobile;
    @Column(name = "branch_head_email")
    private String branchHeadEmail;
    @Column(name = "branch_head_tp")
    private String branchHeadTp;
    @Basic(optional = false)
    @Column(name = "company")
    private int company;

    public CompanyBranch() {
    }

    public CompanyBranch(Integer companyBranchId) {
        this.companyBranchId = companyBranchId;
    }

    public CompanyBranch(Integer companyBranchId, String branchCode, String branchName, String branchAddressLineOne, String branchAddressLineTwo, int company) {
        this.companyBranchId = companyBranchId;
        this.branchCode = branchCode;
        this.branchName = branchName;
        this.branchAddressLineOne = branchAddressLineOne;
        this.branchAddressLineTwo = branchAddressLineTwo;
        this.company = company;
    }

    public Integer getCompanyBranchId() {
        return companyBranchId;
    }

    public void setCompanyBranchId(Integer companyBranchId) {
        this.companyBranchId = companyBranchId;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getBranchAddressLineOne() {
        return branchAddressLineOne;
    }

    public void setBranchAddressLineOne(String branchAddressLineOne) {
        this.branchAddressLineOne = branchAddressLineOne;
    }

    public String getBranchAddressLineTwo() {
        return branchAddressLineTwo;
    }

    public void setBranchAddressLineTwo(String branchAddressLineTwo) {
        this.branchAddressLineTwo = branchAddressLineTwo;
    }

    public String getBranchAddressLineThree() {
        return branchAddressLineThree;
    }

    public void setBranchAddressLineThree(String branchAddressLineThree) {
        this.branchAddressLineThree = branchAddressLineThree;
    }

    public String getBranchEmail() {
        return branchEmail;
    }

    public void setBranchEmail(String branchEmail) {
        this.branchEmail = branchEmail;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getFaxNo() {
        return faxNo;
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
    }

    public String getBranchHeadMobile() {
        return branchHeadMobile;
    }

    public void setBranchHeadMobile(String branchHeadMobile) {
        this.branchHeadMobile = branchHeadMobile;
    }

    public String getBranchHeadEmail() {
        return branchHeadEmail;
    }

    public void setBranchHeadEmail(String branchHeadEmail) {
        this.branchHeadEmail = branchHeadEmail;
    }

    public String getBranchHeadTp() {
        return branchHeadTp;
    }

    public void setBranchHeadTp(String branchHeadTp) {
        this.branchHeadTp = branchHeadTp;
    }

    public int getCompany() {
        return company;
    }

    public void setCompany(int company) {
        this.company = company;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (companyBranchId != null ? companyBranchId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CompanyBranch)) {
            return false;
        }
        CompanyBranch other = (CompanyBranch) object;
        if ((this.companyBranchId == null && other.companyBranchId != null) || (this.companyBranchId != null && !this.companyBranchId.equals(other.companyBranchId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.CompanyBranch[ companyBranchId=" + companyBranchId + " ]";
    }
    
}
