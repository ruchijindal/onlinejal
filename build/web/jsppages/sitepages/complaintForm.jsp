<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    String msg = "";
    String userrole;
    int t;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Contact Us</title>
    <jsp:include page="../common/header.jsp"/>


    <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>

    <script  type="text/javascript">
        $(document).ready(function()
        {
            $("#contactusform").validate();
        });
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
                            <a href="#" title="contact us">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Complaint Form
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

                        <h2>Complaint Form</h2>
                        <p>For Any Complaints and Suggestions fill the form  OR  Call us at 0120-2425218, 0120-2425219</p>
                        <%
                                    try {

                                        msg = request.getParameter("msg");
                                        if (msg != null) {
                                            if (msg.equals("a")) {
                        %>
                        <p style="font-weight: bold;">Your complaint has been submitted.</p>
                        <%                                             } else if (msg.equals("b")) {
                        %>
                        <p style="font-weight: bold;">Your Complaint could not be submitted .Try again.</p>
                        <%                                           }
                                        }
                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    }
                        %>
                        <form action="ins_contact.jsp" id="contactusform" method="post">
                            <fieldset>
                                <ul>
                                    <li>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td><label for="name">Name: <span class="required">*</span></label></td>
                                                    <td><input name="name" id="name" class="required"  type="text" /><br/><br/></td>
                                                </tr>

                                                <tr>
                                                    <td> <label for="email">Email: <span class="required">*</span></label></td>
                                                    <td> <input name="email" id="email" class="required email"  type="text" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td>  <label for="phone">PhoneNo.:<span class="required">*&nbsp;&nbsp;</span></label></td>
                                                    <td> <input name="phone" id="phone" class="required number" type="text" maxlength="15" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td><label for="address">Address: <span class="required">*</span></label></td>
                                                    <td> <input name="address" id="address" class="required" type="text" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td><label for="subject">Subject: <span class="required">*</span></label></td>
                                                    <td><input name="subject" id="subject" class="required"  type="text" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td> <label for="message">Message: <span class="required">*</span></label></td><td></td></tr>
                                                <tr>
                                                    <td></td>
                                                    <td><textarea name="message" id="message" class="required"  cols="50" rows="5"></textarea></td>
                                                </tr>

                                                <tr><td colspan="2"> <p class="required">* Required Fields</p></td></tr>
                                                <tr><td></td>
                                                    <td>                                        <div class="buttons">

                                                            <button class="submit" type="submit" value="Submit">
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

                </div>
            </div>
        </div>

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>

















