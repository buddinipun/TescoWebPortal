/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.hibe.model;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author User
 */
@Entity
@Table(name = "customer")
@NamedQueries({
    @NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c")})
public class Customer implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "customer_id")
    private Integer customerId;
    @Basic(optional = false)
    @Column(name = "supplier_code")
    private String supplierCode;
    @Basic(optional = false)
    @Column(name = "customer_name")
    private String customerName;
    @Column(name = "phone_primary")
    private String phonePrimary;
    @Column(name = "phone_alternative")
    private String phoneAlternative;
    @Column(name = "fax")
    private String fax;
    @Column(name = "email")
    private String email;
    @Column(name = "country")
    private String country;
    @Column(name = "post_code")
    private String postCode;
    @Basic(optional = false)
    @Column(name = "brands")
    private String brands;
    @Basic(optional = false)
    @Column(name = "enquiry")
    private String enquiry;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "customer")
    private Collection<LofGeneraldata> lofGeneraldataCollection;       
    @OneToMany(mappedBy = "customer")
    private Collection<ContactPerson> contactPersonCollection;
    @JoinColumn(name = "username", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private SysUser username;

    public Customer() {
    }

    public Customer(Integer customerId) {
        this.customerId = customerId;
    }

    public Customer(Integer customerId, String supplierCode, String customerName, String brands, String enquiry) {
        this.customerId = customerId;
        this.supplierCode = supplierCode;
        this.customerName = customerName;
        this.brands = brands;
        this.enquiry = enquiry;
    }
    public Customer(int customer_id, String customer_name,String email_address, String phone_primary,String fax,String country,String brands,String enquiry,String supplier_code, SysUser username){
        this.customerId = customer_id;
        this.customerName = customer_name;
        this.email = email_address;
        this.phonePrimary = phone_primary;
        this.fax = fax;
        this.country = country;
        this.supplierCode = supplier_code;
        this.customerName = customer_name;
        this.brands = brands;
        this.enquiry = enquiry;
        this.username = username;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhonePrimary() {
        return phonePrimary;
    }

    public void setPhonePrimary(String phonePrimary) {
        this.phonePrimary = phonePrimary;
    }

    public String getPhoneAlternative() {
        return phoneAlternative;
    }

    public void setPhoneAlternative(String phoneAlternative) {
        this.phoneAlternative = phoneAlternative;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getBrands() {
        return brands;
    }

    public void setBrands(String brands) {
        this.brands = brands;
    }

    public String getEnquiry() {
        return enquiry;
    }

    public void setEnquiry(String enquiry) {
        this.enquiry = enquiry;
    }

    public Collection<LofGeneraldata> getLofGeneraldataCollection() {
        return lofGeneraldataCollection;
    }

    public void setLofGeneraldataCollection(Collection<LofGeneraldata> lofGeneraldataCollection) {
        this.lofGeneraldataCollection = lofGeneraldataCollection;
    }

    public Collection<ContactPerson> getContactPersonCollection() {
        return contactPersonCollection;
    }

    public void setContactPersonCollection(Collection<ContactPerson> contactPersonCollection) {
        this.contactPersonCollection = contactPersonCollection;
    }

    public SysUser getUsername() {
        return username;
    }

    public void setUsername(SysUser username) {
        this.username = username;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (customerId != null ? customerId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        if ((this.customerId == null && other.customerId != null) || (this.customerId != null && !this.customerId.equals(other.customerId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Customer[ customerId=" + customerId + " ]";
    }
    
}
