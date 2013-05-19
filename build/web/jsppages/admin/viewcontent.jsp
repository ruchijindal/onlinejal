
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page import="java.sql.*,java.net.URLEncoder" %>

<%!    int t = 0;
    String sql;
    String content;
    String content_type;
    String con_id;
    String con_date;
    String con_title;
    PreparedStatement pst, ps1;
    Connection con;
    ResultSet rs, rs1;
    String userrole;
    String display;
    String priority;
    String rowid, a;
    int n = 1;
    String sql1;
//variables for pagination
    int startIndex = 1;
    int numRecordsPerPage = 4;
    int remain;
    int tstartIndex = 1;
    int rstartIndex = 1;
    int istartIndex = 1;
    int nstartIndex = 1;
    int sstartIndex = 1;
    int lstartIndex = 1;
    int mstartIndex = 1;
    int cstartIndex = 1;
    int pagestartIndex = 1;
    int otherstartIndex = 1;
    int schemastartIndex = 1;
    int rnumRows;
    int tnumRows;
    int inumRows;
    int nnumRows;
    int snumRows;
    int lnumRows;
    int cnumRows;
    int mnumRows;
    int pagenumRows;
    int policynumRows;
    int termsnumRows;
    int othersnumRows;
    /* int pflag = 0;
    int tflag = 0;
    int rflag = 0;
    int mflag = 0;
    int iflag = 0;
    int sflag = 0;
    int lflag = 0;
    int nflag = 0;
    int cflag = 0;
    int pageflag = 0;
    int policyflag = 0;
    int termsflag = 0;
    int othersflag = 0;*/
    int page = 0;
    int i, j, k;
    int chktab = 1;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head> <title>Noida Jal Board : Manage Contents</title>
        <jsp:include page="../common/header.jsp"/>

        <script type="text/javascript" src="../../resources/jquery/simpla.jquery.configuration.js"></script>

        <script language="javascript" type="text/javascript">

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
    <body>

        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

        %>

        <%

                    int count = 0;
                    int increment = 1;
                    int numRows = 0;
                    sql = null;
                    int numPages = 0;
                    int page_no;

                    if (request.getParameter("chktab") != null) {
                        chktab = Integer.parseInt(request.getParameter("chktab"));
                    } else {
                        chktab = 1;
                    }
                    /*
                    if (request.getParameter("pflag") != null) {
                    pflag = Integer.parseInt(request.getParameter("pflag"));
                    } else {
                    pflag = 0;
                    }
                    if (request.getParameter("sflag") != null) {
                    sflag = Integer.parseInt(request.getParameter("sflag"));
                    } else {
                    sflag = 0;
                    }
                    if (request.getParameter("mflag") != null) {
                    mflag = Integer.parseInt(request.getParameter("mflag"));
                    } else {
                    mflag = 0;
                    }
                    if (request.getParameter("nflag") != null) {
                    nflag = Integer.parseInt(request.getParameter("nflag"));
                    } else {
                    nflag = 0;
                    }
                    if (request.getParameter("rflag") != null) {
                    rflag = Integer.parseInt(request.getParameter("rflag"));
                    } else {
                    rflag = 0;
                    }
                    if (request.getParameter("iflag") != null) {
                    iflag = Integer.parseInt(request.getParameter("iflag"));
                    } else {
                    iflag = 0;
                    }
                    if (request.getParameter("lflag") != null) {
                    lflag = Integer.parseInt(request.getParameter("lflag"));
                    } else {
                    lflag = 0;
                    }
                    if (request.getParameter("cflag") != null) {
                    cflag = Integer.parseInt(request.getParameter("cflag"));
                    } else {
                    cflag = 0;
                    }

                    if (request.getParameter("tflag") != null) {
                    tflag = Integer.parseInt(request.getParameter("tflag"));
                    } else {
                    tflag = 0;
                    }

                    if (request.getParameter("othersflag") != null) {
                    othersflag = Integer.parseInt(request.getParameter("othersflag"));
                    } else {
                    othersflag = 0;
                    }*/

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
                            <a href="admin.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Contents
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->

                    <div id="tools">
                        <div class="button right1">
                            <a href="create_content.jsp" >
                                <span class="btleftcorners1">
                                    <span class="btrightcorners1">
                                        <span class="btbg1">
                                            Create Content
                                        </span>
                                    </span>
                                </span>
                            </a>   </div>
                    </div> <!-- #breadcrums .tools -->

                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->

        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="centerrail" >

                        <div class="news box box620 w">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>Content </h3>
                                            <ul class="content-box-tabs">
                                                <%                                        if (chktab == 1) {
                                                %>
                                                <li><a href="#tab1" class="default-tab">Message</a></li> <!-- href must be unique and match the id of target div -->
                                                <li><a href="#tab2" >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                                                                        } else if (chktab == 2) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2" class="default-tab" >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 3) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3" class="default-tab">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5"  >Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 4) {
                                                %>
                                                <li><a href="#tab1">Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4" class="default-tab">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 12) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2" >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12" class="default-tab" >Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 5) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5" class="default-tab">Ratelist</a></li>
                                                <li><a href="#tab6"  >Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 6) {
                                                %>
                                                <li><a href="#tab1">Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3"  >Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6" class="default-tab" >Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 7) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7"  class="default-tab">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tb10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 8) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7" >Link</a></li>
                                                <li><a href="#tab8"  class="default-tab">Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 9) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7" >Link</a></li>
                                                <li><a href="#tab8">Page</a></li>
                                                <li><a href="#tab9" class="default-tab">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        } else if (chktab == 10) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7" >Link</a></li>
                                                <li><a href="#tab8">Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10" class="default-tab">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>

                                                <%                                        } else if (chktab == 11) {
                                                %>
                                                <li><a href="#tab1" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7" >Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11"  class="default-tab">Others</a></li>
                                                <%                                        } else {
                                                %>
                                                <li><a href="#tab1" class="default-tab" >Message</a></li>
                                                <li><a href="#tab2"  >News</a></li>
                                                <li><a href="#tab3">Service</a></li>
                                                <li><a href="#tab4">Event</a></li>
                                                <li><a href="#tab12">Scheme</a></li>
                                                <li><a href="#tab5">Ratelist</a></li>
                                                <li><a href="#tab6">Information</a></li>
                                                <li><a href="#tab7">Link</a></li>
                                                <li><a href="#tab8" >Page</a></li>
                                                <li><a href="#tab9">Contact</a></li>
                                                <li><a href="#tab10">Testimonial</a></li>
                                                <li><a href="#tab11">Others</a></li>
                                                <%                                        }
                                                %>
                                            </ul>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">

                                            <div class="article">
                                                <div class="content-box-content">

                                                    <div class="tab-content <% if (chktab == 1) {%> default-tab <% }%>"  id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk"class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col">Content Id</th>
                                                                        <th scope="col">Content Title</th>
                                                                        <th scope="col">Content Type</th>
                                                                        <th scope="col">Content Date</th>
                                                                        <th scope="col">Display</th>
                                                                        <th scope="col">Priority</th>
                                                                        <th scope="col">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%
                                                                            try {

                                                                                String mstartIndexString = request.getParameter("mstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("mnumRows") != null) {
                                                                                    mnumRows = Integer.parseInt(request.getParameter("mnumRows"));
                                                                                } else {
                                                                                    mnumRows = 0;
                                                                                }

                                                                                if (mstartIndexString == null) {
                                                                                    mstartIndexString = "1";
                                                                                }



                                                                                mstartIndex = Integer.parseInt(mstartIndexString);
                                                                                InitialContext initialContext = new InitialContext();
                                                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                                                con = dataSource.getConnection();
                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='message' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='message'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    mnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = mnumRows / numRecordsPerPage;

                                                                                remain = mnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((mstartIndex + numRecordsPerPage) <= mnumRows) {

                                                                                    increment = mstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = mstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = mstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = mstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {

                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }

                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>

                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=1&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=1&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                                        </a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=1&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=1&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>


                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (mstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?mstartIndex=1&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span>
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?mstartIndex=<%=mstartIndex - numRecordsPerPage%>&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Prev3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span>
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (mstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (mstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?mstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>



                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <% 
                                                                    if (mstartIndex + numRecordsPerPage <= mnumRows) {
                                                                        %>
                                                                   
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?mstartIndex=<%=mstartIndex + numRecordsPerPage%>&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span>
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (mstartIndex + numRecordsPerPage <= mnumRows) {
                                                                        

                                                                             if (remain != 0) {                                                                      %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?mstartIndex=<%=mnumRows - remain + 1%>&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span>
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?mstartIndex=<%=mnumRows - numRecordsPerPage + 1%>&amp;chktab=1&amp;mnumRows=<%=mnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        Last &amp;raquo;
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
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
                                                        </div> <!-- End #tab1 -->
                                                    </div>




                                                    <div class="tab-content <% if (chktab == 2) {%> default-tab <% }%> " id="tab2"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String startIndexString = request.getParameter("startIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


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
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='news' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='news'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    numRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


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




                                                                                //while(rs.next())
                                                                                for (count = startIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=2&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=2&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=2&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=2&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
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
                                                                        <a href="viewcontent.jsp?startIndex=1&amp;chktab=2&amp;numRows=<%=numRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&amp;chktab=2&amp;numRows=<%=numRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img class="im" src="../../resources/images/icons/Prev3.png" alt="Previous" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
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
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?startIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=2&amp;numRows=<%=numRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>






                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (startIndex + numRecordsPerPage <= numRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&amp;chktab=2&amp;numRows=<%=numRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"  class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (startIndex + numRecordsPerPage <= numRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?startIndex=<%=numRows - remain + 1%>&amp;chktab=2&amp;numRows=<%=numRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"  class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?startIndex=<%=numRows - numRecordsPerPage + 1%>&amp;chktab=2&amp;numRows=<%=numRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"alt="first" class="im" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination-->

                                                            <%}%>


                                                        </div> <!-- End #tab1 -->
                                                    </div>





                                                    <div class="tab-content <% if (chktab == 3) {%> default-tab <% }%>" id="tab3"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {


                                                                                String sstartIndexString = request.getParameter("sstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("snumRows") != null) {
                                                                                    snumRows = Integer.parseInt(request.getParameter("snumRows"));
                                                                                } else {
                                                                                    snumRows = 0;
                                                                                }

                                                                                if (sstartIndexString == null) {
                                                                                    sstartIndexString = "1";
                                                                                }



                                                                                sstartIndex = Integer.parseInt(sstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='service' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='service'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    snumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = snumRows / numRecordsPerPage;

                                                                                remain = snumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((sstartIndex + numRecordsPerPage) <= snumRows) {

                                                                                    increment = sstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = sstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = sstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = sstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td ><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=3&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=3&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=3&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=3&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (sstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?sstartIndex=1&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?sstartIndex=<%=sstartIndex - numRecordsPerPage%>&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Prev3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (sstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (sstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?sstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>

                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (sstartIndex + numRecordsPerPage <=snumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?sstartIndex=<%=sstartIndex + numRecordsPerPage%>&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (sstartIndex + numRecordsPerPage <= snumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?sstartIndex=<%=snumRows - remain + 1%>&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>

                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?sstartIndex=<%=snumRows - numRecordsPerPage + 1%>&amp;chktab=3&amp;snumRows=<%=snumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>

                                                        </div> <!-- End #tab1 -->
                                                    </div>
                                                    <div class="tab-content <% if (chktab == 4) {%> default-tab <% }%>" id="tab4"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {


                                                                                String nstartIndexString = request.getParameter("nstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("nnumRows") != null) {
                                                                                    nnumRows = Integer.parseInt(request.getParameter("nnumRows"));
                                                                                } else {
                                                                                    nnumRows = 0;
                                                                                }

                                                                                if (nstartIndexString == null) {
                                                                                    nstartIndexString = "1";
                                                                                }



                                                                                nstartIndex = Integer.parseInt(nstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='notice' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='notice'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    nnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = nnumRows / numRecordsPerPage;

                                                                                remain = nnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((nstartIndex + numRecordsPerPage) <= nnumRows) {

                                                                                    increment = nstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = nstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = nstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = nstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>

                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=4&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=4&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=4&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=4&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>


                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (nstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?nstartIndex=1&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous"
                                                                        <a href="viewcontent.jsp?nstartIndex=<%=nstartIndex - numRecordsPerPage%>&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Prev3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (nstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (nstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?nstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>

                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (nstartIndex + numRecordsPerPage <= nnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?nstartIndex=<%=nstartIndex + numRecordsPerPage%>&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>

                                                                    <%}
                                                                    %>

                                                                    <%if (nstartIndex + numRecordsPerPage <= nnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?nstartIndex=<%=nnumRows - remain + 1%>&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?nstartIndex=<%=nnumRows - numRecordsPerPage + 1%>&amp;chktab=4&amp;nnumRows=<%=nnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>

                                                        </div> <!-- End #tab1 -->
                                                    </div>
                                                              <div class="tab-content <% if (chktab == 12) {%> default-tab <% }%> " id="tab12"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String startIndexString = request.getParameter("schemastartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("numRows") != null) {
                                                                                    numRows = Integer.parseInt(request.getParameter("numRows"));
                                                                                } else {
                                                                                    numRows = 0;
                                                                                }

                                                                                if (startIndexString == null) {
                                                                                    startIndexString = "1";
                                                                                }



                                                                                schemastartIndex = Integer.parseInt(startIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='schemes' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='schemes'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    numRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = numRows / numRecordsPerPage;

                                                                                remain = numRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((schemastartIndex + numRecordsPerPage) <= numRows) {

                                                                                    increment = schemastartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = schemastartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = schemastartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = schemastartIndex; count < increment; count++) {
                                                                                   
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=12&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=12&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=12&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=12&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (schemastartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?schemastartIndex=1&amp;chktab=12&amp;numRows=<%=numRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?schemastartIndex=<%=schemastartIndex - numRecordsPerPage%>&amp;chktab=12&amp;numRows=<%=numRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img class="im" src="../../resources/images/icons/Prev3.png" alt="Previous" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (schemastartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (schemastartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?schemastartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=12&amp;numRows=<%=numRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>






                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (schemastartIndex + numRecordsPerPage <= numRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?schemastartIndex=<%=startIndex + numRecordsPerPage%>&amp;chktab=12&amp;numRows=<%=numRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"  class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (schemastartIndex + numRecordsPerPage <=numRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?schemastartIndex=<%=numRows - remain + 1%>&amp;chktab=12&amp;numRows=<%=numRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"  class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?schemastartIndex=<%=numRows - numRecordsPerPage + 1%>&amp;chktab=12&amp;numRows=<%=numRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"alt="first" class="im" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination-->

                                                            <%}%>


                                                        </div> <!-- End #tab1 -->
                                                    </div>





                                                    <div class="tab-content <% if (chktab == 5) {%> default-tab <% }%>" id="tab5"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String rstartIndexString = request.getParameter("rstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("rnumRows") != null) {
                                                                                    rnumRows = Integer.parseInt(request.getParameter("rnumRows"));
                                                                                } else {
                                                                                    rnumRows = 0;
                                                                                }

                                                                                if (rstartIndexString == null) {
                                                                                    rstartIndexString = "1";
                                                                                }



                                                                                rstartIndex = Integer.parseInt(rstartIndexString);


                                                                                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='ratelist' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='ratelist'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    rnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = rnumRows / numRecordsPerPage;

                                                                                remain = rnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((rstartIndex + numRecordsPerPage) <= rnumRows) {

                                                                                    increment = rstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = rstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = rstartIndex + remain;
                                                                                    }
                                                                                }

                                                                                //while(rs.next())
                                                                                for (count = rstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=5&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=5&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=5&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=5&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (rstartIndex != 1) {
                                                                    %>
                                                                    <li class="first"
                                                                        <a href="viewcontent.jsp?rstartIndex=1&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?rstartIndex=<%=rstartIndex - numRecordsPerPage%>&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Prev3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (rstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (rstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?rstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>

                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%
;                                                                    if (rstartIndex + numRecordsPerPage <= rnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?rstartIndex=<%=rstartIndex + numRecordsPerPage%>&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (rstartIndex + numRecordsPerPage <= rnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?rstartIndex=<%=rnumRows - remain + 1%>&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>

                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?rstartIndex=<%=rnumRows - numRecordsPerPage + 1%>&amp;chktab=5&amp;rnumRows=<%=rnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>
                                                        </div> <!-- End #tab1 -->
                                                    </div>
                                                    <div class="tab-content <% if (chktab == 6) {%> default-tab <% }%>" id="tab6"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String istartIndexString = request.getParameter("istartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("inumRows") != null) {
                                                                                    inumRows = Integer.parseInt(request.getParameter("inumRows"));
                                                                                } else {
                                                                                    numRows = 0;
                                                                                }

                                                                                if (istartIndexString == null) {
                                                                                    istartIndexString = "1";
                                                                                }



                                                                                istartIndex = Integer.parseInt(istartIndexString);

                                                                                // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='information' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='information'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    inumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = inumRows / numRecordsPerPage;

                                                                                remain = inumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((istartIndex + numRecordsPerPage) <= inumRows) {

                                                                                    increment = istartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = istartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = istartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = istartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>

                                                                    <td><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=6&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=6&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=6&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=6&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (istartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?istartIndex=1&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous"
                                                                        <a href="viewcontent.jsp?istartIndex=<%=istartIndex - numRecordsPerPage%>&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Prev3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>
                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (istartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (istartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?istartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (istartIndex + numRecordsPerPage <= inumRows) {%>
                                                                    <li class="left">
                                                                        <a href="viewcontent.jsp?istartIndex=<%=istartIndex + numRecordsPerPage%>&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (istartIndex + numRecordsPerPage <= inumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?istartIndex=<%=inumRows - remain + 1%>&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?istartIndex=<%=inumRows - numRecordsPerPage + 1%>&amp;chktab=6&amp;inumRows=<%=inumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>
                                                        </div> <!-- End #tab1 -->
                                                    </div>


                                                    <div class="tab-content <% if (chktab == 7) {%> default-tab <% }%>" id="tab7"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String lstartIndexString = request.getParameter("lstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("lnumRows") != null) {
                                                                                    lnumRows = Integer.parseInt(request.getParameter("lnumRows"));
                                                                                } else {
                                                                                    lnumRows = 0;
                                                                                }

                                                                                if (lstartIndexString == null) {
                                                                                    lstartIndexString = "1";
                                                                                }



                                                                                lstartIndex = Integer.parseInt(lstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='links' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='links'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    lnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = lnumRows / numRecordsPerPage;

                                                                                remain = lnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((lstartIndex + numRecordsPerPage) <= lnumRows) {

                                                                                    increment = lstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = lstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = lstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = lstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td ><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=7&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=7&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=7&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=7&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (lstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?lstartIndex=1&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?lstartIndex=<%=lstartIndex - numRecordsPerPage%>&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Previous3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>

                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (lstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (lstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?lstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (lstartIndex + numRecordsPerPage <= lnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?lstartIndex=<%=lstartIndex + numRecordsPerPage%>&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (lstartIndex + numRecordsPerPage <= lnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?lstartIndex=<%=lnumRows - remain + 1%>&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last"
                                                                        <a href="viewcontent.jsp?lstartIndex=<%=lnumRows - numRecordsPerPage + 1%>&amp;chktab=7&amp;lnumRows=<%=lnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>
                                                        </div> <!-- End #tab1 -->
                                                    </div>




                                                    <div class="tab-content <% if (chktab == 8) {%> default-tab <% }%>" id="tab8"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String pagestartIndexString = request.getParameter("pagestartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("pagenumRows") != null) {
                                                                                    pagenumRows = Integer.parseInt(request.getParameter("pagenumRows"));
                                                                                } else {
                                                                                    othersnumRows = 0;
                                                                                }

                                                                                if (pagestartIndexString == null) {
                                                                                    pagestartIndexString = "1";
                                                                                }



                                                                                pagestartIndex = Integer.parseInt(pagestartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='page' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='page'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    pagenumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = pagenumRows / numRecordsPerPage;

                                                                                remain = pagenumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((pagestartIndex + numRecordsPerPage) <= pagenumRows) {

                                                                                    increment = pagestartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = pagestartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = pagestartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = pagestartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");

                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td ><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=8&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=8&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=8&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=8&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (pagestartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?pagestartIndex=1&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?pagestartIndex=<%=pagestartIndex - numRecordsPerPage%>&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Previous3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>

                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (pagestartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (pagestartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?pagestartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (pagestartIndex + numRecordsPerPage <= pagenumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?pagestartIndex=<%=pagestartIndex + numRecordsPerPage%>&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (otherstartIndex + numRecordsPerPage <= othersnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?pagestartIndex=<%=pagenumRows - remain + 1%>&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?pagestartIndex=<%=pagenumRows - numRecordsPerPage + 1%>&amp;chktab=8&amp;pagenumRows=<%=pagenumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->

                                                            <%}%>

                                                        </div> <!-- End #tab1 -->
                                                    </div>


                                                    <div class="tab-content <% if (chktab == 9) {%> default-tab <% }%>" id="tab9"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String cstartIndexString = request.getParameter("cstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("cnumRows") != null) {
                                                                                    cnumRows = Integer.parseInt(request.getParameter("cnumRows"));
                                                                                } else {
                                                                                    cnumRows = 0;
                                                                                }

                                                                                if (cstartIndexString == null) {
                                                                                    cstartIndexString = "1";
                                                                                }



                                                                                cstartIndex = Integer.parseInt(cstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='contact' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='contact'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    cnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = cnumRows / numRecordsPerPage;

                                                                                remain = cnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((cstartIndex + numRecordsPerPage) <= cnumRows) {

                                                                                    increment = cstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = cstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = cstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = cstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td ><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=9&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=9&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=9&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=9&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (cstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?cstartIndex=1&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?cstartIndex=<%=cstartIndex - numRecordsPerPage%>&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Previous3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>

                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (cstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (cstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?cstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (cstartIndex + numRecordsPerPage <= cnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?cstartIndex=<%=cstartIndex + numRecordsPerPage%>&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (cstartIndex + numRecordsPerPage <= cnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?cstartIndex=<%=cnumRows - remain + 1%>&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last"
                                                                        <a href="viewcontent.jsp?cstartIndex=<%=cnumRows - numRecordsPerPage + 1%>&amp;chktab=9&amp;cnumRows=<%=cnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>
                                                        </div> <!-- End #tab1 -->
                                                    </div>



                                                    <div class="tab-content <% if (chktab == 10) {%> default-tab <% }%>" id="tab10"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String tstartIndexString = request.getParameter("tstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("tnumRows") != null) {
                                                                                    tnumRows = Integer.parseInt(request.getParameter("tnumRows"));
                                                                                } else {
                                                                                    tnumRows = 0;
                                                                                }

                                                                                if (tstartIndexString == null) {
                                                                                    tstartIndexString = "1";
                                                                                }



                                                                                tstartIndex = Integer.parseInt(tstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type='testimonial' order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type='testimonial'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    tnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = tnumRows / numRecordsPerPage;

                                                                                remain = tnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((tstartIndex + numRecordsPerPage) <= tnumRows) {

                                                                                    increment = tstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = tstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = tstartIndex + remain;
                                                                                    }
                                                                                }




                                                                                //while(rs.next())
                                                                                for (count = tstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td ><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=10&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=10&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=10&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=10&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } catch (Exception ex) {
                                                                                System.out.println(ex);
                                                                            }

                                                                %>



                                                            </table>
                                                            <% if (numPages > 1) {%>
                                                            <div class="paging p1">
                                                                <ul>
                                                                    <%
                                                                         if (tstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?tstartIndex=1&amp;chktab=10&amp;tnumRows=<%=tnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?tstartIndex=<%=tstartIndex - numRecordsPerPage%>&amp;chktab=10&amp;tnumRows=<%=tnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Previous3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>

                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (tstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (tstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?tstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&amp;chktab=10&amp;tnumRows=<%=tnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (tstartIndex + numRecordsPerPage <= tnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?tstartIndex=<%=tstartIndex + numRecordsPerPage%>&amp;chktab=10&amp;tnumRows=<%=tnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (tstartIndex + numRecordsPerPage <= tnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?tstartIndex=<%=tnumRows - remain + 1%>&amp;chktab=10&amp;tnumRows=<%=tnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last"
                                                                        <a href="viewcontent.jsp?tstartIndex=<%=tnumRows - numRecordsPerPage + 1%>&amp;chktab=10&tnumRows=<%=tnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>
                                                        </div> <!-- End #tab1 -->
                                                    </div>





                                                    <div class="tab-content <% if (chktab == 11) {%> default-tab <% }%>" id="tab11"> <!-- This is the target div. id must match the href of this div's tab -->


                                                        <div id="table-blk" class="left">
                                                            <table class="box-table">
                                                                <colgroup>
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                    <col class="vzebra-even" />
                                                                    <col class="vzebra-odd" />
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" >Content Id</th>
                                                                        <th scope="col" >Content Title</th>
                                                                        <th scope="col" >Content Type</th>
                                                                        <th scope="col" >Content Date</th>
                                                                        <th scope="col" >Display</th>
                                                                        <th scope="col" >Priority</th>
                                                                        <th scope="col" >Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <%

                                                                            try {

                                                                                String otherstartIndexString = request.getParameter("otherstartIndex");

                                                                                if (request.getParameter("page") != null) {
                                                                                    page_no = Integer.parseInt(request.getParameter("page"));
                                                                                } else {
                                                                                    page_no = 0;
                                                                                }


                                                                                if (request.getParameter("othersnumRows") != null) {
                                                                                    othersnumRows = Integer.parseInt(request.getParameter("othersnumRows"));
                                                                                } else {
                                                                                    othersnumRows = 0;
                                                                                }

                                                                                if (otherstartIndexString == null) {
                                                                                    otherstartIndexString = "1";
                                                                                }



                                                                                otherstartIndex = Integer.parseInt(otherstartIndexString);

                                                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                                sql = "select con_id,con_title,content_type,to_char(con_date,'dd-mm-yy'),display,priority,rowid from jal_content where content_type!='message' and content_type!='news' and "
                                                                                        + " content_type!='notice' and  content_type!='page' and content_type!='service' and content_type!='information' and content_type!='links' and content_type!='ratelist' "
                                                                                        + " and content_type!='schemes' and content_type!='contact' and content_type!='testimonial'  order by con_date";
                                                                                sql1 = "select count(*) from jal_content where content_type!='message' and content_type!='news' and "
                                                                                        + " content_type!='notice'  and  content_type!='page' and content_type!='service' and content_type!='information' and content_type!='links' and content_type!='ratelist'"
                                                                                        +"and content_type!='schemes' and content_type!='contact' and content_type!='testimonial'";
                                                                                pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.FETCH_UNKNOWN);
                                                                                rs = pst.executeQuery();
                                                                                ps1 = con.prepareStatement(sql1);
                                                                                rs1 = ps1.executeQuery();
                                                                                if (rs1.next()) {
                                                                                    othersnumRows = rs1.getInt(1);
                                                                                }


                                                                                int numRecordsPerPage = 4;


                                                                                numPages = othersnumRows / numRecordsPerPage;

                                                                                remain = othersnumRows % numRecordsPerPage;

                                                                                if (remain != 0) {

                                                                                    numPages = numPages + 1;

                                                                                }

                                                                                //out.println(" \n no. of pages : " + numPages );

                                                                                if ((otherstartIndex + numRecordsPerPage) <= othersnumRows) {

                                                                                    increment = otherstartIndex + numRecordsPerPage;
                                                                                } else {

                                                                                    if (remain == 0) {

                                                                                        increment = otherstartIndex + numRecordsPerPage;

                                                                                    } else {

                                                                                        increment = otherstartIndex + remain;
                                                                                    }
                                                                                }

                                                                                //while(rs.next())
                                                                                for (count = otherstartIndex; count < increment; count++) {
                                                                                    if (rs.absolute(count)) {
                                                                                        con_id = rs.getString(1);
                                                                                        con_title = rs.getString(2);
                                                                                        if (con_title == null) {
                                                                                            con_title = "-";
                                                                                        }
                                                                                        content_type = rs.getString(3);
                                                                                        if (content_type == null) {
                                                                                            content_type = "-";
                                                                                        }
                                                                                        con_date = rs.getString(4);
                                                                                        if (con_date == null) {
                                                                                            con_date = "-";
                                                                                        }
                                                                                        display = rs.getString(5);
                                                                                        if (display == null) {
                                                                                            display = "-";
                                                                                        }
                                                                                        priority = rs.getString(6);
                                                                                        if (priority == null) {
                                                                                            priority = "-";
                                                                                        }
                                                                                        rowid = URLEncoder.encode(rs.getString(7), "UTF-8");

                                                                                        if (n % 2 == 0) {
                                                                %>

                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td><%=content_type%></td>
                                                                    <td ><%=con_date%></td>
                                                                    <td><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?chktab=11&amp;con_id=<%=con_id%>"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=11&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>


                                                                <%
                                                                                                                                                                n++;
                                                                                                                                                            } else {
                                                                %>
                                                                <tr>
                                                                    <td ><%=con_id%></td>
                                                                    <td><%=con_title%></td>
                                                                    <td ><%=content_type%></td>
                                                                    <td><%=con_date%></td>
                                                                    <td ><%=display%></td>
                                                                    <td><%=priority%></td>
                                                                    <td class="actions">
                                                                        <a href="edit_content.jsp?con_id=11"><img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="View"/></a>
                                                                        &nbsp;&nbsp;&nbsp;
                                                                        <a href="del_content.jsp?chktab=11&amp;con_id=<%=con_id%>" onclick="return confirmDel();"><img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/></a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                            n++;
                                                                                        }
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
                                                                         if (otherstartIndex != 1) {
                                                                    %>
                                                                    <li class="first">
                                                                        <a href="viewcontent.jsp?otherstartIndex=1&amp;chktab=11&othersnumRows=<%=othersnumRows%>" title="First Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/First3.png"   class="im" alt="first" title="First"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <li class="previous">
                                                                        <a href="viewcontent.jsp?otherstartIndex=<%=otherstartIndex - numRecordsPerPage%>&chktab=11&othernumRows=<%=othersnumRows%>" title="Previous Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Previous3.png"   class="im" alt="first" title="Previous"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                         }
                                                                    %>

                                                                    <%
                                                                         if (numPages <= 5) {
                                                                             i = 1;
                                                                             k = numPages;
                                                                         } else {
                                                                             i = (otherstartIndex / numRecordsPerPage) + 1;
                                                                             if (i + 4 <= numPages) {
                                                                                 k = i + 4;
                                                                             } else {
                                                                                 i = numPages - 4;
                                                                                 k = numPages;
                                                                             }
                                                                         }
                                                                         for (j = i; j <= k; j++) {
                                                                             if (j == (otherstartIndex / numRecordsPerPage) + 1) {
                                                                                 a = "active";
                                                                             } else {
                                                                                 a = "";
                                                                             }
                                                                    %>
                                                                    <li class="<%=a%>">
                                                                        <a href="viewcontent.jsp?otherstartIndex=<%=(j - 1) * numRecordsPerPage + 1%>&chktab=11&othersnumRows=<%=othersnumRows%>" title="1">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <%=j%>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}

                                                                    %>




                                                                    <%/*increment += numRecordsPerPage ;*/%>
                                                                    <%if (otherstartIndex + numRecordsPerPage <= othersnumRows) {%>
                                                                    <li class="next">
                                                                        <a href="viewcontent.jsp?otherstartIndex=<%=otherstartIndex + numRecordsPerPage%>&chktab=11&othersnumRows=<%=othersnumRows%>" title="Next Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Next3.png"   class="im" alt="first" title="Next"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%}
                                                                    %>

                                                                    <%if (otherstartIndex + numRecordsPerPage <= othersnumRows) {
                                                                                 if (remain != 0) {%>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?otherstartIndex=<%=othersnumRows - remain + 1%>&chktab=11&othersnumRows=<%=othersnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                                                                                                     } else {
                                                                    %>
                                                                    <li class="last">
                                                                        <a href="viewcontent.jsp?otherstartIndex=<%=othersnumRows - numRecordsPerPage + 1%>&chktab=11&othersnumRows=<%=othersnumRows%>" title="Last Page">
                                                                            <span class="leftcornerss">
                                                                                <span class="rightcornerss">
                                                                                    <span class="bgs">
                                                                                        <img src="../../resources/images/icons/Last3.png"   class="im" alt="first" title="Last"></img>
                                                                                    </span> <!-- .pagination .bg -->
                                                                                </span> <!-- .pagination .rightcorners -->
                                                                            </span> <!-- .pagination .leftcorners -->
                                                                        </a>
                                                                    </li>
                                                                    <%
                                                                             }
                                                                         }
                                                                    %>
                                                                </ul>
                                                            </div> <!-- End .pagination -->
                                                            <%}%>


                                                        </div> <!-- End #tab1 -->

                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div> <!-- End .content-box-content -->

                        </div> <!-- End .content-box -->
                    </div>
                </div>
            </div>

        </div>

        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>