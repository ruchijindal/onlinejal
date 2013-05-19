/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.servlet.ServletOutputStream;


/**
 *
 * @author smp
 */
public class sendReplyMail extends HttpServlet {

    private Connection con;
    private PreparedStatement pst;
    private String sql;
    private ResultSet rs;

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, MessagingException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
     ServletOutputStream out = response.getOutputStream();
        try {       
            String to = request.getParameter("mailId").trim();
            String from = "noidajal@gmail.com";//request.getParameter("from").trim();
            //
            int port = 25;
            String user = "noidajal@gmail.com";
            String password = "smp@123";

            String host = "smtp.gmail.com";
//System.out.println("to  "+to+"\n from"+from);
            // Create properties, get Session
            Properties props = new Properties();

            // If using static Transport.send(),
            // need to specify which host to send it to
            props.put("mail.smtp.host", "smtp.gmail.com");
            // props.put("mail.pop3.host","pop3.gmail.com");

            // To see what is going on behind the scene
            props.put("mail.debug", "true");
            props.put("mail.smtp.auth", "true");
            // props.put("mail.smtp.ssl.enable","true");
            props.setProperty("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.host", host);
            Authenticator auth = new PasswordAuth();
            javax.mail.Session session1 = javax.mail.Session.getInstance(props, auth);
           

            // Instantiatee a message
            Message msg = new MimeMessage(session1);
            msg.setContent("Hello", "text/plain");

//System.out.println("to  "+to+"\n from"+from);
            //Set message attributes
            msg.setFrom(new InternetAddress(from, "Noida Jal"));

            Address address = new InternetAddress(to);

            msg.setRecipient(Message.RecipientType.TO, address);
            msg.setSubject(request.getParameter("subj"));

            msg.setSentDate(new Date());

            // Set message content
            String message=request.getParameter("content1");
            String rowId=request.getParameter("rowId");
            String status=request.getParameter("status");
          //   System.out.println("on servlet rowId-->"+request.getParameter("rowId"));
            //  System.out.println("on servlet rowId-->"+request.getParameter("status"));
            msg.setText(request.getParameter("content1") + "\n ____________________________\nWarm Regards \nNoida Jal\n");

            //Send the message
            // com.sun.mail.smtp.SMTPSSLTransport.send(msg);
            //SMTPSSLTransport transport=(SMTPSSLTransport)session1.getTransport("smtps");

            Transport transport = session1.getTransport("smtp");


            transport.connect(host, port, user, password);



            transport.send(msg);
            //transport.send(msg);
          
            transport.close();
             if(!(status==null))
             {
             status="r";
             }
 else
 {
 status="p";
 }


                InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
            con = dataSource.getConnection();
        sql="update CONTACT_TAB set REPLY='"+message+"',STATUS='"+status+ "'where rowid='"+rowId+"'";
            sql="select max(ID) as high from RESPONSE ";
                Statement st=con.createStatement();
                 ResultSet rs=st.executeQuery(sql);

                 Long id=new Long(0);

                 while(rs.next())
                     {
                     id=rs.getLong("high");
                     }
                 if(id!=null){
                 id=id+1;}
                 else{
                     id=new Long(1);
                     }
                 //String message1=request.getParameter("message") + "\n ____________________________\nWarm Regards \nNoida Jal\n";
           java.sql.Date date=new java.sql.Date(new Date().getTime());
                 sql="insert into RESPONSE(ID,MSGDATE,EMAIL,SUBJECT,MESSAGE,STATUS) values ( "+id+",to_date('" + date.toString() + "','yyyy-mm-dd'),'"+to+"','"+request.getParameter("subj").toString()+"','"+message+"','"+status+"')";
             //pst = con.prepareStatement(sql);
              int i=st.executeUpdate(sql);
       sql="update CONTACT_TAB set STATUS='"+status+ "'where rowid='"+rowId+"'";
       i=st.executeUpdate(sql);
            response.sendRedirect(request.getContextPath() + "/jsppages/admin/view_complains.jsp?b=inbox&sent=y");
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        finally {
            out.close();
            con.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            try {
                processRequest(request, response);
            } catch (NamingException ex) {
                Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (MessagingException ex) {
            Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            try {
                //System.out.println("hureyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
                processRequest(request, response);
            } catch (NamingException ex) {
                Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (MessagingException ex) {
            Logger.getLogger(sendReplyMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
