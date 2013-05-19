<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*,java.net.*"%>
<%!    String sql;
    Connection con;
    PreparedStatement pst;
    String id;
    int i = 0;
%>

<%
            try {
                id = request.getParameter("imageid");
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                String sql = "delete from slider_image where id='" + id + "'";
                pst = con.prepareStatement(sql);
                i = pst.executeUpdate();
                if (i > 0) {
                    response.sendRedirect("viewuploadfile.jsp");
                }
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("viewuploadfile.jsp");
            } finally {
                con.close();
            }
%>