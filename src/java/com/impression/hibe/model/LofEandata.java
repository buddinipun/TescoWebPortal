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
@Table(name = "lof_eandata")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LofEandata.findAll", query = "SELECT l FROM LofEandata l"),
    @NamedQuery(name = "LofEandata.findByCount", query = "SELECT l FROM LofEandata l WHERE l.count = :count"),
    @NamedQuery(name = "LofEandata.findByEANNouk", query = "SELECT l FROM LofEandata l WHERE l.eANNouk = :eANNouk"),
    @NamedQuery(name = "LofEandata.findByEANNoce", query = "SELECT l FROM LofEandata l WHERE l.eANNoce = :eANNoce"),
    @NamedQuery(name = "LofEandata.findByUk", query = "SELECT l FROM LofEandata l WHERE l.uk = :uk"),
    @NamedQuery(name = "LofEandata.findByEur", query = "SELECT l FROM LofEandata l WHERE l.eur = :eur"),
    @NamedQuery(name = "LofEandata.findByUs", query = "SELECT l FROM LofEandata l WHERE l.us = :us"),
    @NamedQuery(name = "LofEandata.findByMx", query = "SELECT l FROM LofEandata l WHERE l.mx = :mx"),
    @NamedQuery(name = "LofEandata.findBySecSize1", query = "SELECT l FROM LofEandata l WHERE l.secSize1 = :secSize1"),
    @NamedQuery(name = "LofEandata.findBySecSize2", query = "SELECT l FROM LofEandata l WHERE l.secSize2 = :secSize2"),
    @NamedQuery(name = "LofEandata.findBySecSize3", query = "SELECT l FROM LofEandata l WHERE l.secSize3 = :secSize3"),
    @NamedQuery(name = "LofEandata.findBySecSize4", query = "SELECT l FROM LofEandata l WHERE l.secSize4 = :secSize4"),
    @NamedQuery(name = "LofEandata.findByEuro", query = "SELECT l FROM LofEandata l WHERE l.euro = :euro"),
    @NamedQuery(name = "LofEandata.findByPound", query = "SELECT l FROM LofEandata l WHERE l.pound = :pound"),
    @NamedQuery(name = "LofEandata.findByCz", query = "SELECT l FROM LofEandata l WHERE l.cz = :cz"),
    @NamedQuery(name = "LofEandata.findBySk", query = "SELECT l FROM LofEandata l WHERE l.sk = :sk"),
    @NamedQuery(name = "LofEandata.findByEn", query = "SELECT l FROM LofEandata l WHERE l.en = :en"),
    @NamedQuery(name = "LofEandata.findByHu", query = "SELECT l FROM LofEandata l WHERE l.hu = :hu"),
    @NamedQuery(name = "LofEandata.findByTr", query = "SELECT l FROM LofEandata l WHERE l.tr = :tr"),
    @NamedQuery(name = "LofEandata.findByDept", query = "SELECT l FROM LofEandata l WHERE l.dept = :dept"),
    @NamedQuery(name = "LofEandata.findByColor", query = "SELECT l FROM LofEandata l WHERE l.color = :color"),
    @NamedQuery(name = "LofEandata.findByQuantity", query = "SELECT l FROM LofEandata l WHERE l.quantity = :quantity")})
public class LofEandata implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "count")
    private Integer count;
    @Basic(optional = false)
    @Column(name = "EAN_No_uk")
    private String eANNouk;
    @Column(name = "EAN_No_ce")
    private String eANNoce;
    @Column(name = "UK")
    private String uk;
    @Column(name = "EUR")
    private String eur;
    @Column(name = "US")
    private String us;
    @Column(name = "MX")
    private String mx;
    @Column(name = "Sec_Size1")
    private String secSize1;
    @Column(name = "Sec_Size2")
    private String secSize2;
    @Column(name = "Sec_Size3")
    private String secSize3;
    @Column(name = "Sec_Size4")
    private String secSize4;
    @Column(name = "Euro")
    private String euro;
    @Column(name = "pound")
    private String pound;
    @Column(name = "CZ")
    private String cz;
    @Column(name = "SK")
    private String sk;
    @Column(name = "EN")
    private String en;
    @Column(name = "HU")
    private String hu;
    @Column(name = "TR")
    private String tr;
    @Column(name = "dept")
    private String dept;
    @Column(name = "color")
    private String color;
    @Column(name = "quantity")
    private Integer quantity;
    @JoinColumn(name = "web_order_no", referencedColumnName = "web_order_no")
    @ManyToOne(optional = false)
    private LofGeneraldata webOrderNo;

    public LofEandata() {
    }

    public LofEandata(Integer count) {
        this.count = count;
    }

    public LofEandata(Integer count, String eANNouk) {
        this.count = count;
        this.eANNouk = eANNouk;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getEANNouk() {
        return eANNouk;
    }

    public void setEANNouk(String eANNouk) {
        this.eANNouk = eANNouk;
    }

    public String getEANNoce() {
        return eANNoce;
    }

    public void setEANNoce(String eANNoce) {
        this.eANNoce = eANNoce;
    }

    public String getUk() {
        return uk;
    }

    public void setUk(String uk) {
        this.uk = uk;
    }

    public String getEur() {
        return eur;
    }

    public void setEur(String eur) {
        this.eur = eur;
    }

    public String getUs() {
        return us;
    }

    public void setUs(String us) {
        this.us = us;
    }

    public String getMx() {
        return mx;
    }

    public void setMx(String mx) {
        this.mx = mx;
    }

    public String getSecSize1() {
        return secSize1;
    }

    public void setSecSize1(String secSize1) {
        this.secSize1 = secSize1;
    }

    public String getSecSize2() {
        return secSize2;
    }

    public void setSecSize2(String secSize2) {
        this.secSize2 = secSize2;
    }

    public String getSecSize3() {
        return secSize3;
    }

    public void setSecSize3(String secSize3) {
        this.secSize3 = secSize3;
    }

    public String getSecSize4() {
        return secSize4;
    }

    public void setSecSize4(String secSize4) {
        this.secSize4 = secSize4;
    }

    public String getEuro() {
        return euro;
    }

    public void setEuro(String euro) {
        this.euro = euro;
    }

    public String getPound() {
        return pound;
    }

    public void setPound(String pound) {
        this.pound = pound;
    }

    public String getCz() {
        return cz;
    }

    public void setCz(String cz) {
        this.cz = cz;
    }

    public String getSk() {
        return sk;
    }

    public void setSk(String sk) {
        this.sk = sk;
    }

    public String getEn() {
        return en;
    }

    public void setEn(String en) {
        this.en = en;
    }

    public String getHu() {
        return hu;
    }

    public void setHu(String hu) {
        this.hu = hu;
    }

    public String getTr() {
        return tr;
    }

    public void setTr(String tr) {
        this.tr = tr;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public LofGeneraldata getWebOrderNo() {
        return webOrderNo;
    }

    public void setWebOrderNo(LofGeneraldata webOrderNo) {
        this.webOrderNo = webOrderNo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (count != null ? count.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LofEandata)) {
            return false;
        }
        LofEandata other = (LofEandata) object;
        if ((this.count == null && other.count != null) || (this.count != null && !this.count.equals(other.count))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.LofEandata[ count=" + count + " ]";
    }
    
}
