<%-- 
    Document   : comp_sugg_reply
    Created on : 2 Aug, 2011, 2:55:22 PM
    Author     : smp
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page import="java.net.URLEncoder"%>
<%!
  String email;
  String subject;
  String message;
  String status;
  String date;
  String userrole;
  String rowid;
  Connection con;
  ResultSet rs;
  String sql;
  PreparedStatement pst;
%>

<html>
    <head><title>Noida Jal Board : Complaints</title>
        <jsp:include page="../common/header.jsp"/>

       <script   type="text/javascript">

            function confirmDel()
            {
                var msg;
                msg="Do you want to delete this record permanently?"
                var agree=confirm(msg);
                if(agree)
                    return true;
                else
                    return false;
            }

        </script>
    </head>
      <%
                request.getSession(false);               
                rowid = request.getParameter("rowid");
                userrole = (String) session.getAttribute("userrole");
    %>
    <body>
        <jsp:include page="../common/navigation.jsp"/>
 <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="bgr">
                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->

        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here:
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="inactive">
                            <a href="../../index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="inactive">
                            <a href="view_complains.jsp?b=inbox" title="view complaints">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            View Complaints
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="Complaints">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Complaint/Suggestion
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->

         <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="full">
                        <h2>Suggestions / Complaints</h2>
                        <form id="rep" action="del_reply.jsp?rowid=<%=rowid%>" method="post" >

                            <table >


                                <%
                                            try {

                                                InitialContext initialContext = new InitialContext();
                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                con = dataSource.getConnection();
                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                sql = "select email,subject,message,status,to_char(msgdate,'dd-mm-yy'),id from response where id='" + rowid + "'";
                                                pst = con.prepareStatement(sql);
                                                rs = pst.executeQuery();
                                                if (rs.next()) {
                                                    email = rs.getString(1);
                                                    subject = rs.getString(2);
                                                    message = rs.getString(3);
                                                    status = rs.getString(4);
                                                    date = rs.getString(5);
                                                   
                                                    rowid = URLEncoder.encode(rs.getString(6), "UTF-8");
                                                   
                                                    if (email == null) {
                                                        email = "-";
                                                    }
                                                    if (subject == null) {
                                                        subject = "-";
                                                    }
                                                    if (message == null) {
                                                        message = "-";
                                                    }
                                                    if (status == null) {
                                                        status = "-";
                                                    }
                                                    if (date == null) {
                                                        date = "-";
                                                    }
                                                    
                                %>

                                <tbody>

                                    <tr><td class="bold">Email: </td><td class="n"><%=email %></td></tr>
                                    <tr><td class="bold">Subject: </td><td class="n"><%=subject %></td></tr>
                                    <tr><td class="bold">Date: </td><td class="n"><%=date %></td></tr>
                                    <tr><td class="bold">Status: </td><td class="n"><%=status %></td></tr>
                                    
                                    <tr><td class="bold" align="justify" >Complaint: </td><td class="n" ><%=message %><br/><br/></td>
                                    </tr>

                                    <tr> <td>

                                             

                                                <button class="submit" type="submit" value="Submit" onclick="return confirmDel();">
                                                    <span class="leftcorners">
                                                        <span class="rightcorners">
                                                            <span class="bg">
                                    			Delete
                                                            </span>
                                                        </span>
                                                    </span>
                                                </button></td></tr>
                                </tbody>
                            </table>
                        </form>

                        <%
                                        }
                                    } catch (Exception ex) {
                                       ex.printStackTrace();

                                    } finally {
                                        con.close();
                                    }
                        %>

                    </div>
                </div>
            </div>
        </div>
 <div id="overlay">

</div>
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->
    </body>
</html>
