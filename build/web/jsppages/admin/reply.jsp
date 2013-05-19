<%--
    Document   : reply
    Created on : 1 Apr, 2011, 5:41:43 PM
    Author     : smp
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%!    String emailId;
    String subject;
    String subject1;
    int t;
    String complaint;
    Connection con;
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Noida Jal Board : Reply</title>
        <jsp:include page="../common/header.jsp"/>
        <script  type="text/javascript" src="../../resources/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="../../resources/jquery/jquery.validate_1.js"></script>

        <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>
        <script type="text/javascript">
            $(document).ready(function()
            {

                $("#con_date").mask("99/99/99");
                $("#adminform").validate();

            });

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

            function popitup(url)
            {
                newwindow=window.open(url,'name','height=1200,width=1200');
                if (window.focus) {newwindow.focus()}
                return false;
            }
            function wait()
            {
                document.getElementById("mailwait").removeAttribute("style");
                document.getElementById('mailsent').removeAttribute("style");
            }

        </script>

        <script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
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
                        <div class="inactive">
                            <a href="view_complains.jsp?b=inbox" title="Complaints">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Complaint/Suggestion
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="active">
                            <a href="#" title="Reply">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Reply
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
                        <h2>Reply</h2>

                        <%
                                    try {

                                        emailId = request.getParameter("email");
                                        subject = "RE: ";
                                        subject += request.getParameter("subj");
                                        subject1 = request.getParameter("subj");
                                        complaint = request.getParameter("comp");
                                        System.out.println("on reply rowId-->" + request.getParameter("rowId"));

                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    }
                        %>

                        <div id="mailwait" style="visibility: hidden"  >
                            <img src="<%=request.getContextPath()%>/resources/images/ajax-loader.gif" alt="wait"/>
                        </div>
                        <div id="mailsent" style="visibility: hidden"  >
                            <P>Sending Message...</P>
                        </div>

                        <form action="<%= request.getContextPath()%>/sendReplyMail" id="adminform" method="post" onsubmit="wait()"   >
                            <fieldset>
                                <ul>
                                    <li>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td><label for="mailId">Reply to:  </label></td>
<!--                                                    <td><label  ><%=emailId%>  </label>-->
                                                    <td> <input   name="mailId" value="<%= emailId%>" style="width: 300px;" />
                                                        <input type="hidden" name="rowId" value="<%= request.getParameter("rowId")%>" /></<br/><br/></td>


                                                </tr>

                                                <tr>
                                                    <td> <label for="subj">Subject:  </label></td>
    <!--                                                <td> <label ><%=subject%>  </label>-->
                                                    <td><input   name="subj" value="<%= subject%>"  style="width: 300px;" /><br/><br/></td>
                                                </tr>



                                                <tr>
                                                    <td> <label for="message">Message: </label></td><td></td></tr>
                                                <tr>
                                                    <td></td>
                                                    <td colspan="8"><textarea name="content1" id="textarea1" cols="80" rows="20">

                                                        <br class="clear"/><br class="clear"/> 
                                                            <p>________________________________________________________</p>


<p>From:<%=emailId%></p>
<p>Subject:<%=subject1%></p>
<p>Complaint:<%=complaint%></p>
                                                        </textarea>
                                                    </td>
                                                </tr>

                                                <tr><td colspan="2"> <p class="required">* Required Fields</p></td></tr>

                                                <tr>
                                                    <td style="width: 100px"> <label for="check" >Resolve:  </label></td>
                                                    <td> <input   id="check" type="checkbox" name="status" /><br/><br/></td>
                                                </tr>
                                                <tr><td></td>



                                                    <td>                                        <div class="buttons">

                                                            <button class="submit" type="submit" value="Submit" >
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Submit
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>
                                                        <div class="buttons">

                                                            <button class="submit" type="reset" value="Reset">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Reset
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>
                                                    </td></tr>
                                            </tbody>
                                        </table>
                                    </li>
                                </ul>
                            </fieldset>
                        </form>


                    </div> <!-- #news .article -->


                    <br class="clear"/>
                    <br class="clear"/>
                    <div id="contentrail" class="full">
                        <h2>Previous Conversations</h2>
                        <%
                                    try {
                                        InitialContext initialContext = new InitialContext();
                                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                        con = dataSource.getConnection();
                                        String sql1 = "select to_char(msgdate,'dd-mm-yy'),message,id from RESPONSE where email='" + emailId + "' order by id desc";
                                        Statement st = con.createStatement();
                                        ResultSet rs = st.executeQuery(sql1);
                                        while (rs.next()) {%>

                        <div class="article">

                            <div class="info">Date:<%=rs.getString(1)%> </div>
                            <%=rs.getString("message") %>
                        </div>
                        <%}
                                    } catch (Exception e) {
                                    } finally {
                                        con.close();
                                    }
                        %>

                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            CKEDITOR.replace('content1');
        </script>
        <jsp:include page="../common/footer.jsp"/>
    </body>

</html>
