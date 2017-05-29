/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Caretext;
import com.impression.hibe.model.Fiber;
import com.impression.hibe.model.LabelGroup;
import com.impression.hibe.model.Reference;
import com.impression.hibe.model.WashSymbol;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import static org.eclipse.persistence.jpa.jpql.JPAVersion.value;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class ContentUpdateDAO {

    public static int getLastIndex(String type) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                String SQuery = "SELECT symbol_code FROM wash_symbol WHERE symbol_type=:symbol_type ORDER BY symbol_id ASC";
                SQLQuery query = session.createSQLQuery(SQuery);
                query.setParameter("symbol_type", type);
                List<String> user = query.list();
                int data = 0;
                if (user.size() > 0) {
                    String dump = user.get(user.size() - 1);
                    data = Integer.parseInt(dump.substring(1));
                }
                return data;
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
        return 0;
    }

    public static boolean saveWashSymbol(WashSymbol washSymbol) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            int i = -1;
            i = (Integer) session.save(washSymbol);
            session.flush();
            transaction.commit();
            return i > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
    
    public static boolean addLabelReferences(Reference reference) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            int i = -1;

            i = (Integer) session.save(reference);
            session.flush();
            transaction.commit();

            return i > 0;

        } catch (Exception e) {
            if (transaction.isActive() && transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }
    
    public static boolean addLabelGroup(LabelGroup labelGroup) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            int i = -1;

            i = (Integer) session.save(labelGroup);
            session.flush();
            transaction.commit();

            return i > 0;

        } catch (Exception e) {
            if (transaction.isActive() && transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }
    
    public static boolean addFiberMain(Fiber fiber) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            int i = -1;

            i = (Integer) session.save(fiber);
            session.flush();
            transaction.commit();

            return i > 0;

        } catch (Exception e) {
            if (transaction.isActive() && transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }
      public static boolean updatehiberMain(Fiber fiber) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

    Transaction transaction = null;

    
    try {
        transaction = session.beginTransaction();

        String queryString="UPDATE fiber SET d_type=:d_type, english=:english WHERE f_id=:id";
        SQLQuery query=session.createSQLQuery(queryString);

        query.setParameter("d_type", fiber.getDType());
        query.setParameter("id", fiber.getFId());
        query.setParameter("english", fiber.getEnglish());
        int result = query.executeUpdate();

        // System.out.println("Rows affected: " + result);

            // System.out.println("Successfully updated");
        transaction.commit();

    } catch (Exception e) {
        return false;
                   
        //System.out.println("Error--> " + e.getMessage());
    }
   
   return true;
    }
    
    public static boolean addCareText(Caretext careText) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            int i = -1;

            i = (Integer) session.save(careText);
            session.flush();
            transaction.commit();

            return i > 0;

        } catch (Exception e) {
            if (transaction.isActive() && transaction != null) {
                transaction.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }
    //Iresh's Updation.. For retrieving the table from the DB

    public List<Reference> getLableRef() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From Reference";
                Query query = session.createQuery(HQL);
                List<Reference> refList = query.list();
                return refList;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<LabelGroup> getLableGroup() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From LabelGroup";
                Query query = session.createQuery(HQL);
                List<LabelGroup> grpList = query.list();
                return grpList;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Fiber> getFiberMain() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From Fiber";
                Query query = session.createQuery(HQL);
                List<Fiber> fiberMain = query.list();
                return fiberMain;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<Caretext> getCareTexts() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From Caretext";
                Query query = session.createQuery(HQL);
                List<Caretext> careList = query.list();
                return careList;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public List<WashSymbol> getWashSymbols() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From WashSymbol";
                Query query = session.createQuery(HQL);
                List<WashSymbol> simbolList = query.list();
                return simbolList;

            } catch (Exception e) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
    
//End of the Iresh's Updation.. For retrieving the table from the DB

}
