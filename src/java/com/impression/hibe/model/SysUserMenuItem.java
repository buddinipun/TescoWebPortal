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

/**
 *
 * @author User
 */
@Entity
@Table(name = "sys_user_menu_item")
@NamedQueries({
    @NamedQuery(name = "SysUserMenuItem.findAll", query = "SELECT s FROM SysUserMenuItem s")})
public class SysUserMenuItem implements Serializable {
    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @Column(name = "has_save_btn")
    private boolean hasSaveBtn;
    @Basic(optional = false)
    @Column(name = "has_update_btn")
    private boolean hasUpdateBtn;
    @Basic(optional = false)
    @Column(name = "has_delete_btn")
    private boolean hasDeleteBtn;
    @Basic(optional = false)
    @Column(name = "has_print_btn")
    private boolean hasPrintBtn;
    @Basic(optional = false)
    @Column(name = "status")
    private boolean status;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "user_menu_id")
    private Integer userMenuId;
    @JoinColumn(name = "menu_item", referencedColumnName = "menu_item_id")
    @ManyToOne(optional = false)
    private MenuItem menuItem;
    @JoinColumn(name = "username", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private SysUser username;
    

    public SysUserMenuItem() {
    }

    public SysUserMenuItem(Integer userMenuId) {
        this.userMenuId = userMenuId;
    }

    public SysUserMenuItem(Integer userMenuId, boolean hasSaveBtn, boolean hasUpdateBtn, boolean hasDeleteBtn, boolean hasPrintBtn, boolean status) {
        this.userMenuId = userMenuId;
        this.hasSaveBtn = hasSaveBtn;
        this.hasUpdateBtn = hasUpdateBtn;
        this.hasDeleteBtn = hasDeleteBtn;
        this.hasPrintBtn = hasPrintBtn;
        this.status = status;
    }

    public SysUserMenuItem(boolean hasSaveBtn, boolean hasUpdateBtn, boolean hasDeleteBtn, boolean hasPrintBtn, boolean status, MenuItem menuItem, SysUser username) {
        this.hasSaveBtn = hasSaveBtn;
        this.hasUpdateBtn = hasUpdateBtn;
        this.hasDeleteBtn = hasDeleteBtn;
        this.hasPrintBtn = hasPrintBtn;
        this.status = status;
        this.userMenuId = userMenuId;
        this.menuItem = menuItem;
        this.username = username;
    }

    public boolean getHasSaveBtn() {
        return hasSaveBtn;
    }

    public void setHasSaveBtn(boolean hasSaveBtn) {
        this.hasSaveBtn = hasSaveBtn;
    }

    public boolean getHasUpdateBtn() {
        return hasUpdateBtn;
    }

    public void setHasUpdateBtn(boolean hasUpdateBtn) {
        this.hasUpdateBtn = hasUpdateBtn;
    }

    public boolean getHasDeleteBtn() {
        return hasDeleteBtn;
    }

    public void setHasDeleteBtn(boolean hasDeleteBtn) {
        this.hasDeleteBtn = hasDeleteBtn;
    }

    public boolean getHasPrintBtn() {
        return hasPrintBtn;
    }

    public void setHasPrintBtn(boolean hasPrintBtn) {
        this.hasPrintBtn = hasPrintBtn;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Integer getUserMenuId() {
        return userMenuId;
    }

    public void setUserMenuId(Integer userMenuId) {
        this.userMenuId = userMenuId;
    }

    public MenuItem getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
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
        hash += (userMenuId != null ? userMenuId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SysUserMenuItem)) {
            return false;
        }
        SysUserMenuItem other = (SysUserMenuItem) object;
        if ((this.userMenuId == null && other.userMenuId != null) || (this.userMenuId != null && !this.userMenuId.equals(other.userMenuId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.SysUserMenuItem[ userMenuId=" + userMenuId + " ]";
    }
    
}
