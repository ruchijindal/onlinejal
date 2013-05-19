<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%!    int t = 0;
    String sql;
    String content;
    String content_type;
    String con_id;
    String con_date;
    String con_title;
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    String userrole;
    String display;
    String priority;
    int n = 1;
    int chktab=0;

%>



<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board :Content</title>
        <jsp:include page="../common/header.jsp"/>
        <script  type="text/javascript" src="../../resources/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="../../resources/jquery/jquery.validate_1.js"></script>

        <script   type="text/javascript">
// <![CDATA[


            $(document).ready(function()
            {
                $("#viewform").validate();
     
            });

            function setContype()
            {
                contype=document.forms[0].contype.value;

                for(i=0;i < document.getElementById("content_type").length;i++)
                {

                    if(document.getElementById("content_type").options[i].value.trim()==contype.trim())
                    {

                        document.getElementById("content_type").selectedIndex=i;
                    }
                }

                display=document.forms[0].dis.value;

                for(i=0;i < document.getElementById("display").length;i++)
                {

                    if(document.getElementById("display").options[i].value.trim()==display.trim())
                    {

                        document.getElementById("display").selectedIndex=i;
                    }
                }


            }
// ]]> 

        </script>

        <script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
    </head>
    <body onload="setContype()">

        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                     if (request.getParameter("chktab") != null) {
                       chktab = Integer.parseInt(request.getParameter("chktab"));
                    } else {
                        chktab = 0;
                    }
                    
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
                                            Update contents
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

                        <h2>Update contents</h2>

                        <%

                                    try {
                                        InitialContext initialContext = new InitialContext();
                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                        con = dataSource.getConnection();
                                        //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                        con_id = request.getParameter("con_id");
                                        sql = "select con_id,con_title,content,content_type,to_char(con_date,'dd/MON/yy'),display,priority from jal_content where con_id='" + con_id + "'";
                                        pst = con.prepareStatement(sql);
                                        rs = pst.executeQuery();
                                        if (rs.next()) {
                                            con_id = rs.getString(1);
                                            con_title = rs.getString(2);
                                            content = rs.getString(3);
                                            content_type = rs.getString(4).toString().trim();
                                            con_date = rs.getString(5);
                                            display = rs.getString(6);
                                           //  content =  content.replaceAll("\\<.*?>", " ");

                                                             
                                            priority = rs.getString(7);
                                        }
                                        if (con_id != null) {
                                            con_id.trim();
                                        }

                                        if (con_title != null) {
                                            con_title.trim();
                                        } else {
                                            con_title = "";
                                        }
                                        if (content != null) {
                                            content.trim();
                                        } else {
                                            content = "";
                                        }
                                        if (content_type != null) {
                                            content_type.trim();
                                        } else {
                                            content_type = "";
                                        }
                                        if (con_date != null) {
                                            con_date.trim();
                                        } else {
                                            con_date = "";
                                        }
                                        if (display != null) {
                                            display.trim();
                                        } else {
                                            display = "";
                                        }
                                        if (priority != null) {
                                            priority.trim();
                                        } else {
                                            priority = "";
                                        }

                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    } finally {
                                        con.close();
                                    }
                        %>

                        <form id="viewform"  method="post" action="upd_content.jsp?chktab=<%=chktab%>" >

                            <fieldset>
                                <ul>
                                    <li>
                                        <table><tbody>
                                                <tr><td>
                                                        <label for="con_id">ContentID:</label></td>
                                                    <td>  <input id="con_id" type="text" name="con_id" value="<%=con_id%>"  /></td>

                                                    <td> <label for="con_title">ContentTitle:</label></td>
                                                    <td>  <input id="con_title" type="text" class="full required" name="con_title" value="<%=con_title%>"/></td>

                                                    <td><input type="hidden" name="contype" id="contype" value="<%=content_type%>"></input></td>
                                                    <td>  <label for="content_type">ContentType: </label></td>
                                                    <td>  <select  name="content_type" id="content_type">
                                                            <option value="testimonial">Testimonial</option>
                                                            <option value="news">News</option>
                                                            <option value="service">Service</option>
                                                            <option value="notice">Event</option>
                                                            <option value="message">Message</option>
                                                            <option value="information">Information</option>
                                                            <option value="ratelist">RateList</option>
                                                            <option value="links">Links</option>
                                                            <option value="policy">Policy</option>
                                                            <option value="terms">Terms &amp; Conditions</option>
                                                            <option value="page">Page</option>
                                                            <option value="contact">Contact</option>
                                                            <option value="others">Others</option>
                                                        </select></td>


                                                    <td> <label for="con_date">ContentDate:</label></td>
                                                    <td>  <input type="text" name="con_date" id="con_date" value="<%=con_date%>"/><br/><br/></td>
                                                </tr>

                                                <tr>

                                                    <td> <label for="priority">Priority:</label></td>
                                                    <td> <input id="priority" name="priority" type="text" value="<%=priority%>" /></td>
                                                    <td>  <label for="display">Display:</label></td>
                                                    <td><select name="display" id="display">
                                                            <option value="default">Visible</option>
                                                            <option value="home">Home</option>
                                                            <option value="none">None</option>
                                                        </select></td>
                                                    <td colspan="5"><br/><br/></td></tr> <tr><td><input type="hidden" name="dis" value="<%=display%>"/></td> </tr>


                                                <tr><td colspan="9">
                                                        <textarea name="content1" id="textarea1" cols="80" rows="20"><%=content%></textarea><br/>
                                                    </td>
                                                </tr>



                                                <tr><td>
                                                        <div class="buttons">
                                                            <button class="submit a" type="submit" value="Submit">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                                                            <!--a href="viewcontent.jsp">
                                    			Submit
                                                                               </a-->
                                                                            Submit
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>
                                                        </div>
                                                    </td><td>
                                                        <div class="buttons">
                                                            <button class="submit a" type="submit" value="Submit">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Cancel
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>
                                                    </td>
                                                    <td colspan="7"></td>
                                                </tr></tbody></table>

                                    </li>
                                </ul>
                            </fieldset>
                        </form>

                    </div> <!-- #centerrail -->

                </div>
            </div>
        </div>

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->
        <script type="text/javascript">
            CKEDITOR.replace('content1');
        </script>
    </body>
</html>

