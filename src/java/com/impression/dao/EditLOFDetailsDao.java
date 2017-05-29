/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.LofGeneraldata;
import com.impression.hibe.model.LofLabeltechnicaldata;
import com.impression.hibe.model.LofSwingticletlabeldata;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class EditLOFDetailsDao {

    public LofGeneraldata getLofDetails(String lofID) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String SQuery = "From LofGeneraldata s Where s.lofData=:lofID";
                Query query = session.createQuery(SQuery);
                query.setParameter("lofID", lofID);
                LofGeneraldata user = (LofGeneraldata) query.uniqueResult();
                return user;

            } catch (Exception e) {
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public int deleteLofTechDetails(int lofTechID) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                SQLQuery query = session.createSQLQuery("DELETE FROM lof_labeltechnicaldata WHERE counter=:lofTechID");
                query.addEntity(LofLabeltechnicaldata.class);
                query.setParameter("lofTechID", lofTechID);
                int result = query.executeUpdate();
                transaction.commit();
                return result;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return 0;
    }

    public int deleteLofSwingDetails(int lofSwingID) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                SQLQuery query = session.createSQLQuery("DELETE FROM lof_swingticletlabeldata WHERE counter=:lofSwingID");
                query.addEntity(LofLabeltechnicaldata.class);
                query.setParameter("lofSwingID", lofSwingID);
                int result = query.executeUpdate();
                transaction.commit();
                return result;

            } catch (Exception e) {
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return 0;
    }

}
