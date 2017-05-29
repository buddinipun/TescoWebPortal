/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.hibe.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author oatta
 */
@Entity
@Table(name = "lof_generaldata")
@NamedQueries({
    @NamedQuery(name = "LofGeneraldata.findAll", query = "SELECT l FROM LofGeneraldata l")})
public class LofGeneraldata implements Serializable {
    @Column(name = "orderstatus")
    private String orderstatus;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "web_order_no")
    private Integer webOrderNo;
    @Basic(optional = false)
    @Column(name = "id")
    private String id;
    @Column(name = "purchase_order_uk")
    private String purchaseOrderUk;
    @Column(name = "purchase_order_ce")
    private String purchaseOrderCe;
    @Column(name = "category")
    private String category;
    @Column(name = "country_of_origin")
    private String countryOfOrigin;
    @Column(name = "additional_comment")
    private String additionalComment;
    @Column(name = "style_no_uk")
    private String styleNoUk;
    @Column(name = "style_no_ce")
    private String styleNoCe;
    @Column(name = "charactor_tf_des")
    private String charactorTfDes;
    @Column(name = "season_code")
    private String seasonCode;
    @Column(name = "brand")
    private String brand;
    @Column(name = "style_type")
    private String styleType;
    @Column(name = "department")
    private String department;
    @Column(name = "supplier_no")
    private String supplierNo;
    @Column(name = "supplier_code")
    private String supplierCode;
    @Column(name = "factory_code")
    private String factoryCode;
    @Column(name = "lof_data")
    private String lofData;
    @Basic(optional = false)
    @Column(name = "conf_order")
    private String confOrder;
    @Column(name = "cartoon_dimention")
    private String cartoonDimention;
    @Column(name = "tog_value")
    private String togValue;
    @Column(name = "ordered_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderedDate;
    @Column(name = "customer_po")
    private String customerPo;
    @Column(name = "art_request_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date artRequestDate;
    @Column(name = "art_upload_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date artUploadDate;
    @Column(name = "art_confirm_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date artConfirmDate;
    @Column(name = "order_delivery_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderDeliveryDate;
    @Column(name = "artwork_status")
    private String artworkStatus;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "webOrderNo", fetch = FetchType.EAGER)
    private Collection<LofLabeltechnicaldata> lofLabeltechnicaldataCollection;
    @JoinColumn(name = "customer", referencedColumnName = "customer_id")
    @ManyToOne(optional = false)
    private Customer customer;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "webOrderNo", fetch = FetchType.EAGER)
    private Collection<LofSwingticletlabeldata> lofSwingticletlabeldataCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "webOrderNo", fetch = FetchType.EAGER)
    private Collection<LofEandata> lofEandataCollection;

    public LofGeneraldata() {
    }

    public LofGeneraldata(Integer webOrderNo) {
        this.webOrderNo = webOrderNo;
    }

    public LofGeneraldata(Integer webOrderNo, String id, String confOrder) {
        this.webOrderNo = webOrderNo;
        this.id = id;
        this.confOrder = confOrder;
    }

    public LofGeneraldata(String id, String purchaseOrderUk, String purchaseOrderCe, String category, String countryOfOrigin, String additionalComment, String styleNoUk, String styleNoCe, String seasonCode, String brand, String styleType, String supplierNo, String supplierCode, String factoryCode, String lofData, String confOrder, Date orderedDate, Customer customer, String customer_po, String tog_value) {
        this.id = id;
        this.purchaseOrderUk = purchaseOrderUk;
        this.purchaseOrderCe = purchaseOrderCe;
        this.category = category;
        this.countryOfOrigin = countryOfOrigin;
        this.additionalComment = additionalComment;
        this.styleNoUk = styleNoUk;
        this.styleNoCe = styleNoCe;
//        this.charactorTfDes = charactorTfDes;
        this.seasonCode = seasonCode;
        this.brand = brand;
        this.styleType = styleType;
        this.supplierNo = supplierNo;
        this.supplierCode = supplierCode;
        this.factoryCode = factoryCode;
        this.lofData = lofData;
        this.confOrder = confOrder;
//        this.cartoonDimention = cartoonDimention;
        this.orderedDate = orderedDate;
        this.customer = customer;
        this.customerPo = customer_po;
        this.togValue = tog_value;
    }

    public LofGeneraldata(String id, String purchaseOrderUk, String purchaseOrderCe, String category, String countryOfOrigin, String additionalComment, String styleNoUk, String styleNoCe, String seasonCode, String brand, String styleType, String supplierNo, String supplierCode, String factoryCode, String lofData, String confOrder, Date orderedDate, Customer customer, String customer_po, String tog_value, Collection<LofLabeltechnicaldata> techdata) {
        this.id = id;
        this.purchaseOrderUk = purchaseOrderUk;
        this.purchaseOrderCe = purchaseOrderCe;
        this.category = category;
        this.countryOfOrigin = countryOfOrigin;
        this.additionalComment = additionalComment;
        this.styleNoUk = styleNoUk;
        this.styleNoCe = styleNoCe;
//        this.charactorTfDes = charactorTfDes;
        this.seasonCode = seasonCode;
        this.brand = brand;
        this.styleType = styleType;
        this.supplierNo = supplierNo;
        this.supplierCode = supplierCode;
        this.factoryCode = factoryCode;
        this.lofData = lofData;
        this.confOrder = confOrder;
//        this.cartoonDimention = cartoonDimention;
        this.orderedDate = orderedDate;
        this.customer = customer;
        this.customerPo = customer_po;
        this.togValue = tog_value;
        this.lofLabeltechnicaldataCollection = techdata;
    }

    public LofGeneraldata(int orderid, String id, String purchaseOrderUk, String purchaseOrderCe, String category, String countryOfOrigin, String additionalComment, String styleNoUk, String styleNoCe, String seasonCode, String brand, String styleType, String supplierNo, String supplierCode, String factoryCode, String lofData, String confOrder, Date orderedDate, Customer customer, String customer_po, String tog_value) {
        this.webOrderNo = orderid;
        this.id = id;
        this.purchaseOrderUk = purchaseOrderUk;
        this.purchaseOrderCe = purchaseOrderCe;
        this.category = category;
        this.countryOfOrigin = countryOfOrigin;
        this.additionalComment = additionalComment;
        this.styleNoUk = styleNoUk;
        this.styleNoCe = styleNoCe;
//        this.charactorTfDes = charactorTfDes;
        this.seasonCode = seasonCode;
        this.brand = brand;
        this.styleType = styleType;
        this.supplierNo = supplierNo;
        this.supplierCode = supplierCode;
        this.factoryCode = factoryCode;
        this.lofData = lofData;
        this.confOrder = confOrder;
//        this.cartoonDimention = cartoonDimention;
        this.orderedDate = orderedDate;
        this.customer = customer;
        this.customerPo = customer_po;
        this.togValue = tog_value;
    }

    public Integer getWebOrderNo() {
        return webOrderNo;
    }

    public void setWebOrderNo(Integer webOrderNo) {
        this.webOrderNo = webOrderNo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPurchaseOrderUk() {
        return purchaseOrderUk;
    }

    public void setPurchaseOrderUk(String purchaseOrderUk) {
        this.purchaseOrderUk = purchaseOrderUk;
    }

    public String getPurchaseOrderCe() {
        return purchaseOrderCe;
    }

    public void setPurchaseOrderCe(String purchaseOrderCe) {
        this.purchaseOrderCe = purchaseOrderCe;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCountryOfOrigin() {
        return countryOfOrigin;
    }

    public void setCountryOfOrigin(String countryOfOrigin) {
        this.countryOfOrigin = countryOfOrigin;
    }

    public String getAdditionalComment() {
        return additionalComment;
    }

    public void setAdditionalComment(String additionalComment) {
        this.additionalComment = additionalComment;
    }

    public String getStyleNoUk() {
        return styleNoUk;
    }

    public void setStyleNoUk(String styleNoUk) {
        this.styleNoUk = styleNoUk;
    }

    public String getStyleNoCe() {
        return styleNoCe;
    }

    public void setStyleNoCe(String styleNoCe) {
        this.styleNoCe = styleNoCe;
    }

    public String getCharactorTfDes() {
        return charactorTfDes;
    }

    public void setCharactorTfDes(String charactorTfDes) {
        this.charactorTfDes = charactorTfDes;
    }

    public String getSeasonCode() {
        return seasonCode;
    }

    public void setSeasonCode(String seasonCode) {
        this.seasonCode = seasonCode;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getSupplierNo() {
        return supplierNo;
    }

    public void setSupplierNo(String supplierNo) {
        this.supplierNo = supplierNo;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    public String getLofData() {
        return lofData;
    }

    public void setLofData(String lofData) {
        this.lofData = lofData;
    }

    public String getConfOrder() {
        return confOrder;
    }

    public void setConfOrder(String confOrder) {
        this.confOrder = confOrder;
    }

    public String getCartoonDimention() {
        return cartoonDimention;
    }

    public void setCartoonDimention(String cartoonDimention) {
        this.cartoonDimention = cartoonDimention;
    }

    public String getTogValue() {
        return togValue;
    }

    public void setTogValue(String togValue) {
        this.togValue = togValue;
    }

    public Date getOrderedDate() {
        return orderedDate;
    }

    public void setOrderedDate(Date orderedDate) {
        this.orderedDate = orderedDate;
    }

    public String getCustomerPo() {
        return customerPo;
    }

    public void setCustomerPo(String customerPo) {
        this.customerPo = customerPo;
    }

    public Date getArtRequestDate() {
        return artRequestDate;
    }

    public void setArtRequestDate(Date artRequestDate) {
        this.artRequestDate = artRequestDate;
    }

    public Date getArtUploadDate() {
        return artUploadDate;
    }

    public void setArtUploadDate(Date artUploadDate) {
        this.artUploadDate = artUploadDate;
    }

    public Date getArtConfirmDate() {
        return artConfirmDate;
    }

    public void setArtConfirmDate(Date artConfirmDate) {
        this.artConfirmDate = artConfirmDate;
    }

    public Date getOrderDeliveryDate() {
        return orderDeliveryDate;
    }

    public void setOrderDeliveryDate(Date orderDeliveryDate) {
        this.orderDeliveryDate = orderDeliveryDate;
    }

    public String getArtworkStatus() {
        return artworkStatus;
    }

    public void setArtworkStatus(String artworkStatus) {
        this.artworkStatus = artworkStatus;
    }

    public Collection<LofLabeltechnicaldata> getLofLabeltechnicaldataCollection() {
        return lofLabeltechnicaldataCollection;
    }

    public void setLofLabeltechnicaldataCollection(Collection<LofLabeltechnicaldata> lofLabeltechnicaldataCollection) {
        this.lofLabeltechnicaldataCollection = lofLabeltechnicaldataCollection;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Collection<LofSwingticletlabeldata> getLofSwingticletlabeldataCollection() {
        return lofSwingticletlabeldataCollection;
    }

    public void setLofSwingticletlabeldataCollection(Collection<LofSwingticletlabeldata> lofSwingticletlabeldataCollection) {
        this.lofSwingticletlabeldataCollection = lofSwingticletlabeldataCollection;
    }

    public Collection<LofEandata> getLofEandataCollection() {
        return lofEandataCollection;
    }

    public void setLofEandataCollection(Collection<LofEandata> lofEandataCollection) {
        this.lofEandataCollection = lofEandataCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (webOrderNo != null ? webOrderNo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LofGeneraldata)) {
            return false;
        }
        LofGeneraldata other = (LofGeneraldata) object;
        if ((this.webOrderNo == null && other.webOrderNo != null) || (this.webOrderNo != null && !this.webOrderNo.equals(other.webOrderNo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.LofGeneraldata[ webOrderNo=" + webOrderNo + " ]";
    }

    public String getOrderstatus() {
        return orderstatus;
    }

    public void setOrderstatus(String orderstatus) {
        this.orderstatus = orderstatus;
    }

}
