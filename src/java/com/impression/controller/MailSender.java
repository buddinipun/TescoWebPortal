/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impression.controller;

import com.impression.dao.PassResetDAO;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author Jefferson Hope
 */
public class MailSender {

    private static class MailAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(sender_email, password);
        }
    }

    private static final String sender_email = "eportal@impressionslabels.com";
    private static String password = "#123456789$";

    private String to = "";
    private String subject = "";
    private String text = "";

    public MailSender(String to, String subject, String text) {
        this.to = to;
        this.subject = subject;
        this.text = text;
    }

    public void sendAttachmentMail(String path) {
        Properties props = new Properties();

        props.put("mail.smtp.host", "mail.impressionslabels.com"); //SMTP Host
        props.put("mail.smtp.socketFactory.port", "25"); //SSL Port
//        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
        props.put("mail.smtp.auth", "true"); //Enabling SMTP Authentication
        props.put("mail.smtp.port", "25"); //SMTP Port
//
        try {
            Authenticator auth = new MailAuthenticator();
            Session session = Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender_email));
            message.setSubject(subject);

            Multipart multipart = new MimeMultipart("mixed");

            MimeBodyPart textBodyPart = new MimeBodyPart();
            textBodyPart.setText(text);
            multipart.addBodyPart(textBodyPart);

            MimeBodyPart attachBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(path);
            attachBodyPart.setDataHandler(new DataHandler(source));
            attachBodyPart.setFileName(source.getName());
            multipart.addBodyPart(attachBodyPart);

            message.setContent(multipart);

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            Transport.send(message);
        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

    public void sendAttachmentsMail(String[] paths) {
        Properties props = new Properties();

        props.put("mail.smtp.host", "mail.impressionslabels.com"); //SMTP Host
        props.put("mail.smtp.socketFactory.port", "25"); //SSL Port
//        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
        props.put("mail.smtp.auth", "true"); //Enabling SMTP Authentication
        props.put("mail.smtp.port", "25"); //SMTP Port
//
        try {
            Authenticator auth = new MailAuthenticator();
            Session session = Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender_email));
            message.setSubject(subject);

            Multipart multipart = new MimeMultipart("mixed");

            MimeBodyPart textBodyPart = new MimeBodyPart();
            textBodyPart.setText(text);
            multipart.addBodyPart(textBodyPart);

            for (String path : paths) {
                MimeBodyPart attachBodyPart = new MimeBodyPart();
                DataSource source = new FileDataSource(path);
                attachBodyPart.setDataHandler(new DataHandler(source));
                attachBodyPart.setFileName(source.getName());
                multipart.addBodyPart(attachBodyPart);
            }

            message.setContent(multipart);

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            Transport.send(message);

        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

    public void sendTextMail() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "mail.impressionslabels.com");
        props.put("mail.smtp.port", "25");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", "25");

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
            // System.out.println("ex >>>>>>>>>>>. " + mex);
            mex.printStackTrace();
        }
    }

}
