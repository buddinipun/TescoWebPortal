/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.TechnicalTeam;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import org.bouncycastle.asn1.isismtt.x509.Restriction;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Intern
 */
public class TechTeamDAO {

    public boolean saveMenuItem(TechnicalTeam technicalTeam) {

//        Session session = NewHibernateUtil.getSessionFactory().openSession();
//        Transaction transaction = session.beginTransaction();
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            // System.out.println(technicalTeam.getCountry());
            session.save(technicalTeam);
            // System.out.println("-----------------------------------------------");
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (transaction.isActive() && transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                transaction.commit();
                session.close();
            }
        }

        return false;
    }

    public List getTechTeamData(String country_select) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        List techDetails = null;

        if (session != null) {
            try {
                // System.out.println("Country value in Dao : " + country_select);
                Criteria criteria = session.createCriteria(TechnicalTeam.class);
                criteria.add(Restrictions.eq("country", country_select));

                techDetails = criteria.list();
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                session.close();
            }
        }
        return techDetails;
    }

}
