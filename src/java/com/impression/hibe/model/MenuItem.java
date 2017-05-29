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
@Table(name = "menu_item")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MenuItem.findAll", query = "SELECT m FROM MenuItem m"),
    @NamedQuery(name = "MenuItem.findByMenuItemId", query = "SELECT m FROM MenuItem m WHERE m.menuItemId = :menuItemId"),
    @NamedQuery(name = "MenuItem.findByMenuItemName", query = "SELECT m FROM MenuItem m WHERE m.menuItemName = :menuItemName"),
    @NamedQuery(name = "MenuItem.findByMenuItemUrl", query = "SELECT m FROM MenuItem m WHERE m.menuItemUrl = :menuItemUrl"),
    @NamedQuery(name = "MenuItem.findByMenuItemOrder", query = "SELECT m FROM MenuItem m WHERE m.menuItemOrder = :menuItemOrder"),
    @NamedQuery(name = "MenuItem.findByMainMenu", query = "SELECT m FROM MenuItem m WHERE m.mainMenu = :mainMenu"),
    @NamedQuery(name = "MenuItem.findByHasSaveBtn", query = "SELECT m FROM MenuItem m WHERE m.hasSaveBtn = :hasSaveBtn"),
    @NamedQuery(name = "MenuItem.findByHasUpdateBtn", query = "SELECT m FROM MenuItem m WHERE m.hasUpdateBtn = :hasUpdateBtn"),
    @NamedQuery(name = "MenuItem.findByHasDeleteBtn", query = "SELECT m FROM MenuItem m WHERE m.hasDeleteBtn = :hasDeleteBtn"),
    @NamedQuery(name = "MenuItem.findByHasPrintBtn", query = "SELECT m FROM MenuItem m WHERE m.hasPrintBtn = :hasPrintBtn")})
public class MenuItem implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "menu_item_id")
    private Integer menuItemId;
    @Basic(optional = false)
    @Column(name = "menu_item_name")
    private String menuItemName;
    @Basic(optional = false)
    @Column(name = "menu_item_url")
    private String menuItemUrl;
    @Column(name = "menu_item_order")
    private Integer menuItemOrder;
    @Column(name = "main_menu")
    private Integer mainMenu;
    @Column(name = "has_save_btn")
    private Boolean hasSaveBtn;
    @Column(name = "has_update_btn")
    private Boolean hasUpdateBtn;
    @Column(name = "has_delete_btn")
    private Boolean hasDeleteBtn;
    @Column(name = "has_print_btn")
    private Boolean hasPrintBtn;

    public MenuItem() {
    }

    public MenuItem(Integer menuItemId) {
        this.menuItemId = menuItemId;
    }

    public MenuItem(Integer menuItemId, String menuItemName, String menuItemUrl) {
        this.menuItemId = menuItemId;
        this.menuItemName = menuItemName;
        this.menuItemUrl = menuItemUrl;
    }

    public Integer getMenuItemId() {
        return menuItemId;
    }

    public void setMenuItemId(Integer menuItemId) {
        this.menuItemId = menuItemId;
    }

    public String getMenuItemName() {
        return menuItemName;
    }

    public void setMenuItemName(String menuItemName) {
        this.menuItemName = menuItemName;
    }

    public String getMenuItemUrl() {
        return menuItemUrl;
    }

    public void setMenuItemUrl(String menuItemUrl) {
        this.menuItemUrl = menuItemUrl;
    }

    public Integer getMenuItemOrder() {
        return menuItemOrder;
    }

    public void setMenuItemOrder(Integer menuItemOrder) {
        this.menuItemOrder = menuItemOrder;
    }

    public Integer getMainMenu() {
        return mainMenu;
    }

    public void setMainMenu(Integer mainMenu) {
        this.mainMenu = mainMenu;
    }

    public Boolean getHasSaveBtn() {
        return hasSaveBtn;
    }

    public void setHasSaveBtn(Boolean hasSaveBtn) {
        this.hasSaveBtn = hasSaveBtn;
    }

    public Boolean getHasUpdateBtn() {
        return hasUpdateBtn;
    }

    public void setHasUpdateBtn(Boolean hasUpdateBtn) {
        this.hasUpdateBtn = hasUpdateBtn;
    }

    public Boolean getHasDeleteBtn() {
        return hasDeleteBtn;
    }

    public void setHasDeleteBtn(Boolean hasDeleteBtn) {
        this.hasDeleteBtn = hasDeleteBtn;
    }

    public Boolean getHasPrintBtn() {
        return hasPrintBtn;
    }

    public void setHasPrintBtn(Boolean hasPrintBtn) {
        this.hasPrintBtn = hasPrintBtn;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (menuItemId != null ? menuItemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MenuItem)) {
            return false;
        }
        MenuItem other = (MenuItem) object;
        if ((this.menuItemId == null && other.menuItemId != null) || (this.menuItemId != null && !this.menuItemId.equals(other.menuItemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.MenuItem[ menuItemId=" + menuItemId + " ]";
    }
    
}
