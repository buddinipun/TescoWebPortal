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
@Table(name = "wash_symbol")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "WashSymbol.findAll", query = "SELECT w FROM WashSymbol w"),
    @NamedQuery(name = "WashSymbol.findBySymbolId", query = "SELECT w FROM WashSymbol w WHERE w.symbolId = :symbolId"),
    @NamedQuery(name = "WashSymbol.findBySymbolCode", query = "SELECT w FROM WashSymbol w WHERE w.symbolCode = :symbolCode"),
    @NamedQuery(name = "WashSymbol.findBySymbolType", query = "SELECT w FROM WashSymbol w WHERE w.symbolType = :symbolType"),
    @NamedQuery(name = "WashSymbol.findByImageUrl", query = "SELECT w FROM WashSymbol w WHERE w.imageUrl = :imageUrl"),
    @NamedQuery(name = "WashSymbol.findByDetails", query = "SELECT w FROM WashSymbol w WHERE w.details = :details")})
public class WashSymbol implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "symbol_id")
    private Integer symbolId;
    @Basic(optional = false)
    @Column(name = "symbol_code")
    private String symbolCode;
    @Column(name = "symbol_type")
    private String symbolType;
    @Basic(optional = false)
    @Column(name = "image_url")
    private String imageUrl;
    @Basic(optional = false)
    @Column(name = "details")
    private String details;

    public WashSymbol() {
    }

    public WashSymbol(Integer symbolId) {
        this.symbolId = symbolId;
    }

    public WashSymbol(Integer symbolId, String symbolCode, String imageUrl, String details) {
        this.symbolId = symbolId;
        this.symbolCode = symbolCode;
        this.imageUrl = imageUrl;
        this.details = details;
    }

    public WashSymbol(String symbolCode, String imageUrl, String details, String symbolType) {
        this.symbolCode = symbolCode;
        this.imageUrl = imageUrl;
        this.details = details;
        this.symbolType = symbolType;
    }

    public Integer getSymbolId() {
        return symbolId;
    }

    public void setSymbolId(Integer symbolId) {
        this.symbolId = symbolId;
    }

    public String getSymbolCode() {
        return symbolCode;
    }

    public void setSymbolCode(String symbolCode) {
        this.symbolCode = symbolCode;
    }

    public String getSymbolType() {
        return symbolType;
    }

    public void setSymbolType(String symbolType) {
        this.symbolType = symbolType;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (symbolId != null ? symbolId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof WashSymbol)) {
            return false;
        }
        WashSymbol other = (WashSymbol) object;
        if ((this.symbolId == null && other.symbolId != null) || (this.symbolId != null && !this.symbolId.equals(other.symbolId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.WashSymbol[ symbolId=" + symbolId + " ]";
    }
    
}
