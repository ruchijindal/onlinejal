<%--
    Document   : index
    Created on : Nov 12, 2009, 1:45:33 PM
    Author     : Admin
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board :  Create User</title>
        <jsp:include page="../common/header.jsp"/>
    </head>

    <%
                response.setHeader("Pragma", "no-cache");
                response.setHeader("Cache-Control", "no-store, no-cache");
                response.setDateHeader("Expires", 0);

    %>



    <%@ page language="java" import="java.util.*,javax.servlet.*" pageEncoding="ISO-8859-1"%>
    <%!    int date;
        int year;
        int month;
        String sess;
        int t = 0;
    %>


    <body>

        <script  type="text/javascript" src="../../resources/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#userform").validate();

            });
        </script>




        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    sess = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

        %>



        <!-- Menu Starts -->
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

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Create user
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








                                                    <div class="inside">
                                                        <div class="container">
                                                            <div id="contentrail" class="full">

                                                                <h2>Create User</h2>
                                                                <%

                                                                            if (t == 1) {
                                                                                t = (Integer) 0;
                                                                                request.setAttribute("t", t);
                                                                %>
                                                                <p class="error short">There was some error!</p>
                                                                <%

                                                                                                                                                } else if (t == 2) {
                                                                                                                                                    t = (Integer) 0;
                                                                                                                                                    request.setAttribute("t", t);
                                                                %>
                                                                <p class="error short">UserId exists already.</p>
                                                                <%

                                                                            }



                                                                %>

                                                                <form action="insert_user.jsp"  id="userform" method="post">
                                                                    <fieldset>
                                                                        <ul>
                                                                            <li>
                                                                                <table>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td> <label for="username">User Name: <span class="required">*</span></label></td>
                                                                                            <td> <input name="username" id="username" class="required"   type="text" /><br/><br/></td>
                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td><label for="userid">User ID: <span class="required">*</span></label></td>
                                                                                            <td><input name="userid" id="userid" class="required"   type="text" /><br/><br/></td>
                                                                                        </tr>
                                                                                        <tr>

                                                                                            <td><label for="password">Password:<span class="required">*</span></label></td>
                                                                                            <td><input name="password" id="password" class="required"  minlength="6" type="password" /><br/><br/></td>

                                                                                        </tr>
                                                                                        <tr>

                                                                                            <td><label for="cpassword">Confirm Password: <span class="required">*</span></label></td>
                                                                                            <td><input name="cpassword" id="cpassword" class="required" equalTo="#password"   type="password" /><br/><br/></td>

                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td><label for="userrole">User Role: <span class="required">*</span></label></td>
                                                                                            <td> <select name="userrole" id="userrole" >
                                                                                                    <option value="admin">Administrator</option>
                                                                                                    <option value="manager">Manager</option>
                                                                                                    <option value="general">General</option>
                                                                                                    <option value="consumer">Consumer</option>
                                                                                                    <option value="crm">Customer Relationship Mgmt.</option>

                                                                                                </select><br/><br/></td>
                                                                                        </tr>
                                                                                        <tr>

                                                                                            <td> <label for="createdby">Created By:<span class="required">*</span></label></td>
                                                                                            <td><input name="createdby" id="createdby"   type="text" /></td>

                                                                                        </tr>

                                                                                        <tr>
                                                                                            <td colspan="2">  <p class="required">* Required Fields</p></td>
                                                                                        </tr>
                                                                                        <tr><td></td><td>
                                                                                                <div class="buttons">
                                                                                                    <button class="submit" type="submit" value="Submit">
                                                                                                        <span class="leftcorners">
                                                                                                            <span class="rightcorners">
                                                                                                                <span class="bg">
                                    			Submit
                                                                                                                </span>
                                                                                                            </span>
                                                                                                        </span>
                                                                                                    </button>
                                                                                                    <button class="submit" type="reset" value="reset">
                                                                                                        <span class="leftcorners">
                                                                                                            <span class="rightcorners">
                                                                                                                <span class="bg">
                                    			Reset
                                                                                                                </span>
                                                                                                            </span>
                                                                                                        </span>
                                                                                                    </button>

                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </li>
                                                                        </ul>
                                                                    </fieldset>
                                                                    <div id="note"></div>

                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>


                                                    <br class="clear" />
                                                </div> <!-- #news .article -->
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
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->


    </body>
</html>





































