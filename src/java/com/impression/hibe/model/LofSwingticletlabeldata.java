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
@Table(name = "lof_swingticletlabeldata")
@NamedQueries({
    @NamedQuery(name = "LofSwingticletlabeldata.findAll", query = "SELECT l FROM LofSwingticletlabeldata l")})
public class LofSwingticletlabeldata implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "counter")
    private Integer counter;
    @Column(name = "REFERENCE")
    private String reference;
    @Column(name = "TREND_NAME")
    private String trendName;
    @Column(name = "PRODUCT_BENIFIT")
    private String productBenifit;
    @Column(name = "PRODUCT_DESCRIPTION")
    private String productDescription;
    @Column(name = "SUPPLIER_ID")
    private String supplierId;
    @Column(name = "JOB_NO")
    private String jobNo;
    @Column(name = "CARE_TEXT")
    private String careText;
    @Column(name = "lbl_type")
    private String lblType;
    @Column(name = "lbl_group")
    private String lblGroup;
    @Column(name = "lbl_description")
    private String lblDescription;
    @Column(name = "wash_symbol")
    private String washSymbol;
    @JoinColumn(name = "web_order_no", referencedColumnName = "web_order_no")
    @ManyToOne(optional = false)
    private LofGeneraldata webOrderNo;

    public LofSwingticletlabeldata() {
    }

    public LofSwingticletlabeldata(String reference, String trendName, String productBenifit, String productDescription, String careText, String lblType, String lblGroup, String lblDescription, String washSymbol, LofGeneraldata webOrderNo) {
        this.reference = reference;
        this.trendName = trendName;
        this.productBenifit = productBenifit;
        this.productDescription = productDescription;
        this.careText = careText;
        this.lblType = lblType;
        this.lblGroup = lblGroup;
        this.lblDescription = lblDescription;
        this.washSymbol = washSymbol;
        this.webOrderNo = webOrderNo;
    }
    public LofSwingticletlabeldata(int count,String reference, String trendName, String productBenifit, String productDescription, String careText, String lblType, String lblGroup, String lblDescription, String washSymbol, LofGeneraldata webOrderNo) {
        this.reference = reference;
        this.trendName = trendName;
        this.productBenifit = productBenifit;
        this.productDescription = productDescription;
        this.careText = careText;
        this.lblType = lblType;
        this.lblGroup = lblGroup;
        this.lblDescription = lblDescription;
        this.washSymbol = washSymbol;
        this.webOrderNo = webOrderNo;
    }

    public LofSwingticletlabeldata(String reference, String trendName, String productBenifit, String productDescription, String supplierId, String jobNo, String careText, LofGeneraldata webOrderNo) {
        this.reference = reference;
        this.trendName = trendName;
        this.productBenifit = productBenifit;
        this.productDescription = productDescription;
        this.supplierId = supplierId;
        this.jobNo = jobNo;
        this.careText = careText;
        this.webOrderNo = webOrderNo;
    }

    public LofSwingticletlabeldata(Integer count) {
        this.counter = count;
    }

    public Integer getCount() {
        return counter;
    }

    public void setCount(Integer count) {
        this.counter = count;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getTrendName() {
        return trendName;
    }

    public void setTrendName(String trendName) {
        this.trendName = trendName;
    }

    public String getProductBenifit() {
        return productBenifit;
    }

    public void setProductBenifit(String productBenifit) {
        this.productBenifit = productBenifit;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getJobNo() {
        return jobNo;
    }

    public void setJobNo(String jobNo) {
        this.jobNo = jobNo;
    }

    public String getCareText() {
        return careText;
    }

    public void setCareText(String careText) {
        this.careText = careText;
    }

    public String getLblType() {
        return lblType;
    }

    public void setLblType(String lblType) {
        this.lblType = lblType;
    }

    public String getLblGroup() {
        return lblGroup;
    }

    public void setLblGroup(String lblGroup) {
        this.lblGroup = lblGroup;
    }

    public String getLblDescription() {
        return lblDescription;
    }

    public void setLblDescription(String lblDescription) {
        this.lblDescription = lblDescription;
    }

    public String getWashSymbol() {
        return washSymbol;
    }

    public void setWashSymbol(String washSymbol) {
        this.washSymbol = washSymbol;
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
        hash += (counter != null ? counter.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LofSwingticletlabeldata)) {
            return false;
        }
        LofSwingticletlabeldata other = (LofSwingticletlabeldata) object;
        if ((this.counter == null && other.counter != null) || (this.counter != null && !this.counter.equals(other.counter))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.LofSwingticletlabeldata[ count=" + counter + " ]";
    }

}
