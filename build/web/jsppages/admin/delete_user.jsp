<%--
    Document   : index
    Created on : Nov 12, 2009, 1:45:33 PM
    Author     : Admin
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" import="java.util.*,java.sql.*,javax.servlet.*" pageEncoding="ISO-8859-1"%>
<%!    String sql;
    Connection con;
    String userid;
    String sess;
    boolean flag;
    int t = 0;
%>


<%

            sess = (String) session.getAttribute("userrole");

            request.getSession(false);
            try {
                userid = request.getParameter("userid");
                InitialContext initialContext = new InitialContext();
                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                con = dataSource.getConnection();
                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                sql = "delete from  userlogin where userid=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, userid);
                flag = pst.execute();

                if (!flag) {
                    t = 3;
                    request.setAttribute("t", t);
%>

<jsp:forward page="view_user.jsp"/>

<%
                } else {
                    t = 1;
                    request.setAttribute("t", t);
%>

<jsp:forward page="view_user.jsp"/>

<%

                }
            } catch (Exception ex) {
                System.out.println("Exception:" + ex);
                t = 1;
                request.setAttribute("t", t);
%>
<jsp:forward page="view_user.jsp"/>

<%
            } finally {
                con.close();
            }
%>















































