<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    String sql;
    String id;
    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    InputStream image;
    BufferedInputStream bis = null;
    ServletOutputStream sos = null;
    ByteArrayOutputStream baos = null;
    Blob image1;
    int ch;
    int size;
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
                id = request.getParameter("imageid");
                sql = "select image from slider_image where id=" + id;
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();
                if (rs.next()) {
                    image1 = rs.getBlob(1);
                }
               

                image = image1.getBinaryStream();
                size = (int) image1.length();
                bis = new BufferedInputStream(image);
                response.setContentLength(size);
                response.setContentType("image/jpg");
                sos = response.getOutputStream();

                while ((ch = bis.read()) != -1) {
                   
                    sos.write((byte) ch);
                }

                sos.flush();

            } catch (Exception ex) {
                System.out.print(ex);
            } finally {
                con.close();
            }
%>