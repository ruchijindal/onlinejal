<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%@page language="java" import="java.io.*,javax.servlet.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>

<%!    String sec;
    String sector;
    String division;
    String cons_no;
    String path;
    FileInputStream fis = null;
    BufferedInputStream bis = null;
    ServletOutputStream sos = null;
    ByteArrayOutputStream baos = null;
    int ch;
    File file;
    int i = 0;
    int pt;
    int vpflag;
    String userrole;
    int t;
%>

<%
            request.getSession(false);
            request.setAttribute("t", t);
            userrole = (String) session.getAttribute("userrole");

%>

<%

            try {

                fis = null;
                bis = null;
                baos = null;
                sos = null;
                i = 0;
                sec = request.getParameter("sec");
                cons_no = request.getParameter("cons_no");
                division = request.getParameter("division");
//System.out.println("path+++++++++++=" +sec+":"+cons_no+";"+division);
                path = "/home/administrator/Data/JAL/" + division + "/SECTOR_0" + sec.trim() + "/" + cons_no + ".pdf";
                System.out.println("path=" + path);
                file = new File(path);
                if (file.exists()) {
                    int size = (int) file.length();
                    if (size > Integer.MAX_VALUE) {
                        //  System.out.println("File is too large.");
                    }
                    fis = new FileInputStream(path);
                    bis = new BufferedInputStream(fis);
                    response.setContentLength(size);
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "attachment;filename=" + cons_no + ".pdf");
                    sos = response.getOutputStream();
                    while ((ch = bis.read()) != -1) {
                        sos.write((byte) ch);
                    }

                    sos.flush();
                } else {
                    response.sendRedirect("cons_details.jsp?t=2&t8=1");
                }

            } catch (Exception ex) {
                System.out.println(ex);


            }

%>

