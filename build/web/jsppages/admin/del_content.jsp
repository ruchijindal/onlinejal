<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*,java.net.*"%>
<%!    String sql;
    Connection con;
    PreparedStatement pst;
    String con_id;
    int i = 0;
    int chktab=0;
%>

<%
            try {

                     if (request.getParameter("chktab") != null) {
                       chktab = Integer.parseInt(request.getParameter("chktab"));
                    } else {
                        chktab = 0;
                    }

                      if (request.getParameter("con_id") != null) {
                      con_id = request.getParameter("con_id");
                    } else {
                       con_id = " ";
                    }

             
            
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                String sql = "delete from jal_content where con_id='" + con_id + "'";
                pst = con.prepareStatement(sql);
                i = pst.executeUpdate();
                if (i > 0) {
                    response.sendRedirect("viewcontent.jsp?chktab="+chktab+"");
                      }
            } catch (Exception ex) {
                System.out.println(ex);
               response.sendRedirect("viewcontent.jsp?chktab="+chktab+"");
            } finally {
                con.close();
            }
%>