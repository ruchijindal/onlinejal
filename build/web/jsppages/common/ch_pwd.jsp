<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%!    int cp = 0;
    String userrole;
    int t;
%>
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

    <jsp:include page="header.jsp"/>
    <head><title>Noida Jal Board :  Change Password</title> </head>

    <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {
            $("#userform").validate();
     
        });
    </script>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");

        %>
        <!-- Menu Starts -->
        <jsp:include page="navigation.jsp"/>
        <!-- Menu Ends -->

        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="leftcorners">
                        <div class="rightcorners">
                            <div class="bg">
                            </div> <!-- #helper .bg -->
                        </div> <!-- #helper .rightcorners -->
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
                                            Change Password
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div>
            </div>
        </div>

        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="full">

                        <h2>Change Password</h2>

                        <%
                                    try {
                                        cp = Integer.parseInt(request.getParameter("cp"));

                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    }
                                    if (cp == 1) {
                                        cp = 0;
                        %>
                        <p>Password changed successfully.</p>
                        <%
                                                            } else if (cp == 2) {
                                                                cp = 0;
                        %>
                        <p>There was some error.</p>
                        <%
                                                            }
                        %>
                        <form id="userform" action="../common/changepassword.jsp" method="post" >
                            <fieldset>
                                <ul>
                                    <li><table>
                                            <tbody>
                                            <tr>

                                                <td><label for="oldpassword">OldPassword:<span class="required">*</span></label></td>
                                                <td> <input name="oldpassword" id="oldpassword" class="required" type="password" /><br/><br/></td>
                                            </tr>
                                            <tr>

                                                <td><label for="password">NewPassword:<span class="required">*</span></label></td>
                                                <td> <input name="npassword" id="npassword" class="required" minlength="6" type="password" /><br/><br/></td>
                                            </tr>
                                            <tr>

                                                <td><label for="cpassword">ConfirmPassword:<span class="required">*</span></label></td>
                                                <td><input name="cpassword" id="cpassword" class="required" minlength="6"  equalTo="#npassword" type="password" /><br/><br/></td>
                                            </tr>
                                                <tr><td colspan="2">  <p class="required">* Required Fields</p></td></tr>
                                           
                                                <tr><td></td><td>
                                        <div class="buttons">
                                               
                                                        <button class="submit" type="submit" value="Submit">
                                                            <span class="leftcorners">
                                                                <span class="rightcorners">
                                                                    <span class="bg">
                                    			Change
                                                                    </span>
                                                                </span>
                                                            </span>
                                                        </button>

                                                    </div><div class="buttons">

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
                                      
                                      
                                                       </td></tr> </tbody>
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
        <jsp:include page="footer.jsp"/>
        <!-- Footer Ends -->
    </body>
</html>
