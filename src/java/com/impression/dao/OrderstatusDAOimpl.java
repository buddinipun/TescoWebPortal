/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Company;
import com.impression.hibe.model.LofGeneraldata;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Intern
 */
public class OrderstatusDAOimpl {
   

    public String cancelorder(LofGeneraldata c) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE LofGeneraldata as l set  l.orderstatus=:orderstatus where l.id =:web_order_no");

                query.setParameter("web_order_no", c.getId());
                query.setParameter("orderstatus", "CANCEL");
                

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.OrderCancel;

            } catch (Exception e) {
                return ImpressionConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
    
    public String Holdorder(LofGeneraldata c) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE LofGeneraldata as l set  l.orderstatus=:orderstatus where l.id =:web_order_no");

                query.setParameter("web_order_no", c.getId());
                query.setParameter("orderstatus", "HOLD");
                

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.OrderCancel;

            } catch (Exception e) {
                return ImpressionConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
    public String Startorder(LofGeneraldata c) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE LofGeneraldata as l set  l.orderstatus=:orderstatus where l.id =:web_order_no");

                query.setParameter("web_order_no", c.getId());
                query.setParameter("orderstatus", "STARTED");
                

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.OrderCancel;

            } catch (Exception e) {
                return ImpressionConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
    public String Delevered(LofGeneraldata c) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE LofGeneraldata as l set  l.orderstatus=:orderstatus where l.id =:web_order_no");

                query.setParameter("web_order_no", c.getId());
                query.setParameter("orderstatus", "Delevered");
                

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.OrderCancel;

            } catch (Exception e) {
                return ImpressionConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
    public String Complete(LofGeneraldata c) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE LofGeneraldata as l set  l.orderstatus=:orderstatus where l.id =:web_order_no");

                query.setParameter("web_order_no", c.getId());
                query.setParameter("orderstatus", "Complete");
                

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.OrderCancel;

            } catch (Exception e) {
                return ImpressionConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
}
