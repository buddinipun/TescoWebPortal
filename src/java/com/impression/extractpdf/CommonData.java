package com.impression.extractpdf;

import java.util.ArrayList;
import java.util.List;

public class CommonData {

    private String poNumUK = "";
    private String poNumCE = "";
    private String supplierno = "";

    public String getSupplierno() {
        return supplierno;
    }

    public void setSupplierno(String supplierno) {
        this.supplierno = supplierno;
    }
    private String name;
    private String country;
    private String commentField;
    private String productDes;
    private String styleNoUK = "";
    private String styleNoCE = "";
    private String char24Des;
    private String seasonCode;
    private String category;
    private String cartonDimensions;
    private String brand;

    private List<String> eanArr = new ArrayList<String>();
    private List<String> dummyeanArr = new ArrayList<String>();
    private List<String> sizeArr = new ArrayList<String>();

    public List<String> getDummyeanArr() {
        return dummyeanArr;
    }

    public void setDummyeanArr(List<String> dummyeanArr) {
        this.dummyeanArr = dummyeanArr;
    }

    public String getPoNumUK() {
        return poNumUK;
    }

    public void setPoNumUK(String poNumUK) {
        this.poNumUK = poNumUK;
    }

    public String getPoNumCE() {
        return poNumCE;
    }

    public void setPoNumCE(String poNumCE) {
        this.poNumCE = poNumCE;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCommentField() {
        return commentField;
    }

    public void setCommentField(String commentField) {
        this.commentField = commentField;
    }

    public String getProductDes() {
        return productDes;
    }

    public void setProductDes(String productDes) {
        this.productDes = productDes;
    }

    public String getStyleNoUK() {
        return styleNoUK;
    }

    public void setStyleNoUK(String styleNoUK) {
        this.styleNoUK = styleNoUK;
    }

    public String getStyleNoCE() {
        return styleNoCE;
    }

    public void setStyleNoCE(String styleNoCE) {
        this.styleNoCE = styleNoCE;
    }

    public String getChar24Des() {
        return char24Des;
    }

    public void setChar24Des(String char24Des) {
        this.char24Des = char24Des;
    }

    public String getSeasonCode() {
        return seasonCode;
    }

    public void setSeasonCode(String seasonCode) {
        this.seasonCode = seasonCode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCartonDimensions() {
        return cartonDimensions;
    }

    public void setCartonDimensions(String cartonDimensions) {
        this.cartonDimensions = cartonDimensions;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public List<String> getEanArr() {
        return eanArr;
    }

    public void setEanArr(List<String> eanArr) {
        this.eanArr = eanArr;
    }

    public List<String> getSizeArr() {
        return sizeArr;
    }

    public void setSizeArr(List<String> sizeArr) {
        this.sizeArr = sizeArr;
    }

   
    
}
