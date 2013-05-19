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
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int rownum;
    String con_id;
    String content;
    String content_type;
    String con_title;
    String con_date;
    String userrole;
    int t;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Services</title>
        <jsp:include page="../common/header.jsp"/>

        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
    </head>
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
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            New & Events
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="Services">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Services
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
                        <div class="news">

                            <%
                                        try {
                                            InitialContext initialContext = new InitialContext();
                                            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                            con = dataSource.getConnection();
                                            //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                            sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='service'";
                                            pst = con.prepareStatement(sql);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {
                                                con_id = rs.getString(1);
                                                con_title = rs.getString(2);
                                                content = rs.getString(3);
                                                content_type = rs.getString(4);
                                                con_date = rs.getString(5);
                            %>

                            <h2><%=con_title%>  </h2>
                            <%=content%>



                            <br class="clear"/>
                            <%
                                            }
                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        } finally {
                                            con.close();
                                        }
                            %>

                            <br class="clear" />
                        </div>
                    </div>
                </div>
            </div>

        </div>  <!-- #news .insider -->

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>

