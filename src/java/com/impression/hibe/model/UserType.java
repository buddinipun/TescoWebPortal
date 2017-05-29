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
@Table(name = "user_type")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserType.findAll", query = "SELECT u FROM UserType u"),
    @NamedQuery(name = "UserType.findByUserType", query = "SELECT u FROM UserType u WHERE u.userType = :userType"),
    @NamedQuery(name = "UserType.findByTypeName", query = "SELECT u FROM UserType u WHERE u.typeName = :typeName")})
public class UserType implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "user_type")
    private Integer userType;
    @Basic(optional = false)
    @Column(name = "type_name")
    private String typeName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "userType")
    private Collection<SysUser> sysUserCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "personTitle")
    private Collection<ContactPerson> contactPersonCollection;

    public UserType() {
    }

    public UserType(Integer userType) {
        this.userType = userType;
    }

    public UserType(Integer userType, String typeName) {
        this.userType = userType;
        this.typeName = typeName;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @XmlTransient
    public Collection<SysUser> getSysUserCollection() {
        return sysUserCollection;
    }

    public void setSysUserCollection(Collection<SysUser> sysUserCollection) {
        this.sysUserCollection = sysUserCollection;
    }

    @XmlTransient
    public Collection<ContactPerson> getContactPersonCollection() {
        return contactPersonCollection;
    }

    public void setContactPersonCollection(Collection<ContactPerson> contactPersonCollection) {
        this.contactPersonCollection = contactPersonCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userType != null ? userType.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserType)) {
            return false;
        }
        UserType other = (UserType) object;
        if ((this.userType == null && other.userType != null) || (this.userType != null && !this.userType.equals(other.userType))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.UserType[ userType=" + userType + " ]";
    }
    
}
