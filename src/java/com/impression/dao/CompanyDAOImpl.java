/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Company;
import com.impression.util.NewHibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class CompanyDAOImpl {
    
    public Company getCompanyId(Company c){
        
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction=session.beginTransaction();
        
        if(session!=null){
            try {
                String HQL="From Company c Where c.companyCode=:comanyCode";
                Query query = session.createQuery(HQL);
                query.setParameter("comanyCode",c.getCompanyCode() );
                Company cId = (Company)query.uniqueResult();
                return cId;
            } catch (Exception e) {
            }finally{
                if (session != null && session.isOpen()) {
                    session.close();
                    
                }
            }
        }
        
        return null;
    }
    
}
