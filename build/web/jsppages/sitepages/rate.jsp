<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,bill.generator.ConsumerDetail;"%>

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
    String userid;
    String userrole;
    String sec;
    String xmlpath;
    String cons_nm1;
    String con_tp;
    String cons_ctg;
    int t;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>Noida Jal Board : Rates</title></head>
    <jsp:include page="../common/header.jsp"/>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid-->
    <link rel="stylesheet" href="../../resources/css/invalid.css" type="text/css" media="screen" />

    <!-- jQuery -->
    <script type="text/javascript" src="../../resources/jquery/jquery-1.3.2.min.js"></script>

    <!-- jQuery Configuration -->
    <script type="text/javascript" src="../../resources/jquery/simpla.jquery.configuration.js"></script>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
        <!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->

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
                            <a href="#" title="Rates">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Rates
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->


        <%
                    try {
                        userid = (String) session.getAttribute("userid");
                        userrole = (String) session.getAttribute("userrole");
                        if (userrole != null) {
                            if (userrole.equals("consumer")) {
                                ConsumerDetail cd = new ConsumerDetail();

                                xmlpath = pageContext.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
                                rs = cd.getConsumerDetails(userid, sec, xmlpath);

                                if (rs.next()) {
                                    //Consumer details
                                    cons_nm1 = (String) rs.getString(1).trim();
                                    con_tp = (String) rs.getString(2).trim();
                                    cons_ctg = (String) rs.getString(3).trim();

                                }
                            } else {
                                con_tp = null;
                            }
                        }
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }

        %>
        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">

                    <div id="contentrail">

                        <div id="news">
                            <div class="content">
                                <div class="leftcorners1">
                                    <div class="rightcorners1">
                                        <div class="bg1">
                                            <div class="insider">
                                                <div class="article">
                                                    <!--<div class="content-box-content">

					<<div class="tab-content default-tab" id="tab1">-->
                                                    <div id="table-blk" class="full">

                                                        <%
                                                                    try {
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("admin") || userrole.equals("manager") || (userrole.equals("consumer") && con_tp.equals("R"))) {
                                                                                con_id = request.getParameter("con_id");
                                                                                InitialContext initialContext = new InitialContext();
                                                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                                                con = dataSource.getConnection();
                                                                                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='ratelist' and con_title='Rates For Residential'";
                                                                                pst = con.prepareStatement(sql);
                                                                                rs = pst.executeQuery();

                                                                                if (rs.next()) {
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    content = rs.getString(3);
                                                                                    content_type = rs.getString(4);
                                                                                    con_date = rs.getString(5);

                                                        %>
                                                        <h2><%=con_title%></h2>

                                                        <%=content%>
                                                        <br/>
                                                        <%
                                                                                }
                                                                            }
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        System.out.println(ex);
                                                                    }
                                                        %>

                                                    </div>


                                                    <!--<div class="tab-content" id="tab2">-->
                                                    <div id="table-blk" class="full">

                                                        <%
                                                                    try {
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("admin") || userrole.equals("manager") || (userrole.equals("consumer") && con_tp.equals("I"))) {
                                                                                con_id = request.getParameter("con_id");
                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='ratelist'  and con_title='Rates For Industrial'";
                                                                                pst = con.prepareStatement(sql);
                                                                                rs = pst.executeQuery();

                                                                                if (rs.next()) {
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    content = rs.getString(3);
                                                                                    content_type = rs.getString(4);
                                                                                    con_date = rs.getString(5);
                                                        %>

                                                        <h2><%=con_title%></h2>
                                                        <%=content%>
                                                        <br/>
                                                        <%
                                                                                }
                                                                            }
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        System.out.println(ex);
                                                                    }
                                                        %>

                                                    </div>


                                                    <!--<div class="tab-content" id="tab3">-->
                                                    <div id="table-blk" class="full">

                                                        <%
                                                                    try {
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("admin") || userrole.equals("manager") || (userrole.equals("consumer") && con_tp.equals("T"))) {
                                                                                con_id = request.getParameter("con_id");
                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='ratelist'  and con_title='Rates For Institutional'";
                                                                                pst = con.prepareStatement(sql);
                                                                                rs = pst.executeQuery();

                                                                                if (rs.next()) {
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    content = rs.getString(3);
                                                                                    content_type = rs.getString(4);
                                                                                    con_date = rs.getString(5);
                                                        %>
                                                        <h2><%=con_title%></h2>

                                                        <%=content%>
                                                        <br/>
                                                        <%
                                                                                }
                                                                            }
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        System.out.println(ex);
                                                                    }
                                                        %>

                                                    </div>


                                                    <!--<div class="tab-content" id="tab4">-->
                                                    <div id="table-blk" class="full">

                                                        <%
                                                                    try {
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("admin") || userrole.equals("manager") || (userrole.equals("consumer") && con_tp.equals("C"))) {
                                                                                con_id = request.getParameter("con_id");
                                                                                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='ratelist'  and con_title='Rates For Commercial'";
                                                                                pst = con.prepareStatement(sql);
                                                                                rs = pst.executeQuery();

                                                                                if (rs.next()) {
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    content = rs.getString(3);
                                                                                    content_type = rs.getString(4);
                                                                                    con_date = rs.getString(5);
                                                        %>

                                                        <h2><%=con_title%></h2>
                                                        <%=content%>
                                                        <br/>
                                                        <%
                                                                                }
                                                                            }
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        System.out.println(ex);
                                                                    }
                                                        %>


                                                    </div>



                                                    <!--<div class="tab-content" id="tab5">-->
                                                    <div id="table-blk" class="full">

                                                        <%
                                                                    try {
                                                                        if (userrole != null) {
                                                                            if (userrole.equals("admin") || userrole.equals("manager") || (userrole.equals("consumer") && con_tp.equals("R"))) {
                                                                                con_id = request.getParameter("con_id");
                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='ratelist'  and con_title='Rates For Flats'";
                                                                                pst = con.prepareStatement(sql);
                                                                                rs = pst.executeQuery();

                                                                                if (rs.next()) {
                                                                                    con_id = rs.getString(1);
                                                                                    con_title = rs.getString(2);
                                                                                    content = rs.getString(3);
                                                                                    content_type = rs.getString(4);
                                                                                    con_date = rs.getString(5);
                                                        %>

                                                        <h2><%=con_title%></h2>
                                                        <%=content%>
                                                        <br/>
                                                        <%              }
                                                                            }
                                                                        }
                                                                    } catch (Exception ex) {
                                                                        System.out.println(ex);
                                                                    } finally {
                                                                        con.close();
                                                                    }
                                                        %>

                                                    </div>




                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>



        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>

















