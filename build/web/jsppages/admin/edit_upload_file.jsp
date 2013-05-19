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
<%!    String userrole;
    int t;
    Connection con;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
         <title>Noida Jal Board : Edit Upload File</title>
    <jsp:include page="../common/header.jsp"/>

</head>
    <body>
<jsp:include page="../common/navigation.jsp"/>

<%
            request.getSession(false);
            request.setAttribute("t", t);

            userrole = (String) session.getAttribute("userrole");
            String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
            String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

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
                    <a href="viewuploadfile.jsp" title="Upload File">
                        <span class="leftcorners">
                            <span class="rightarrow">
                                <span class="bg">
                                    Upload Files
                                </span>
                            </span>
                        </span>
                    </a>
                </div> <!-- #breadcrums .active -->

                <div class="active">
                    <a href="#" title="Edit">
                        <span class="leftcorners">
                            <span class="rightarrow">
                                <span class="bg">
                                    Edit Uploadfile Contents
                                </span>
                            </span>
                        </span>
                    </a>
                </div> <!-- #breadcrums .active -->

            </div> <!-- #breadcrums .breadcrumb -->

            <!--div id="tools">
            <ul>
            <li class="first"><a href="#" title="Print">Print</a></li>
            <li class="last"><a href="#" title="Download">Download</a></li>
            </ul>
            </div--> <!-- #breadcrums .tools -->

        </div> <!-- #breadcrums .container -->
    </div> <!-- #breadcrums .inside -->
</div> <!-- #breadcrums -->

<div id="content">
    <div class="inside">
        <div class="container">
            <div id="contentrail" class="full">
                <h2>Edit Uploadfile Contents</h2>
                <%!      String description;
                    String heading;
                    String path;

                %>
                <%
                            String id1 = request.getParameter("imageid");

                            try {
                                InitialContext initialContext = new InitialContext();
                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                 con = dataSource.getConnection();
                                //  Connection con = (Connection) pageContext.getServletContext().getAttribute("con");
                                String Query = "Select * from upload_file where id=" + id1;
                                PreparedStatement ps = con.prepareStatement(Query);
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                                   heading= rs.getString(2);

                                    description = rs.getString(3);

                                    path = rs.getString(4);
                                }
                               
                            } catch (Exception ex) {
                                System.out.println("Exception" + ex);
                            } finally {
                con.close();
            }


                %>
                <form  id="userform"  action="upd_filecontent.jsp"  method="post" enctype="multipart/form-data">

                    <fieldset>

                        <table>
                            <tbody>
                                
                            <tr>

                                <td> <label for="heading">Heading:</label></td>
                                <td>  <input name="heading" type="text" class="full" value="<%=heading%>" id="heading"/><br/><br/></td>
                            </tr>
                            <tr>

                                <td><label for="description">Description:</label></td>
                                <td> <input name="description" type="text" class="small" value="<%=description%>" id="description"/><br/><br/></td>
                            </tr>
                             <tr><td colspan="2">
                                            <input type="hidden" value="<%=id1%>" name="id1"/></td></tr>
                            <tr>

                                <td>
                                    <label for="file">ImageUpload:</label></td><td> <input name="image" type="file" size="25" value="<%=path%>" id="file"/><br/><br/></td>

                            </tr>
                                   
                            <tr><td></td><td>
                    <div class="buttons">
                        <button class="submit" type="submit" value="Upload">
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
                        <a href="viewuploadfile.jsp">  <button class="submit" type="submit" value="Upload">
                                <span class="leftcorners">
                                    <span class="rightcorners">
                                        <span class="bg">
                                    			Cancel
                                        </span>
                                    </span>
                                </span>
                            </button>
                        </a>
                     
                    </div>
                                </td></tr>   </tbody>
                        </table>



                    </fieldset>
                </form>


            </div> <!-- #news .bg -->
        </div> <!-- #news .rightcorners -->
    </div> <!-- #news .leftcorners -->
</div>

<jsp:include page="../common/footer.jsp"/>
    </body></html>