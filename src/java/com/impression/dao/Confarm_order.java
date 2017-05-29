/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.LofGeneraldata;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class Confarm_order {
    public List<LofGeneraldata> confarm_order(String name){
        Session session=NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction=session.beginTransaction();
        
        if(session!=null){
            try {
                String HQL="From LofGeneraldata where lof_data:name";
                Query query = session.createQuery(HQL);
                query.setParameter(name, "name");
                List<LofGeneraldata> gdata = query.list();
                return gdata;
            } catch (Exception e) {
            }finally{
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        
        return null;
    }
    
    public Long getTotalQuantity(int webOrder) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                
                String SQL = "select sum(quantity) from LofEandata l where l.webOrderNo.webOrderNo=:webOrder";
//                String SQL = "select avg(se.marks) as marks from SubjectEMarks se where se.subject.subjectId=:subjectId";
                Query query = session.createQuery(SQL);
                //  query.addEntity(SubjectEMarks.class);
                query.setParameter("webOrder", webOrder);
                Long sum = (Long) query.uniqueResult();
                return sum;
            } catch (Exception e) {
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();

                }
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
    
}
