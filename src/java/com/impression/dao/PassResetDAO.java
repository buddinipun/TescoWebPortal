/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.dao;

import com.impression.hibe.model.SysUser;
import com.impression.util.ImpressionConstants;
import com.impression.util.NewHibernateUtil;
import java.util.List;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Kalana
 */
public class PassResetDAO {

    static String sender_email = "impression@gmail.com";
    static String password = "xxxxxxxxxxxxxxxxxx";
    static String host = "smtp.gmail.com";
    static String port = "465";
    static String to = "";
    static String subject = "Reset Password";
    static String text = "";

    public SysUser existingEmailAddress(String emailAddress) {

          Session session = NewHibernateUtil.getSessionFactory().openSession();
        

        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("FROM SysUser as s WHERE  s.emailAddress=:email");

                query.setParameter("email", emailAddress);

                SysUser su = (SysUser) query.uniqueResult();
                return su;
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

    private static class MailAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(sender_email, password);
        }
    }

    public static void sendTextMail(String email, String link) {
        to = email;
        text = link;
        Properties props = new Properties();
        props.put("mail.smtp.user", sender_email);
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", port);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        try {
            Authenticator auth = new MailAuthenticator();
            javax.mail.Session session = javax.mail.Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender_email));
            message.setSubject(subject);
            message.setText(text);

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            Transport.send(message);
        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

    public String updateUserPassword(SysUser user) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {

            try {
                String updatePWQuery = "UPDATE SysUser u set u.password=:password WHERE u.username=:emailAddress ";
                Query query = session.createQuery(updatePWQuery);
                query.setParameter("password", user.getPassword());
                query.setParameter("emailAddress", user.getUsername());
                query.executeUpdate();

                transaction.commit();
                return ImpressionConstants.SUCCESS;

            } catch (Exception e) {
                e.printStackTrace();
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();

                }
                return ImpressionConstants.ERROR_MESSAGE;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }

    public static List<SysUser> getList() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                String getUser = "From SysUser";
                Query query = session.createQuery(getUser);
                List<SysUser> list = query.list();

                return list;
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
