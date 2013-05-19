<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.*,java.net.*"%>
<%!    String sql;
    Connection con;
    PreparedStatement pst;
    String rowid;
    int comp;

%>


<%

            try {

                rowid = request.getParameter("rowid");
                rowid = URLDecoder.decode(rowid, "UTF-8");
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                String sql = "delete from response where id='" + rowid + "'";
                System.out.println("row id in deleteeeeeeeeeeeeeeeeeeeeee "+rowid);
                pst = con.prepareStatement(sql);
                int i = pst.executeUpdate();
                if (i > 0) {
                    response.sendRedirect("view_complains.jsp?b=outbox");
                }
            } catch (Exception ex) {
                System.out.println(ex);
                response.sendRedirect("view_complains.jsp?b=outbox");
            } finally {
                con.close();
            }

%>