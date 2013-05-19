<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>


<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page import="java.net.URLEncoder"%>

<%! String name;
    String address;
    String emailid;
    String subject;
    String complain;
    Connection con;
    PreparedStatement pst;
    String sql;
    ResultSet rs;
    String userrole;
    String rowid;
    String date;
    String phoneno;
    int t;
    int temp = 0;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Complaints</title>
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



            function toggleVisibility(op )

            {
                var div = document.getElementById("child");

                var button1=document.getElementById("button1");
                var button2=document.getElementById("button2");
                if(op=='1')
                    {
                div.style.display = "block";
                 
                button1.style.display="none";
                button2.style.display="none";
                    }
                    else{

                        div.style.display = "none";

                button1.style.display="block";
                button2.style.display="block";
                    }
            }
            function wait()
            {
                document.getElementById("mailwait").style.display="block";
                document.getElementById('mailsent').style.display="block";
                document.getElementById('button3').disabled="true";
                document.getElementById('button4').disabled="true";
                var all_links = document.getElementsByTagName("a");

    for(var i=0; i<all_links.length; i++){
        all_links[i].removeAttribute("href");
    }
                
            }

        </script>
        <script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
    </head>


    <%
                request.getSession(false);
                request.setAttribute("t", t);
                rowid = request.getParameter("rowid");

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
                                            Suggestion/Complaint
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
                        <h2>Suggestions / Complaints</h2>
                        <form id="sugg" action="del_complain.jsp?rowid=<%=rowid%>" method="post" >

                            <table>


                                <%
                                            try {

                                                InitialContext initialContext = new InitialContext();
                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                con = dataSource.getConnection();
                                                //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                sql = "select name,address,emailid,subject,sugg_com,to_char(sugg_date,'dd-mm-yy'),rowid,phoneno from contact_tab where rowid='" + rowid + "'";
                                                pst = con.prepareStatement(sql);
                                                rs = pst.executeQuery();
                                                if (rs.next()) {
                                                    name = rs.getString(1);
                                                    address = rs.getString(2);
                                                    emailid = rs.getString(3);
                                                    subject = rs.getString(4);
                                                    complain = rs.getString(5);
                                                    date = rs.getString(6);
                                                    rowid = URLEncoder.encode(rs.getString(7), "UTF-8");
                                                    phoneno = rs.getString(8);
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
                                                    if (date == null) {
                                                        date = "-";
                                                    }
                                                    if (phoneno == null) {
                                                        phoneno = "-";
                                                    }
                                %>

                                <tbody  >

                                    <tr><td class="bold">Name: </td><td class="n"><%=name%></td></tr>
                                    <tr><td class="bold">Address: </td><td class="n"><%=address%></td></tr>
                                    <tr><td class="bold">Email ID: </td><td class="n"><%=emailid%></td></tr>
                                    <tr><td class="bold">Phone No: </td><td class="n"><%=phoneno%></td></tr>
                                    <tr><td class="bold">Subject: </td><td class="n"><%=subject%></td></tr>
                                    <tr><td class="bold">Date: </td><td class="n"><%=date%></td></tr>
                                    <tr><td class="bold">Complaint</td><td class="n" ><%=complain%><br/><br/></td>                                    </tr>
                                    <tr> <td>
                                            <button id="button1" class="submit"  type="button"    onclick="toggleVisibility('1');">
               <!-- <button class="submit"  type="button"   onclick="window.location='../admin/reply.jsp?rowId=<%=rowid%>&email=<%=emailid%>&subj=<%=subject%>&comp=<%=complain%>'">-->

                                                <span class="leftcorners">
                                                    <span class="rightcorners">
                                                        <span class="bg">
                                    			Reply  
                                                        </span>
                                                    </span>
                                                </span>
                                            </button>

                                            <button class="submit" type="submit" value="Submit" id="button2"   onclick="return confirmDel();">
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
               

 <div id="mailwait" style="display: none"  >
                            <img src="<%=request.getContextPath()%>/resources/images/ajax-loader.gif" alt="wait"/>
                        </div>
                        <div id="mailsent" style="display: none"  >
                            <b>Sending Message... </b>
                        </div>
                        <br/>
<form action="<%= request.getContextPath()%>/sendReplyMail" id="adminform" method="post"  onsubmit="wait()"     >
    <input type="hidden" name="rowId" value="<%=rowid%>" />
    <input type="hidden" name="mailId" value="<%=emailid%>" />
     <input type="hidden" name="subj" value="<%="Re: "+subject%>" />
      <input type="hidden" name="comp" value="<%=complain%>" />

<div id="child" style="display:none; ">
                            <table id="table" >
                                <tbody >
                                    <tr>
                                        <td > <label  for="message">Message: </label></td><td></td></tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="8"><textarea name="content1" id="textarea1" cols="80" rows="20">

                                                        <br class="clear"/><br class="clear"/>
                                                            <p>________________________________________________________</p>


                                                  
                                                                <p>Subject:<%=subject%></p>
                                                                <p>Complaint:<%=complain%></p>
                                            </textarea>
                                        </td>
                                    </tr>
                                            <tr><td colspan="2"> <p class="required">* Required Fields</p></td></tr>

                                                <tr>
                                                    <td style="width: 100px"> <label for="check" >Resolve:  </label></td>
                                                    <td> <input   id="check" type="checkbox" name="status" /><br/><br/></td>
                                                </tr>

                                </tbody>
                            </table>
                                            <br/>      <tr> <td>
                                                     
                                                    <button class="submit" id="button3" type="submit" value="Submit"   >
               <!-- <button class="submit"  type="button"   onclick="window.location='../admin/reply.jsp?rowId=<%=rowid%>&email=<%=emailid%>&subj=<%=subject%>&comp=<%=complain%>'">-->

                                                <span class="leftcorners">
                                                    <span class="rightcorners">
                                                        <span class="bg">
                                    			Send
                                                        </span>
                                                    </span>
                                                </span>
                                            </button>

                                            <button class="submit" type="button"  id="button4" onclick="toggleVisibility('2');">
                                                <span class="leftcorners">
                                                    <span class="rightcorners">
                                                        <span class="bg">
                                    			Back
                                                        </span>
                                                    </span>
                                                </span>
                                            </button></td></tr>
                        </div>
</form>
 
                        <br class="clear"/>
                        <br class="clear"/>
                        <div id="contentrail" class="full">
                            <h2>Previous Conversations</h2>
                            <%


                                                                                con = dataSource.getConnection();
                                                                                String sql1 = "select to_char(msgdate,'dd-mm-yy'),message,id from RESPONSE where email='" + emailid + "' order by id desc";
                                                                                Statement st = con.createStatement();
                                                                                ResultSet rs = st.executeQuery(sql1);
                                                                                while (rs.next()) {%>

                            <div class="article">

                                <div class="info">Date:<%=rs.getString(1)%> </div>
                                <%=rs.getString("message")%>
                            </div>
                            <%}

                            %>

                        </div>

                        <%
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
        <div id="overlay">

        </div>
        <script type="text/javascript">
            CKEDITOR.replace('content1');
        </script>
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>

    

</html>