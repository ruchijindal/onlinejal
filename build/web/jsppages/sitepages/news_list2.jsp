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
    PreparedStatement pst, ps1;
    Connection con;
    ResultSet rs, rs1;
    int rownum;
    String con_id;
    String content;
    String content_type;
    String con_title;
    String con_date;
    String str;
    int index = 0;
    int newsflag = 0;
    String flag;
    String news_heading;
    int x;
    String sql3;
    String sql1;
    int numRows;
    int startIndex = 1;
    int numRecordsPerPage = 5;
    int numPages;
    int remain;
    String userrole;
    int t;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../common/header.jsp"/>
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
                            <a href="#" title="News">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            News
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
                    <div id="centerrail">

                        <div id="news">

                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">
                                                <div class="article">
                                                    <br class="clear" />


                                                    
                                                        <div class="inside">
                                                            <div class="container">
                                                                <div id="contentrail">
                                                                    <h2>News</h2>

                                                                    <div class="article">


                                                                        <%
                                                                                    int count = 0;
                                                                                    int increment = 1;
                                                                                    int numRows = 0;
                                                                                    sql = null;
                                                                                    sql1 = null;
                                                                                    int numPages;



                                                                                    try {
                                                                                        String startIndexString = request.getParameter("startIndex");



                                                                                        if (request.getParameter("numRows") != null) {
                                                                                            numRows = Integer.parseInt(request.getParameter("numRows"));
                                                                                        } else {
                                                                                            numRows = 0;
                                                                                        }

                                                                                        if (startIndexString == null) {
                                                                                            startIndexString = "1";
                                                                                        }



                                                                                        startIndex = Integer.parseInt(startIndexString);


                                                                                        InitialContext initialContext = new InitialContext();
                                                                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                                                        con = dataSource.getConnection();
                                                                                        
                                                                                        sql = "select con_id,con_title,content_type,to_char(con_date,'dd Mon,yy'),display,rowid from jal_content where content_type='news' order by con_date desc";
                                                                                        sql1 = "select count(*) from jal_content where content_type='news'";
                                                                                        pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                        rs = pst.executeQuery();
                                                                                        ps1 = con.prepareStatement(sql1);
                                                                                        rs1 = ps1.executeQuery();
                                                                                        if (rs1.next()) {
                                                                                            numRows = rs1.getInt(1);
                                                                                        }





                                                                                        int numRecordsPerPage = 5;


                                                                                        numPages = numRows / numRecordsPerPage;

                                                                                        remain = numRows % numRecordsPerPage;

                                                                                        if (remain != 0) {

                                                                                            numPages = numPages + 1;

                                                                                        }

                                                                                      

                                                                                        if ((startIndex + numRecordsPerPage) <= numRows) {

                                                                                            increment = startIndex + numRecordsPerPage;
                                                                                        } else {

                                                                                            if (remain == 0) {

                                                                                                increment = startIndex + numRecordsPerPage;

                                                                                            } else {

                                                                                                increment = startIndex + remain;
                                                                                            }
                                                                                        }

                                                                                        int l = 0;
                                                                                        char a[];


                                                                                       
                                                                                        for (count = startIndex; count < increment; count++) {
                                                                                            if (rs.absolute(count)) {
                                                                                                con_id = rs.getString(1);
                                                                                                con_title = rs.getString(2);
                                                                                                //content=rs.getString(3);

                                                                                                content_type = rs.getString(3);
                                                                                                con_date = rs.getString(4);
                                                                                                sql3 = "select content from jal_content where con_id='" + con_id + "'";
                                                                                                ps1 = con.prepareStatement(sql3);
                                                                                                rs1 = ps1.executeQuery();
                                                                                                if (rs1.next()) {
                                                                                                    content = rs1.getString(1);
                                                                                                }
                                                                                                str = content;
                                                                                                index = 0;
                                                                                                for (int j = 0; j < 30; j++) {
                                                                                                    x = str.indexOf(" ") + 1;
                                                                                                    str = str.substring(str.indexOf(" ") + 1);
                                                                                                    index = index + x;
                                                                                                }


                                                                                                String newslink = content.substring(0, index);
                                                                        %>

                                                                        <div class="data">  <%=newslink%></div>


                                                                        <div class="infobar no">
                                                                            <div class="info">
                                                                                <%=con_date%>
                                                                            </div> <!-- #news .info -->
                                                                            <div class="button ">
                                                                                <a href="news.jsp?con_id=<%=con_id%>&newsflag=1" title="Read more">
                                                                                    <span class="btleftcorners1">
                                                                                        <span class="btrightcorners1">
                                                                                            <span class="btbg1">
                                                                                                Read more
                                                                                            </span>
                                                                                        </span>
                                                                                    </span>
                                                                                </a>
                                                                            </div> <!-- #news .button -->
                                                                            <br class="clear" />
                                                                        </div> <!-- #news .infobar -->
                                                                        <br class="clear" />
                                                                        <%
                                                                                            }
                                                                                        }

                                                                                    } catch (Exception ex) {
                                                                                        System.out.println(ex);
                                                                                    } finally {
                                                                                        con.close();
                                                                                    }
                                                                        %>
                                                                    </div>  <!-- #news .insider -->


                                                                    <div class="pagination">
                                                                        &nbsp;&nbsp; Displaying Records:
                                                                        <% if (startIndex + numRecordsPerPage <= numRows) {%>
                                                                        <%= " " + startIndex%> - <%= increment - 1%>
                                                                        <%} else {%>
                                                                        <%= " " + startIndex%> - <%= numRows%>
                                                                        <%}%>

                                                                        <a href="news_list.jsp?startIndex=1&pflag=1&numRows=<%=numRows%>" title="First Page">&laquo; First</a>


                                                                        <%
                                                                                    if (startIndex != 1) {
                                                                        %>
                                                                        <a href="news_list.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&pflag=1&numRows=<%=numRows%>" title="Previous Page">&laquo; Previous</a>
                                                                        <%
                                                                                    }
                                                                        %>


                                                                     
                                                                        <%if (startIndex + numRecordsPerPage < numRows) {%>
                                                                        <a href="news_list.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&pflag=1&numRows=<%=numRows%>" title="Next Page">Next &raquo;</a>
                                                                        <%}
                                                                        %>

                                                                        <%if (remain != 0) {%>
                                                                        <a href="news_list.jsp?startIndex=<%=numRows - remain + 1%>&pflag=1&numRows=<%=numRows%>" title="Last Page">Last &raquo;</a>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <a href="news_list.jsp?startIndex=<%=numRows - numRecordsPerPage + 1%>&pflag=1&numRows=<%=numRows%>" title="Last Page">Last &raquo;</a>
                                                                        <%
                                                                                    }
                                                                        %>
                                                                    </div> <!-- End .pagination -->

                                                                </div>

                                                                <div id="rightrail">
                                                                    <div id="twitter" class="box box300">
                                                                        <div class="heading heading35">
                                                                            <div class="leftcorners">
                                                                                <div class="rightcorners">
                                                                                    <div class="bg">
                                                                                        <h3>News / Month</h3>
                                                                                    </div> <!-- #twitter .bg -->
                                                                                </div> <!-- #twitter .rightcorners -->
                                                                            </div> <!-- #twitter .leftcorners -->
                                                                        </div> <!-- #twitter .heading -->
                                                                        <div class="content">
                                                                            <div class="leftcorners">
                                                                                <div class="rightcorners">
                                                                                    <div class="bg">
                                                                                        <div class="insider">
                                                                                            <div id="tweet">

                                                                                                <jsp:include page="newsidebar.jsp"/>

                                                                                            </div>

                                                                                        </div> <!-- #twitter .insider -->
                                                                                    </div> <!-- #twitter .bg -->
                                                                                </div> <!-- #twitter .rightcorners -->
                                                                            </div> <!-- #twitter .leftcorners -->
                                                                        </div> <!-- #twitter .content -->
                                                                    </div> <!-- #twitter -->


                                                                </div> <!-- #rightrail -->

                                                            </div>
                                                        </div>
                                                 
                                                </div>  <!-- #news .insider -->
                                            </div> <!-- #news .bg -->
                                        </div> <!-- #news .rightcorners -->
                                    </div> <!-- #news .leftcorners -->
                                </div> <!-- #news .content -->
                            </div> <!-- #news -->

                        </div> <!-- #centerrail -->

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
