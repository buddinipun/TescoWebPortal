/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.Company;
import com.impression.hibe.model.Customer;
import com.impression.hibe.model.SysUser;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class GarmentDAOImp {

    public String updateGarment(Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                Query query = session.createQuery("UPDATE Company as c set  c.companyCode=:companyCode, c.companyName=:companyName, c.companyDomain=:companyDomain, c.sales=:sales, c.cs=:cs, c.artwork=:artwork where c.companyId =:companyId");

                query.setParameter("companyId", company.getCompanyId());
                query.setParameter("companyCode", company.getCompanyCode());
                query.setParameter("companyName", company.getCompanyName());
                query.setParameter("companyDomain", company.getCompanyDomain());
                query.setParameter("sales", company.getSales());
                query.setParameter("cs", company.getCs());
                query.setParameter("artwork", company.getArtwork());

                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.GARMENTUPDATED;

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

    public String saveGarment(Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {

                session.save(company);
                session.flush();

                transaction.commit();
                return ImpressionConstants.GARMENTUPDATED;

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

    public SysUser getCS(Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From SysUser s Where s.username=:username";
                Query query = session.createQuery(HQL);

                query.setParameter("username", company.getCs());
                SysUser sysUser = (SysUser) query.uniqueResult();
                return sysUser;

            } catch (Exception e) {
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public SysUser getSales(Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From SysUser s Where s.username=:username";
                Query query = session.createQuery(HQL);
//                query.setParameter("companyId", company.getCompanyId());
                query.setParameter("username", company.getSales());
                SysUser sysUser = (SysUser) query.uniqueResult();
                return sysUser;

            } catch (Exception e) {
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }

    public SysUser getArtWork(Company company) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String HQL = "From SysUser s Where s.username=:username";
                Query query = session.createQuery(HQL);
//                query.setParameter("companyId", company.getCompanyId());
                query.setParameter("username", company.getArtwork());
                SysUser sysUser = (SysUser) query.uniqueResult();
                return sysUser;

            } catch (Exception e) {
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;
    }
}
