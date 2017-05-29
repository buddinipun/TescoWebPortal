package com.impression.extractpdf;

import java.util.ArrayList;
import java.util.List;

public class TableData {

	private String ean;
	private String colour;
	private String size;
	private String quantity;
	private String unitCost;
	private String brand;
	
	List<String> eanArr=new ArrayList<String>();
	List<String> colourArr=new ArrayList<String>();
	List<String> unitCostArr=new ArrayList<String>();
	List<String> sizeArr=new ArrayList<String>();
	public List<String> getEanArr() {
		return eanArr;
	}
	public void setEanArr(List<String> eanArr) {
		this.eanArr = eanArr;
	}
	public List<String> getColourArr() {
		return colourArr;
	}
	public void setColourArr(List<String> colourArr) {
		this.colourArr = colourArr;
	}
	public List<String> getUnitCostArr() {
		return unitCostArr;
	}
	public void setUnitCostArr(List<String> unitCostArr) {
		this.unitCostArr = unitCostArr;
	}
	public List<String> getSizeArr() {
		return sizeArr;
	}
	public void setSizeArr(List<String> sizeArr) {
		this.sizeArr = sizeArr;
	}
	

	
	String getEan() {
		return ean;
	}
	void setEan(String ean) {
		this.ean = ean;
	}
	String getColour() {
		return colour;
	}
	void setColour(String colour) {
		this.colour = colour;
	}
	String getSize() {
		return size;
	}
	void setSize(String size) {
		this.size = size;
	}
	String getQuantity() {
		return quantity;
	}
	void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	String getUnitCost() {
		return unitCost;
	}
	void setUnitCost(String unitCost) {
		this.unitCost = unitCost;
	}

    /**
     * @return the brand
     */
    public String getBrand() {
        return brand;
    }

    /**
     * @param brand the brand to set
     */
    public void setBrand(String brand) {
        this.brand = brand;
    }
	
	
}
