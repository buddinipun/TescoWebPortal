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
@Table(name = "templatetb")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Templatetb.findAll", query = "SELECT t FROM Templatetb t"),
    @NamedQuery(name = "Templatetb.findByRefno", query = "SELECT t FROM Templatetb t WHERE t.refno = :refno"),
    @NamedQuery(name = "Templatetb.findByPageno", query = "SELECT t FROM Templatetb t WHERE t.pageno = :pageno"),
    @NamedQuery(name = "Templatetb.findByLno", query = "SELECT t FROM Templatetb t WHERE t.lno = :lno"),
    @NamedQuery(name = "Templatetb.findByObjtype", query = "SELECT t FROM Templatetb t WHERE t.objtype = :objtype"),
    @NamedQuery(name = "Templatetb.findByDfield1", query = "SELECT t FROM Templatetb t WHERE t.dfield1 = :dfield1"),
    @NamedQuery(name = "Templatetb.findByFontsize", query = "SELECT t FROM Templatetb t WHERE t.fontsize = :fontsize"),
    @NamedQuery(name = "Templatetb.findByFontname", query = "SELECT t FROM Templatetb t WHERE t.fontname = :fontname"),
    @NamedQuery(name = "Templatetb.findByLspace", query = "SELECT t FROM Templatetb t WHERE t.lspace = :lspace"),
    @NamedQuery(name = "Templatetb.findByStartp", query = "SELECT t FROM Templatetb t WHERE t.startp = :startp"),
    @NamedQuery(name = "Templatetb.findByXposition", query = "SELECT t FROM Templatetb t WHERE t.xposition = :xposition"),
    @NamedQuery(name = "Templatetb.findById", query = "SELECT t FROM Templatetb t WHERE t.id = :id")})
public class Templatetb implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "refno")
    private String refno;
    @Column(name = "pageno")
    private Integer pageno;
    @Column(name = "lno")
    private Integer lno;
    @Column(name = "objtype")
    private String objtype;
    @Column(name = "dfield1")
    private String dfield1;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "fontsize")
    private Double fontsize;
    @Column(name = "fontname")
    private String fontname;
    @Column(name = "lspace")
    private Double lspace;
    @Column(name = "startp")
    private Double startp;
    @Column(name = "xposition")
    private Double xposition;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    public Templatetb() {
    }

    public Templatetb(Integer id) {
        this.id = id;
    }

    public String getRefno() {
        return refno;
    }

    public void setRefno(String refno) {
        this.refno = refno;
    }

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        this.pageno = pageno;
    }

    public Integer getLno() {
        return lno;
    }

    public void setLno(Integer lno) {
        this.lno = lno;
    }

    public String getObjtype() {
        return objtype;
    }

    public void setObjtype(String objtype) {
        this.objtype = objtype;
    }

    public String getDfield1() {
        return dfield1;
    }

    public void setDfield1(String dfield1) {
        this.dfield1 = dfield1;
    }

    public Double getFontsize() {
        return fontsize;
    }

    public void setFontsize(Double fontsize) {
        this.fontsize = fontsize;
    }

    public String getFontname() {
        return fontname;
    }

    public void setFontname(String fontname) {
        this.fontname = fontname;
    }

    public Double getLspace() {
        return lspace;
    }

    public void setLspace(Double lspace) {
        this.lspace = lspace;
    }

    public Double getStartp() {
        return startp;
    }

    public void setStartp(Double startp) {
        this.startp = startp;
    }

    public Double getXposition() {
        return xposition;
    }

    public void setXposition(Double xposition) {
        this.xposition = xposition;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Templatetb)) {
            return false;
        }
        Templatetb other = (Templatetb) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.impression.hibe.model.Templatetb[ id=" + id + " ]";
    }
    
}
