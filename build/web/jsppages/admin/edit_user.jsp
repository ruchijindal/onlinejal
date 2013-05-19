<%--
    Document   : login
    Created on : 24 Nov, 2009, 12:22:01 PM
    Author     : smp
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
      <head> <title>Noida Jal Board :User</title>
    <jsp:include page="../common/header.jsp"/>
    </head>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*;"%>
<%!    String username;
    String userid;
    String password;
    String userrole;
    String crdate;
    String createdby;
    String sql;
    Connection con;
    ConvertToDate ctd;
    PreparedStatement pst;
    ResultSet rs;
    boolean i;
    String sess;
    int t;
%>
 <body  onload="setUserrole()">

    <script  type="text/javascript" src="../../resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="../../resources/jquery/jquery.validate.js"></script>
    <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
               
            $("#userform").validate();
            $("#crdate").mask("99/99/99");

        });

        function setUserrole()
        {
            userrole=document.forms[0].urole.value;

            for(i=0;i<(document.getElementById("userrole")).length;i++)
            {
                if(document.getElementById("userrole").options[i].value.trim()==userrole.trim())
                {
                    // alert(userrole)
                    document.getElementById("userrole").selectedIndex=i;
                }
            }


        }

    </script>

   
        <%
                    sess = (String) session.getAttribute("userrole");

                    try {
                        userid = request.getParameter("userid");
                        InitialContext initialContext = new InitialContext();
                        DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                        con = dataSource.getConnection();
                        //con = (Connection) pageContext.getServletContext().getAttribute("con");
                        sql = "select username,userrole,to_char(crdate,'DD/MM/YY'),createdby from userlogin where userid='" + userid + "'";
                        pst = con.prepareStatement(sql);
                        rs = pst.executeQuery();
                        while (rs.next()) {
                            username = rs.getString(1);
                            userrole = rs.getString(2);
                            crdate = rs.getString(3);
                            createdby = rs.getString(4);
                        }
                    } catch (Exception ex) {
                        System.out.println(ex);
                    } finally {
                        con.close();
                    }
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
                            <a href="#" title="Edit user">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Edit User
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
                    <div id="contentrail" class="full" >


                        <h2>Edit user details</h2>

                        <form id="userform"  method="post" action="ins_edit_user.jsp">

                            <%

                                        if (t == 1) {
                                            t = (Integer) 0;
                                            request.setAttribute("t", t);
                            %>
                            <p class="error">There was some error!</p>
                            <%

                                        }
                            %>

                            <input type="hidden" name="urole" value="<%=userrole%>"/>



                            <fieldset>
                                <ul>
                                    <li>
                                        <table>
                                            <tbody>
                                            <tr>
                                                <td> <label for="username">User Name: <span class="required">*</span></label></td>
                                                <td><input name="username" id="username"  class="required" value="<%=username%>" type="text" /><br/><br/></td>
                                            </tr>

                                            <tr>
                                                <td><label for="userid">User ID: <span class="required">*</span></label></td>
                                                <td><input name="userid" id="userid"  value="<%=userid%>" class="required"  type="text" /><br/><br/></td>
                                            </tr>

                                            <tr>
                                                <td><label for="password">Password:<span class="required">*</span></label></td>
                                                <td><input name="password" id="password" title="Please fill Your password address!" value="" type="password" /><br/><br/></td>

                                            </tr>
                                            <tr>

                                                <td><label for="cpassword">Confirm Password: <span class="required">*</span></label></td>
                                                <td><input name="cpassword" id="cpassword" title="Please fill Your password address!" equalTo="#password" value="" type="password" /><br/><br/></td>

                                            </tr>
                                            <tr>

                                                <td><label for="userrole">User Role: <span class="required">*</span></label></td>
                                                <td><select name="userrole" id="userrole">
                                                        <option value="admin">Administrator</option>
                                                        <option value="manager">Manager</option>
                                                        <option value="consumer">consumer</option>
                                                        <option value="general">General</option>
                                                    </select>
                                                <br/><br/></td>

                                            </tr>
                                            <tr>

                                                <td> <label for="creationdate">Creation Date:<span class="required">*</span></label></td>
                                                <td><input name="crdate" id="creationdate"  value="<%=crdate%>" type="text" class="required" /><br/><br/></td>

                                            </tr>
                                            <tr>

                                                <td> <label for="createdby">Created By:<span class="required">*</span></label></td>
                                                <td><input name="createdby" id="createdby"  value="<%=createdby%>" type="text" class="required" /></td>

                                            </tr>
                                      
                                                        <tr><td colspan="2"> <p class="required">* Required Fields</p></td></tr>

                                                        <tr>

                                                            <td></td><td>
                                        <div class="buttons" >

                                            <button class="submit" type="submit" value="Submit"  >
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
                                            </tbody></table>
                            </li>
                                </ul>
                            </fieldset>
                        </form>




                        <br class="clear" />
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