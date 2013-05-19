<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%@page import="java.sql.*,java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%!    String name;
    String address;
    String emailid;
    String subject;
    String complain;
    Connection con;
    PreparedStatement pst, ps1;
    String sql, sql1;
    ResultSet rs, rs1;
    String userrole;
    String rowid;
    String sugg_date;
    String status;
    int t;
    int count;
    int numRows;
    int startIndex = 1;
    int numRecordsPerPage = 8;
    int numPages;
    int remain;
    int i, j, k;
    String flag;
    String a;
    int new_complaints;
    String box = "inbox";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Complaints</title>
        <jsp:include page="../common/header.jsp"/>
        <script type="text/javascript">

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
            function nav()
            {
                var w = document.getElementById("mylist").selectedIndex;
                var url_add = document.getElementById("mylist").options[w].value;
                window.location.href = url_add;
            }
        </script>

    </head>




    <body>

        <%

                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
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
                            <a href="admin.jsp" title="Admin">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="inactive">
                            <a   title="Complaints">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Complaints
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a   title="Complaints">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            <%
                                                        String bcrumb = request.getParameter("b");

                                                        if (bcrumb != null && bcrumb.equals("outbox")) {%>
                                            Outbox<%} else {%>
                                            Inbox
                                            <%}%>
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
                    <div id="contentrail" class="full">

                        <h2>Suggestions/Complaints</h2>
                        <div class="buttons" style="margin-left: 25px;">
                            <a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=inbox" title="INBOX" >
                                <button class="submit upr" type="submit" value="Submit" title="Get Records as PDF file.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			INBOX
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </a>
                        </div>

                        <div class="buttons" style="margin-left: 25px;">
                            <a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=outbox" title="SENT" >
                                <button class="submit up" type="submit" value="Submit" title="Get Records as Excel Sheet.">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			OUTBOX
                                            </span>
                                        </span>
                                    </span>
                                </button>
                            </a>
                        </div>
                        <%--
                         <a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=inbox" title="INBOX" >[INBOX]</a>
                                                <a href="<%=request.getContextPath()%>/jsppages/admin/view_complains.jsp?b=outbox" title="SENT" >[OUTBOX]</a>
                        --%>                        <%
                                    String b = request.getParameter("b");
                                    if (b.equals("outbox")) {
                                        // System.out.println("yahoooooooooooooooooooooooooooooo");
%>

                        <div id="table-blk" class="full">
                            <form  id="myform" >

                                Filter Complaints:    <select name="mylist" id="mylist" onchange="nav()"  >
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=outbox&r=a"  >Select</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=outbox&r=a" >All</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=outbox&r=r" >Resolve</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=outbox&r=p" >Pending</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=outbox&r=ur" >Unresolve</option>


                                </select>
                                
                            </form><br/>
                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even"/>
                                    <col class="vzebra-odd" />
                                </colgroup>

                                <thead>

                                    <tr   >

                                        <th scope="col"   >E-mail</th>
                                        <th scope="col"   >Subject</th>
                                        <th scope="col"   >Date</th>
                                        <th scope="col"   >Status</th>
                                        <th scope="col"   >Actions</th>
                                    </tr>
                                </thead>
                                <%
                                                                        int count = 0;
                                                                        int increment = 1;
                                                                        int numRows = 0;
                                                                        sql = null;
                                                                        sql1 = null;
                                                                        int numPages = 0;
                                                                        String mode = "a";


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

                                                                            sql = "select ID,EMAIL,SUBJECT,MESSAGE,STATUS,to_char(MSGDATE,'dd-mm-yy') from RESPONSE  ";
                                                                            sql1 = "select count (*) from RESPONSE ";
                                                                            String re = request.getParameter("r");


                                                                            if (re != null) {
                                                                                mode = re.trim();
                                                                            }

                                                                            if (mode.equalsIgnoreCase("a")) {

                                                                                sql = "select ID,EMAIL,SUBJECT,MESSAGE,STATUS,to_char(MSGDATE,'dd-mm-yy') from RESPONSE order by ID desc";
                                                                                sql1 = "select count (*) from RESPONSE";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("ur")) {

                                                                                sql = "select ID,EMAIL,SUBJECT,MESSAGE,STATUS,to_char(MSGDATE,'dd-mm-yy') from RESPONSE   where status is null order by ID desc ";
                                                                                sql1 = "select count (*) from RESPONSE where status is null";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("r")) {
                                                                                sql = "select ID,EMAIL,SUBJECT,MESSAGE,STATUS,to_char(MSGDATE,'dd-mm-yy') from RESPONSE   where status='r' order by ID desc ";
                                                                                sql1 = "select count (*) from RESPONSE where status='r'";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("p")) {
                                                                                sql = "select ID,EMAIL,SUBJECT,MESSAGE,STATUS,to_char(MSGDATE,'dd-mm-yy') from RESPONSE   where status='p' order by ID desc ";
                                                                                sql1 = "select count (*) from RESPONSE where status='p'";
                                                                            }
                                                                            // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                            //   sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),rowid from contact_tab order by sugg_date desc ";
                                                                            // sql1 = "select count (*) from contact_tab";
                                                                            //    System.out.println("yahoooooooooooooooooooooooo");
                                                                            pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                            rs = pst.executeQuery();
                                                                            //   System.out.println("yahoooooooooooooooooooooooo");
                                                                            ps1 = con.prepareStatement(sql1);
                                                                            rs1 = ps1.executeQuery();
                                                                            //  System.out.println("yahoooooooooooooooooooooooo");
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

                                                                            for (count = startIndex; count < increment; count++) {
                                                                                if (rs.absolute(count)) {

                                                                                    // name = rs.getString(1);
                                                                                    // address = rs.getString(2);
                                                                                    emailid = rs.getString(2);
                                                                                    //   System.out.println("email id---------------" + emailid);
                                                                                    subject = rs.getString(3);
                                                                                    complain = rs.getString(4);
                                                                                    sugg_date = rs.getString(6);
                                                                                    status = rs.getString(5);
                                                                                     rowid = URLEncoder.encode(rs.getString("ID"), "UTF-8");


                                                                                    if (emailid == null) {
                                                                                        emailid = "-";
                                                                                    }
                                                                                    if (subject == null) {
                                                                                        subject = "-";
                                                                                    }
                                                                                    if (complain == null) {
                                                                                        complain = "-";
                                                                                    }
                                                                                    if (sugg_date == null) {
                                                                                        sugg_date = "-";
                                                                                    }

                                                                                    if (status.equals("r")) {
                                                                                        status = "Resolved";
                                                                                    }
                                                                                    if (status == null || status.equals("p")) {
                                                                                        status = "Pending";
                                                                                    }

                                %>
                                <tbody>
                                    <tr>

                                        <td ><%=emailid%></td>

                                        <td ><a href="comp_sugg_reply.jsp?rowid=<%=rowid%>"><%=subject%></a></td>
                                        <td ><%=sugg_date%></td>
                                        <td><%=status%></td>


                                        <td class="fix1"><div class="button contentfix"> <a href="comp_sugg_reply.jsp?rowid=<%=rowid%>">
                                                    <img src="../../resources/images/icons/Message-32.png" title="View" height="20" alt="View"/>
                                                </a>

                                                <a href="del_complain.jsp?rowid=<%=rowid%>" onclick="return confirmDel();">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>

                                    </tr>
                                </tbody>
                                <%
                                                                                }
                                                                            }
                                                                        } catch (Exception ex) {
                                                                            ex.printStackTrace();
                                                                        } finally {
                                                                            con.close();
                                                                        }

                                %>
                            </table>
                            <% if (numPages > 1) {%>
                            <div class="paging p1">
                                <ul>
                                    <%
                                         if (startIndex != 1) {
                                    %>
                                    <li class="first">
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=1&amp;pflag=1&amp;numRows=<%=numRows%>" title="First Page">
                                            <span class="leftcornerss">
                                                <span class="rightcornerss">
                                                    <span class="bgs">
                                                        <img src="../../resources/images/icons/First3.png"  class="im" alt="first" title="First"></img>
                                                    </span> <!-- .paging .bg -->
                                                </span> <!-- .paging .rightcorners -->
                                            </span> </a>
                                    </li>
                                    <li class="previous">
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=<%=startIndex - numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Previous Page">
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
                                             if (numRecordsPerPage == 1) {
                                                 if (j == startIndex) {
                                                     a = "active";
                                                 } else {
                                                     a = "";
                                                 }
                                             } else {
                                                 if (j == (startIndex / numRecordsPerPage) + 1) {
                                                     a = "active";
                                                 } else {
                                                     a = "";
                                                 }
                                             }
                                    %>
                                    <li class="<%=a%>">
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="1">
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
                                    <%if (startIndex + numRecordsPerPage <= numRows) {%>
                                    <li class="next">
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=<%=startIndex + numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Next Page">
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

                                    <%if (startIndex + numRecordsPerPage <= numRows) {
                                             if (remain != 0) {%>

                                    <li class="last">
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=<%=numRows - remain + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
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
                                        <a href="view_complains.jsp?b=outbox&amp;startIndex=<%=numRows - numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
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

                        <%  } else {
                        %>


                        <div id="table-blk" class="full">
                            <form  id="myform" >

                                Filter Complaints:    <select name="mylist" id="mylist" onchange="nav()"  >
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=inbox&r=a"  >Select</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=inbox&r=a" >All</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=inbox&r=r" >Resolve</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=inbox&r=p" >Pending</option>
                                    <option  value="../../jsppages/admin/view_complains.jsp?b=inbox&r=ur" >Unresolve</option>


                                </select>
                            </form>
                            <br/>
                            <%
                                                                    try {
                                                                        InitialContext initialContext = new InitialContext();
                                                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                                        con = dataSource.getConnection();
                                                                        String sql2 = "select count (*) from contact_tab where status is null";
                                                                        ps1 = con.prepareStatement(sql2);
                                                                        rs1 = ps1.executeQuery();

                                                                        if (rs1.next()) {
                                                                            new_complaints = rs1.getInt(1);
                                                                        }
                                                                    } catch (Exception e) {
                                                                        e.printStackTrace();
                                                                    } finally {
                                                                        con.close();

                                                                    }
                            %>
                            <%
                                                                    String sent = request.getParameter("sent");
                                                                    if (sent != null && sent.equals("y")) {
                            %>
                            <p style="font-weight: bold;">  Your Message has been Sent.  </p>
                            <%}%>
                            <%
                                                                    if (new_complaints > 0) {%>
                            <p style="font-weight: bold;">  You have <b style="font-style: italic;"> <%= new_complaints%> </b> new complaint. </p>
                            <%}%>
                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />

                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even"/>
                                    <col class="vzebra-odd" />
                                </colgroup>

                                <thead>

                                    <tr   >
                                        <th scope="col"   >Name</th>
                                        <th scope="col"   >Address</th>

                                        <th scope="col"   >Date</th>
                                        <th scope="col"   >Subject</th>
                                        <th scope="col"   >Status</th>
                                        <th scope="col"   >Actions</th>
                                    </tr>
                                </thead>
                                <%
                                                                        int count = 0;
                                                                        int increment = 1;
                                                                        int numRows = 0;
                                                                        sql = null;
                                                                        sql1 = null;
                                                                        int numPages = 0;
                                                                        String mode = "a";


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
                                                                            String re = request.getParameter("r");


                                                                            if (re != null) {
                                                                                mode = re.trim();
                                                                            }

                                                                            if (mode.equalsIgnoreCase("a")) {

                                                                                sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),status,rowid from contact_tab  order by ID desc";
                                                                                sql1 = "select count (*) from contact_tab";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("ur")) {

                                                                                sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),status,rowid from contact_tab where status is null order by ID desc ";
                                                                                sql1 = "select count (*) from contact_tab where status is null";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("r")) {
                                                                                sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),status,rowid from contact_tab where status='r' order by ID desc ";
                                                                                sql1 = "select count (*) from contact_tab where status='r'";
                                                                            }
                                                                            if (mode.equalsIgnoreCase("p")) {
                                                                                sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),status,rowid from contact_tab where status='p' order by ID desc ";
                                                                                sql1 = "select count (*) from contact_tab where status='p'";
                                                                            }
                                                                            // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                            //   sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),rowid from contact_tab order by sugg_date desc ";
                                                                            // sql1 = "select count (*) from contact_tab";
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

                                                                            for (count = startIndex; count < increment; count++) {
                                                                                if (rs.absolute(count)) {

                                                                                    name = rs.getString(1);
                                                                                    address = rs.getString(2);
                                                                                    emailid = rs.getString(3);
                                                                                    subject = rs.getString(4);
                                                                                    complain = rs.getString(5);
                                                                                    sugg_date = rs.getString(6);
                                                                                    status = rs.getString(7);
                                                                                    rowid = URLEncoder.encode(rs.getString(8), "UTF-8");
                                                                                    if (name == null) {
                                                                                        name = "-";
                                                                                    }
                                                                                    if (address == null) {
                                                                                        address = "-";
                                                                                    }
                                                                                    if (emailid == null) {
                                                                                        emailid = "-";
                                                                                    }
                                                                                    if (subject == null) {
                                                                                        subject = "-";
                                                                                    }
                                                                                    if (complain == null) {
                                                                                        complain = "-";
                                                                                    }
                                                                                    if (sugg_date == null) {
                                                                                        sugg_date = "-";
                                                                                    }
                                                                                    if (status == null) {
                                                                                        status = "Unresolved";
                                                                                    }
                                                                                    if (status.equals("r")) {
                                                                                        status = "Resolved";
                                                                                    }
                                                                                    if (status.equals("p")) {
                                                                                        status = "Pending";
                                                                                    }

                                %>
                                <tbody>
                                    <tr>
                                        <%

                                                                                                                            if (status.equals("Unresolved")) {

                                        %>
                                        <td style="font-weight: bold;"><%=name%></td>
                                        <td style="font-weight: bold;"><%=address%></td>

                                        <td style="font-weight: bold;"><%=sugg_date%></td>

                                        <td style="font-weight: bold;"><a href="comp_sugg.jsp?rowid=<%=rowid%>"><%=subject%></a></td>
                                        <td style="font-weight: bold;"><%=status%></td>

                                        <%
                                                                                                                                                                    } else {

                                        %>
                                        <td><%=name%></td>
                                        <td><%=address%></td>

                                        <td><%=sugg_date%></td>
                                        <td><a   href="comp_sugg.jsp?rowid=<%=rowid%>"><%=subject%></a></td>
                                        <td><%=status%></td>
                                        <%
                                                                                                                            }
                                        %>


                                        <td class="fix1"><div class="button contentfix"> <a href="comp_sugg.jsp?rowid=<%=rowid%>">
                                                    <img src="../../resources/images/icons/Message-32.png" title="View" height="20" alt="View"/>
                                                </a>

                                                <a href="del_complain.jsp?rowid=<%=rowid%>" onclick="return confirmDel();">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>

                                    </tr>
                                </tbody>
                                <%
                                                                                }
                                                                            }
                                                                        } catch (Exception ex) {
                                                                            System.out.println(ex);
                                                                        } finally {
                                                                            con.close();
                                                                        }

                                %>
                            </table>
                            <% if (numPages > 1) {%>
                            <div class="paging p1">
                                <ul>
                                    <%
                                         if (startIndex != 1) {
                                    %>
                                    <li class="first">
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=1&amp;pflag=1&amp;numRows=<%=numRows%>" title="First Page">
                                            <span class="leftcornerss">
                                                <span class="rightcornerss">
                                                    <span class="bgs">
                                                        <img src="../../resources/images/icons/First3.png"  class="im" alt="first" title="First"></img>
                                                    </span> <!-- .paging .bg -->
                                                </span> <!-- .paging .rightcorners -->
                                            </span> </a>
                                    </li>
                                    <li class="previous">
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=<%=startIndex - numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Previous Page">
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
                                             if (numRecordsPerPage == 1) {
                                                 if (j == startIndex) {
                                                     a = "active";
                                                 } else {
                                                     a = "";
                                                 }
                                             } else {
                                                 if (j == (startIndex / numRecordsPerPage) + 1) {
                                                     a = "active";
                                                 } else {
                                                     a = "";
                                                 }
                                             }
                                    %>
                                    <li class="<%=a%>">
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="1">
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
                                    <%if (startIndex + numRecordsPerPage <= numRows) {%>
                                    <li class="next">
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=<%=startIndex + numRecordsPerPage%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Next Page">
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

                                    <%if (startIndex + numRecordsPerPage <= numRows) {
                                             if (remain != 0) {%>

                                    <li class="last">
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=<%=numRows - remain + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
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
                                        <a href="view_complains.jsp?b=inbox&amp;startIndex=<%=numRows - numRecordsPerPage + 1%>&amp;pflag=1&amp;numRows=<%=numRows%>" title="Last Page">
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
                        <%}
                        %>
                    </div>
                </div>

            </div>
        </div>



        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>