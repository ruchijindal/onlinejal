<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@page import="javax.naming.InitialContext"%>
    <%@page import="javax.sql.DataSource"%>
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
        java.util.Date dt;
        String month;
        int x;
        String sql3;
        String sql1;
        int numRows;
        int startIndex = 1;
        int numRecordsPerPage = 8;
        int numPages;
        int remain;
        int i, j, k;
        String mon;
        String year;
        String a;
        String userrole;
        int t;

    %>


    <head>
        <title>Noida Jal Board : Events</title>
        <jsp:include page="../common/header.jsp"/>
    </head>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    

        %><!-- Menu Starts -->
        <jsp:include page="../common/navigation.jsp"/>
        <!-- Menu Ends -->

        <%
                    try {
                        mon = "";
                        InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con = dataSource.getConnection();
                        // con = (Connection) pageContext.getServletContext().getAttribute("con");
                        month = request.getParameter("month");
                        year = request.getParameter("year");
                        sql = "select to_char(con_date,'Month yyyy') from jal_content  where content_type='notice' and to_char(con_date,'dd-mm-yyyy') like '__-" + month + "-" + year + "'";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                            mon = rs.getString(1);
                            System.out.println("Month is ="+mon);
                            } else {
                            mon = "";
                        }
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }

        %>
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
                        <div class="inactive">
                            <a href="events.jsp" title="Events">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Events
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Events">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Events - <%= mon%>

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

                        <div class="news">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">

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
                                                    <br class="clear" />



                                                    <div class="inside">
                                                        <div class="container">
                                                            <div id="contentrail">
                                                                <h2>Events</h2> <div class="dt right"><%=mon%></div>
                                                                <div class="article">



                                                                    <%
                                                                                int count = 0;
                                                                                int increment = 1;
                                                                                int numRows = 0;
                                                                                sql = null;
                                                                                sql1 = null;
                                                                                int numPages = 0;



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




                                                                                    //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                    //month=request.getParameter("month");

                                                                                    sql = "select con_id,con_title,content_type, to_char(con_date,'dd Mon,yy') from jal_content where content_type='notice' and to_char(con_date,'dd-mm-yyyy') like '__-" + month + "-" + year + "' order by con_date desc";
                                                                                    sql1 = "select count(*) from jal_content  where content_type='notice' and to_char(con_date,'dd-mm-yyyy') like '__-" + month + "-" + year + "'";
                                                                                    pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                    rs = pst.executeQuery();
                                                                                    ps1 = con.prepareStatement(sql1);
                                                                                    rs1 = ps1.executeQuery();
                                                                                    if (rs1.next()) {
                                                                                        numRows = rs1.getInt(1);
                                                                                    }





                                                                                    int numRecordsPerPage = 8;


                                                                                    numPages = numRows / numRecordsPerPage;

                                                                                    remain = numRows % numRecordsPerPage;

                                                                                    if (remain != 0) {

                                                                                        numPages = numPages + 1;

                                                                                    }

                                                                                    //out.println(" \n no. of pages : " + numPages );

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


                                                                                    //while(rs.next())
                                                                                    for (count = startIndex; count < increment; count++) {
                                                                                        if (rs.absolute(count)) {
                                                                                            con_id = rs.getString(1);
                                                                                            con_title = rs.getString(2);
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
                                                                                            if (content != null) {
                                                                                                for (int j = 0; j < 40; j++) {
                                                                                                    x = str.indexOf(" ") + 1;
                                                                                                    str = str.substring(str.indexOf(" ") + 1);
                                                                                                    index = index + x;
                                                                                                }


                                                                                                String noticelink = content.substring(0, index);
                                                                    %>

                                                                    <h4> <%=con_title%></h4>
                                                                    <%=noticelink%>

                                                                    <div class="infobar no">
                                                                        <div class="info">
                                                                            <%=con_date%> &nbsp;&nbsp;
                                                                        </div> <!-- #news .info -->
                                                                        <div class="button ">
                                                                            <a href="event.jsp?con_id=<%=con_id%>" title="Read more">
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
                                                                                    }

                                                                                } catch (Exception ex) {
                                                                                    System.out.println(ex);
                                                                                } finally {
                                                                                    con.close();
                                                                                }
                                                                    %>

                                                                </div>  <!-- #news .insider -->



                                                                <% if (numPages > 1) {%>
                                                                <div class="paging p1">
                                                                    <ul>
                                                                        <%
                                                                             if (startIndex != 1) {
                                                                        %>
                                                                        <li class="first">
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=1&pflag=1&numRows=<%=numRows%>" title="First Page">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <img src="../../resources/images/icons/First3.png"  class="im" alt="first" title="First"></img>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span> </a>
                                                                        </li>
                                                                        <li class="previous">
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=<%=startIndex - numRecordsPerPage%>&pflag=1&numRows=<%=numRows%>" title="Previous Page">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <img src="../../resources/images/icons/Prev3.png"  class="im" alt="first" title="Previous"></img>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span> </a>
                                                                        </li>
                                                                        <%
                                                                             }
                                                                        %>


                                                                        <%
                                                                             if (numPages <= 5) {
                                                                                 i = 1;
                                                                                 k = numPages;
                                                                             } else {
                                                                                 i = (startIndex / numRecordsPerPage) + 1;
                                                                                 if (i + 4 <= numPages) {
                                                                                     k = i + 4;
                                                                                 } else {
                                                                                     i = numPages - 4;
                                                                                     k = numPages;
                                                                                 }
                                                                             }
                                                                             for (j = i; j <= k; j++) {
                                                                                 if (j == (startIndex / numRecordsPerPage) + 1) {
                                                                                     a = "active";
                                                                                 } else {
                                                                                     a = "";
                                                                                 }
                                                                                 // System.out.println((j - 1) * numRecordsPerPage + 1);
                                                                        %>
                                                                        <li class=<%=a%>>
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=<%=(j - 1) * numRecordsPerPage + 1%>&pflag=1&numRows=<%=numRows%>" title="1">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <%=j%>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span> <!-- .paging .leftcorners -->
                                                                            </a>
                                                                        </li>
                                                                        <%}

                                                                        %>





                                                                        <%/*increment += numRecordsPerPage ;*/%>
                                                                        <%if (startIndex + numRecordsPerPage < numRows) {%>
                                                                        <li class="next">
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=<%=startIndex + numRecordsPerPage%>&pflag=1&numRows=<%=numRows%>" title="Next Page">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <img src="../../resources/images/icons/Next3.png" class="im" alt="first" title="Next"></img>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span> </a>
                                                                        </li>
                                                                        <%}
                                                                        %>

                                                                        <%if (startIndex + numRecordsPerPage < numRows) {
                                                                                 if (remain != 0) {%>

                                                                        <li class="last">
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=<%=numRows - remain + 1%>&pflag=1&numRows=<%=numRows%>" title="Last Page">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span>
                                                                            </a>
                                                                        </li>
                                                                        <%
                                                                                                                                                             } else {
                                                                        %>
                                                                        <li class="last">
                                                                            <a href="monthevents.jsp?month=<%=month%>&year=<%=year%>&startIndex=<%=numRows - numRecordsPerPage + 1%>&pflag=1&numRows=<%=numRows%>" title="Last Page">
                                                                                <span class="leftcornerss">
                                                                                    <span class="rightcornerss">
                                                                                        <span class="bgs">
                                                                                            <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                        </span> <!-- .paging .bg -->
                                                                                    </span> <!-- .paging .rightcorners -->
                                                                                </span>
                                                                            </a>
                                                                        </li>
                                                                        <%
                                                                                 }
                                                                             }
                                                                        %>
                                                                    </ul>
                                                                </div> <!-- End .pagination -->
                                                                <%}%>
                                                            </div>


                                                            <div id="rightrail">
                                                                <div id="twitter" class="box box300">
                                                                    <div class="heading heading35">
                                                                        <div class="leftcorners">
                                                                            <div class="rightcorners">
                                                                                <div class="bg">
                                                                                    <h3>Events Archive</h3>
                                                                                </div> <!-- #twitter .bg -->
                                                                            </div> <!-- #twitter .rightcorners -->
                                                                        </div> <!-- #twitter .leftcorners -->
                                                                    </div> <!-- #twitter .heading -->
                                                                    <div class="content">
                                                                        <div class="leftcorners">
                                                                            <div class="rightcorners">
                                                                                <div class="bg">
                                                                                    <div class="insider">
                                                                                        <div id="tweet1">

                                                                                            <jsp:include page="eventsidebar.jsp"/>

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
