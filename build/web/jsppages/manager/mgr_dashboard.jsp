<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>


<%!    String userrole;
    int t;
%>
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board : Manager DashBoard</title>
        <jsp:include page="../common/header.jsp"/>
    </head>

    <%
                request.getSession(false);
                request.setAttribute("t", t);

                userrole = (String) session.getAttribute("userrole");
                String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");
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
                        <div class="active">
                            <a href="../../index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Manager
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
                    <div class="left" >

                        <div  class="box box620 m news ">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>View Reports </h3>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">

                                                <div class="article">
                                                    <h4><a href="revenue_report.jsp">Revenue Reports </a>  </h4>
                                                    <p>Click here to view Revenue report</p>
                                                   
                                                        <div class="button right">
                                                            <a href="revenue_report.jsp" title="Read more">
                                                                <span class="btleftcorners1">
                                                                    <span class="btrightcorners1">
                                                                        <span class="btbg1">
                                                                            &nbsp;View &nbsp;
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </a>
                                                        </div> <!-- #news .button -->
                                              
                                                </div> <!-- #news .article -->
                                                <br class="clear" />
                                                <div class="article">
                                                    <h4><a href="cons_report.jsp">Consumer  Reports </a></h4>
                                                    <p>Click here to view Consumer report</p>
                                                   
                                                        <div class="button right">
                                                            <a href="cons_report.jsp" title="Read more">
                                                                <span class="btleftcorners1">
                                                                    <span class="btrightcorners1">
                                                                        <span class="btbg1">
                                                                             &nbsp;View &nbsp;
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </a>
                                                        </div> <!-- #news .button -->
                                             

                                                </div> <!-- #news .article -->
                                                  <br class="clear" />
                                            </div> <!-- #news .article -->
                                        </div>  <!-- #news .insider -->
                                    </div> <!-- #news .bg -->
                                </div> <!-- #news .rightcorners -->
                            </div> <!-- #news .leftcorners -->
                        </div> <!-- #news .content -->
                    </div> <!-- #news -->


                <div id="right">
                    <div class="box box620 m twitter">
                        <div class="heading heading35">
                            <div class="leftcorners">
                                <div class="rightcorners">
                                    <div class="bg">
                                        <h3>Graph Analysis</h3>
                                    </div> <!-- #twitter .bg -->
                                </div> <!-- #twitter .rightcorners -->
                            </div> <!-- #twitter .leftcorners -->
                        </div> <!-- #twitter .heading -->
                        <div class="content">
                            <div class="leftcorners">
                                <div class="rightcorners">
                                    <div class="bg">
                                        <div class="insider">
                                            <div class="tweet1"><h4>Revenue Graph</h4>Click here to view Revenue Graph </div>
                                            <div class="button right">
                                                <a href="../charts/Code/JSP/jal_chart.jsp" title="Create">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1"> &nbsp;View &nbsp;</span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #twitter .button -->
                                            <br/>
                                            <div class="tweet1"><h4>Consumer Graph</h4>Click here to view Consumer Graph</div>

                                            <div class="button right">
                                                <a href="../charts/Code/JSP/ConsumerChart.jsp" title="view">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1"> &nbsp;View&nbsp;</span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #twitter .button -->
                                            <br class="clear" />
                                        </div> <!-- #twitter .insider -->
                                    </div> <!-- #twitter .bg -->
                                </div> <!-- #twitter .rightcorners -->
                            </div> <!-- #twitter .leftcorners -->
                        </div> <!-- #twitter .content -->
                    </div> <!-- #twitter -->
                      </div> <!-- #rightrail --></div>
            </div>
        </div>


        <jsp:include page="../common/footer.jsp"/>

    </body>
</html>
