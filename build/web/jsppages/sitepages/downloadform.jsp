<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
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
        String filepath;
    FileInputStream fis = null;
    BufferedInputStream bis = null;
    ServletOutputStream sos = null;
    ByteArrayOutputStream baos = null;
    
    int ch;
    File file;
    int i = 0;
    int pt;
    int vpflag;
    String filename;
    String userrole;
    int t;
        String id;
       PreparedStatement pst;
    Connection con;
    ResultSet rs;
        String sql;
        String heading;
%>

<%
 id = request.getParameter("id");
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


               
              //  filename = request.getParameter("file");
              //  filename = "file.pdf";
                InitialContext initialContext = new InitialContext();
                                                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                    con = dataSource.getConnection();
                                                sql = "select id,path,description,heading from upload_file where id="+id;
                                                 pst = con.prepareStatement(sql);
                                                rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    id = rs.getString(1);
                                                    path = rs.getString(2);
                                                    heading=rs.getString(4);
                                                 //   System.out.println("path of the image is===="+path);
                filepath = this.getServletContext().getRealPath("") +"/"+ path;
               // System.out.println("path of file****"+filepath);

                file = new File(filepath);
                int size = (int) file.length();
                if (size > Integer.MAX_VALUE) {
                   // System.out.println("File is too large.");
                }
                fis = new FileInputStream(filepath);
               
                bis = new BufferedInputStream(fis);
                response.setContentLength(size);
                response.setHeader("Content-Disposition", "filename="+heading);
                response.setContentType("application/pdf");
                sos = response.getOutputStream();
                while ((ch = bis.read()) != -1) {
                  
                    sos.write((byte) ch);
                }

                sos.flush();
}
                                                con.close();
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("downloads.jsp");
               
            }

%>

