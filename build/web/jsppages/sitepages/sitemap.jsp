<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%!    int cp = 0;
    String userrole;
    int t;
    String sql;
    PreparedStatement pst;
    ResultSet rs;
    Connection con;
    String con_id;
    String con_title;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="../common/header.jsp"/>

        <title>Noida Jal Board : Sitemap</title>
        <meta http-equiv="content-type" content="text/html;charset=utf-8" />
        <meta http-equiv="Content-Style-Type" content="text/css" />

        <link rel="stylesheet" type="text/css" href="../../resources/Sitemap/quickTree.css" />


        <script src="../../resources/Sitemap/jquery.quickTree.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(function(){
                $('ul.quickTree').quickTree();
            });
        </script>

    </head>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    //System.out.println("UserRole = " + userrole);
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
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

                        <div class="active">
                            <a href="#" title="Services">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Sitemap
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->



        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail">

                        <div id="table-blk" class="full">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h2>Sitemap</h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">

                                    <ul class="quickTree">
                                        <li><a href="../../index.jsp" title="Go to Home">Home</a>

                                        </li>
                                        <li>News And Events
                                            <ul>
                                                <li><a href="../sitepages/news_list.jsp">News</a></li>
                                                <li><a href="../sitepages/events.jsp">Events</a></li>
                                                <li><a href="../sitepages/services.jsp">Services</a></li>
                                                <li><a href="../sitepages/scheme.jsp">Schemes</a></li>

                                            </ul>
                                        </li>
                                        <!--                                        <li><a href="../sitepages/rate.jsp">Consumer</a></li>-->



                                        <%
                                                    String userrole = (String) session.getAttribute("userrole");
                                                    if (userrole == null || userrole.equals("admin") || userrole.equals("manager") || userrole.equals("crm")) {%>
                                        <li><a href="#">Consumer</a>
                                            <ul>

                                                <li> <a href="<%=request.getContextPath()%>/cons_detailslogin.jsp">Consumer Details</a></li>
                                            </ul>
                                        </li>
                                        <%
                                                    }
                                                    if (userrole != null) {
                                                        if (userrole.equals("admin")) {
                                        %>
                                        <li>Admin Area
                                            <ul>
                                                <li><a href="../admin/admin.jsp">Dashboard</a></li>
                                                <li>Contents
                                                    <ul>
                                                        <li><a href="../admin/viewcontent.jsp">Manage Contents</a></li>
                                                        <li><a href="../admin/viewuploadfile.jsp">Uploaded Files</a></li>
                                                        <li><a href="../admin/view_complains.jsp?b=inbox">Suggetions/Complaints</a></li>
                                                    </ul>
                                                </li>
                                                <li>User Setting
                                                    <ul>
                                                        <li><a href="../admin/create_user.jsp">Create User</a></li>
                                                        <li><a href="../admin/view_user.jsp">View User</a></li>
                                                    </ul>
                                                </li>

                                            </ul>
                                        </li>
                                        <%                                         } else if (userrole.equals("crm")) {
                                        %>
                                        <li>CRM Dashboard
                                            <ul>
                                                <li><a href="../admin/view_complains.jsp?b=inbox"> Suggetions/Complaints</a></li>
                                            </ul>
                                        </li>

                                        <%                                                    } else if (userrole.equals("consumer")) {
                                        %>
                                        <li>Consumer
                                            <ul>

                                                <li> <a href="../consumer/cons_details.jsp">Consumer Details</a></li>
                                                <!--                                                <li> <a href="../consumer/chl_details.jsp">Payment Details</a></li>-->
                                            </ul>
                                        </li>
                                        <%                                                } else if (userrole.equals("manager")) {
                                        %>

                                        <li>Manager
                                            <ul>
                                                <li> <a href="../manager/mgr_dashboard.jsp">DashBoard</a></li>
                                                <li>Reports
                                                    <ul>
                                                        <li><a href="../manager/revenue_report.jsp">Revenue Report</a></li>
                                                        <li><a href="../manager/cons_report.jsp">Consumer Report</a></li>
                                                    </ul>
                                                </li>
                                                <li>Graphs
                                                    <ul>
                                                        <li><a href="../charts/Code/JSP/jal_chart.jsp">Revenue Graph</a></li>
                                                        <li><a href="../charts/Code/JSP/ConsumerChart.jsp">Consumer Graph</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>

                                        <%                }
                                                    }
                                                    sql = "select con_id,con_title from jal_content where content_type='page'and (display='default' or display='home') order by priority";
                                                    // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                    InitialContext initialContext = new InitialContext();
                                                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                    con = dataSource.getConnection();
                                                    pst = con.prepareStatement(sql);
                                                    rs = pst.executeQuery();
                                                    while (rs.next()) {
                                                        con_id = rs.getString(1);
                                                        con_title = rs.getString(2);
                                        %>
                                        <li>
                                             <a href="../sitepages/page.jsp?con_id=<%=con_id%>"><%=con_title%></a>
                                             
                                        </li>
                                        <%
                                                    }
                                                    con.close();

                                        %>
                                        <li><a href="../sitepages/downloads.jsp">Download</a></li>
                                        <li>Contact Us
                                            <ul>
                                                <li><a href="../sitepages/contact.jsp">Contact Details</a></li>
                                                <li><a href="../sitepages/complaintForm.jsp">Complaint Form</a></li>

                                            </ul>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->
    </body>
</html>