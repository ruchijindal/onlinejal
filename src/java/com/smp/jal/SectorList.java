/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.jal;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;

/**
 *
 * @author smp-06
 */
@WebServlet(name = "SectorList", urlPatterns = {"/blockList", "/showConsumerNo"})
public class SectorList extends HttpServlet {

    SelectSec_Div selectSec_Div = new SelectSec_Div();
    String division = "";
    String blocks = "";
    String sec = "";
    String blkNo = "";
    String flatNo = "";
    String xmlpath = "";
    DocumentBuilderFactory dbf = null;
    DocumentBuilder db = null;
    org.w3c.dom.Document docxml = null;
    int totalConsumerNo = 0;
    String consumserNoList = "N/A";
    ResultSet rs;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParserConfigurationException, SAXException {


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String path = request.getServletPath();
        System.out.println("path=============>" + path);
        if (path.equals("/blockList")) {
            try {
                division = "";
                blocks = "";
                sec = request.getParameter("sec");
                if (!sec.equals("select")) {
                    xmlpath = request.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                    dbf = DocumentBuilderFactory.newInstance();
                    db = dbf.newDocumentBuilder();
                    docxml = db.parse(xmlpath);
                    docxml.getDocumentElement().normalize();
                    division = selectSec_Div.getDevision(sec, docxml);
                    InitialContext initialContext = new InitialContext();
                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                    Connection connection = dataSource.getConnection();
                    Statement statement = connection.createStatement();
                    System.out.println("+++++++++++ master++++++++++");
                    ResultSet rs = statement.executeQuery("select distinct blk_no from master" + division.charAt((division.length() - 1)) + " where trim(sector)='" + sec + "' and blk_no is not null order by blk_no");
                    // System.out.println("division="+division+" sector="+sec);
                    while (rs.next()) {
                        if (!(rs.getString("blk_no").equals("null") || rs.getString("blk_no").equals(" "))) {
                            if (blocks.equals("")) {
                                blocks = rs.getString("blk_no");
                            } else {
                                blocks = blocks + ":" + rs.getString("blk_no");
                            }
                        }
                    }
                    connection.close();
                }
                // blocks=blocks+":"+"N/A";
                out.println(blocks);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
        } else if (path.equals("/showConsumerNo")) {
           // System.out.println("+++++++++++  showConsumerNo++++++++++");
if(request.getParameter("consno")==null ||request.getParameter("consno").equals("") )
{
   // System.out.println("in if of show consumerno");
            try {
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                Connection connection = dataSource.getConnection();
                Statement statement = connection.createStatement();

                blkNo = request.getParameter("blkNo");
                flatNo = request.getParameter("flatNo");
                int count = 0;
                count = flatNo.length();
                if (count == 2) {
                    flatNo = "0" + flatNo;
                } else if (count == 1) {
                    flatNo = "00" + flatNo;
                }
                //System.out.println("+++++++++++  sec++++++++++" + sec);
                //System.out.println("+++++++++++  blkNo++++++++++" + blkNo);
                //System.out.println("+++++++++++ flatNo+++++++++" + flatNo);
                if (blkNo.equals("N/A")) {
                    rs = statement.executeQuery("select count(cons_no) from master" + division.charAt((division.length() - 1)) + " where trim(sector)='" + sec.trim() + "' and flat_no =" + "'" + flatNo.trim() + "'");

                } else {
                    rs = statement.executeQuery("select count(cons_no) from master" + division.charAt((division.length() - 1)) + " where trim(sector)='" + sec.trim() + "' and blk_no='" + blkNo.trim() + "' and flat_no =" + "'" + flatNo.trim() + "'");
                }
                if (rs.next()) {
                    totalConsumerNo = rs.getInt(1);
                }
                //System.out.println("+++++++++++  totalConsumerNo++++++++++" + totalConsumerNo);
                int var = 65;
                if (totalConsumerNo > 1) {
                    consumserNoList = "select";
                   request.setAttribute("status", "true");
                } else {
//request.setAttribute("status", "false");
// System.out.println("flatNo-->"+flatNo+"division-->"+division+"blkNo-->"+blkNo);
//                    RequestDispatcher dispatcher=request.getRequestDispatcher("/cons_login.jsp?blkno="+blkNo+"&division="+division+"&flatno="+flatNo);
//
//                    dispatcher.forward(request, response);
                    request.setAttribute("status", "false");
                 //   System.out.println("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                    consumserNoList = "N/A";

                }
                for (int i = 0; i < totalConsumerNo - 1; i++) {

                    consumserNoList = consumserNoList + ":" + (char) (var + i);
                }
             //   System.out.println("Mohit    --------  consumserNoList++++++++++" + consumserNoList);


                out.println(consumserNoList);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
            }
 else
{
                 //System.out.println("in else of show consumerno");
 consumserNoList=request.getParameter("consno");
 // System.out.println("in else of show consumerno"+ consumserNoList);
 out.println(consumserNoList+":");
 }
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
            processRequest(request, response);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(SectorList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(SectorList.class.getName()).log(Level.SEVERE, null, ex);
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
            processRequest(request, response);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(SectorList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(SectorList.class.getName()).log(Level.SEVERE, null, ex);
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
