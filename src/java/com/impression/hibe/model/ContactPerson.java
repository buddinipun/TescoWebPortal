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
@Table(name = "contact_person")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ContactPerson.findAll", query = "SELECT c FROM ContactPerson c"),
    @NamedQuery(name = "ContactPerson.findByPersonId", query = "SELECT c FROM ContactPerson c WHERE c.personId = :personId"),
    @NamedQuery(name = "ContactPerson.findByPersonDesignation", query = "SELECT c FROM ContactPerson c WHERE c.personDesignation = :personDesignation"),
    @NamedQuery(name = "ContactPerson.findByPersonName", query = "SELECT c FROM ContactPerson c WHERE c.personName = :personName"),
    @NamedQuery(name = "ContactPerson.findByPersonTp", query = "SELECT c FROM ContactPerson c WHERE c.personTp = :personTp"),
    @NamedQuery(name = "ContactPerson.findByPersonMobile", query = "SELECT c FROM ContactPerson c WHERE c.personMobile = :personMobile"),
    @NamedQuery(name = "ContactPerson.findByPersonEmail", query = "SELECT c FROM ContactPerson c WHERE c.personEmail = :personEmail"),
    @NamedQuery(name = "ContactPerson.findBySupplier", query = "SELECT c FROM ContactPerson c WHERE c.supplier = :supplier")})
public class ContactPerson implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "person_id")
    private Integer personId;
    @Basic(optional = false)
    @Column(name = "person_designation")
    private String personDesignation;
    @Basic(optional = false)
    @Column(name = "person_name")
    private String personName;
    @Column(name = "person_tp")
    private String personTp;
    @Column(name = "person_mobile")
    private String personMobile;
    @Basic(optional = false)
    @Column(name = "person_email")
    private String personEmail;
    @Column(name = "supplier")
    private Integer supplier;
    @JoinColumn(name = "customer", referencedColumnName = "customer_id")
    @ManyToOne
    private Customer customer;
    @JoinColumn(name = "person_title", referencedColumnName = "user_type")
    @ManyToOne(optional = false)
    private UserType personTitle;

    public ContactPerson() {
    }

    public ContactPerson(Integer personId) {
        this.personId = personId;
    }

    public ContactPerson(Integer personId, String personDesignation, String personName, String personEmail) {
        this.personId = personId;
        this.personDesignation = personDesignation;
        this.personName = personName;
        this.personEmail = personEmail;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public String getPersonDesignation() {
        return personDesignation;
    }

    public void setPersonDesignation(String personDesignation) {
        this.personDesignation = personDesignation;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getPersonTp() {
        return personTp;
    }

    public void setPersonTp(String personTp) {
        this.personTp = personTp;
    }

    public String getPersonMobile() {
        return personMobile;
    }

    public void setPersonMobile(String personMobile) {
        this.personMobile = personMobile;
    }

    public String getPersonEmail() {
        return personEmail;
    }

    public void setPersonEmail(String personEmail) {
        this.personEmail = personEmail;
    }

    public Integer getSupplier() {
        return supplier;
    }

    public void setSupplier(Integer supplier) {
        this.supplier = supplier;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public UserType getPersonTitle() {
        return personTitle;
    }

    public void setPersonTitle(UserType personTitle) {
        this.personTitle = personTitle;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (personId != null ? personId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ContactPerson)) {
            return false;
        }
        ContactPerson other = (ContactPerson) object;
        if ((this.personId == null && other.personId != null) || (this.personId != null && !this.personId.equals(other.personId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.ContactPerson[ personId=" + personId + " ]";
    }
    
}
