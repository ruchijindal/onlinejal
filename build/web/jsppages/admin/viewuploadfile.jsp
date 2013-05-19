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


<%!    File dir;
    String file;
    String path;
    String userrole;
    String filepath;
    int t;
    Connection con;
    PreparedStatement pst;
    ResultSet rs;
    String sql;
    String captiontxt;
    String caption_heading;
    String description;
    String heading;
    InputStream image;
    String id;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Uploaded Files</title>
        <jsp:include page="../common/header.jsp"/>
        <script  type="text/javascript">

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
                newwindow=window.open(url,'name','height=400,width=400');
                if (window.focus) {newwindow.focus()}
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
                            <a href="#" title="uploaded files">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Uploaded files
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

                        <h2>Uploaded Files</h2>

                        <div id="table-blk" class="full">

                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col" >Heading</th>
                                        <th scope="col" >Description</th>
                                        <th scope="col" >Path</th>
                                        <th scope="col" >Image</th>
                                        <th scope="col" >Actions</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <%
                                                InitialContext initialContext = new InitialContext();
                                                DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                con = dataSource.getConnection();
                                                try {
                                                    sql = "select id,path,description,heading from upload_file";

                                                    // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                    pst = con.prepareStatement(sql);
                                                    rs = pst.executeQuery();
                                                    while (rs.next()) {
                                                        id = rs.getString(1);
                                                        path = rs.getString(2);
                                                        description = rs.getString(3);
                                                        heading = rs.getString(4);
                                                        String impath = "../../" + path;
                                    %>

                                    <tr>
                                        <td><%=id%></td>
                                        <td><%=heading%></td>
                                        <td><%=description%></td>
                                        <td><%=path%></td>
                                        <td ><a href="<%=impath%>" onclick="return popitup('<%=impath%>')"><img src="<%=impath%>" height="25px" alt="File"/></a></td>


                                        <td class="fix"><div class="button contentfix"><a href="edit_upload_file.jsp?imageid=<%=id%>">
                                                    <img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="Delete"/>
                                                </a>

                                                <a href="deleteuploadfile.jsp?imageid=<%=id%>" onclick="return confirmDel()">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>


                                    </tr>


                                    <%
                                                    }
                                                } catch (Exception ex) {
                                                    System.out.println(ex);
                                                }

                                    %>
                                </tbody>
                            </table>
                            <%
                                        String upload = request.getParameter("done");
                                        if (upload != null && upload.equals("yes")) {
                            %>
                            <p style="font-weight: bold;">  File Successfully Uploaded.  </p>
                            <%                }
                            %>
                             
                             

                            <h2>Upload File</h2>
                            <form  id="userform1" method="post" action="ins_uploadfile.jsp?viewuploadfile" enctype="multipart/form-data">

                                <fieldset>
                                    <ul>
                                        <li>

                                            <table>
                                                <tbody>
                                                    <tr><td>
                                                            <label>Heading:</label></td>
                                                        <td>   <input name="heading" type="text" class="full"/><br/><br/></td>
                                                    </tr>
                                                    <tr><td>
                                                            <label>Description:</label></td><td></td></tr>
                                                    <tr><td></td>

                                                        <td>  <textarea  name="description"  class="required small" rows="10" cols="10"></textarea><br/><br/></td>
                                                    </tr>
                                                    <tr><td>
                                                            <label>ImageUpload:</label></td><td> <input name="image" type="file" size="25"/><br/><br/></td></tr>
                                                    <tr><td></td><td>
                                                            <div class="buttons">
                                                                <button class="submit " type="submit" value="Upload">
                                                                    <span class="leftcorners">
                                                                        <span class="rightcorners">
                                                                            <span class="bg">
                                    			Submit
                                                                            </span>
                                                                        </span>
                                                                    </span>
                                                                </button>
                                                                <br class="clear" />
                                                            </div>
                                                        </td></tr>         </tbody></table>

                                        </li>
                                    </ul>
                                </fieldset>
                            </form>

                            <br class="clear"/> <br class="clear"/> <br class="clear"/> <br class="clear"/>


                            <h2>Uploaded Slider Images</h2>




                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col" >Caption Heading</th>
                                        <th scope="col" >Caption Text</th>
                                        <th scope="col" >Path</th>
                                        <th scope="col">Image</th>
                                        <th scope="col" >Actions</th>
                                    </tr>
                                </thead>

                                <tbody>




                                    <%
                                                try {
                                                    sql = "select id,path,captiontxt,caption_heading from slider_image";

                                                    // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                    pst = con.prepareStatement(sql);
                                                    rs = pst.executeQuery();
                                                    while (rs.next()) {
                                                        id = rs.getString(1);
                                                        path = rs.getString(2);
                                                        captiontxt = rs.getString(3);
                                                        caption_heading = rs.getString(4);
                                                        String impath = "../../" + path;
                                    %>
                                    <tr>
                                        <td><%=id%></td>
                                        <td><%=caption_heading%></td>
                                        <td><%=captiontxt%></td>
                                        <td><%=path%></td>
                                        <td ><a href="<%=impath%>" onclick="return popitup('<%=impath%>')"><img src="<%=impath%>" height="25px" alt="File"/></a></td>


                                        <td class="fix"><div class="button contentfix"><a href="edit_slider_content.jsp?imageid=<%=id%>">
                                                    <img src="../../resources/images/icons/Edit-32.png" title="Edit" height="20" alt="Delete"/>
                                                </a>

                                                <a href="deletesliderimage.jsp?imageid=<%=id%>" onclick="return confirmDel()">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div></td>


                                    </tr>


                                    <%
                                                    }

                                                } catch (Exception ex) {
                                                    System.out.println(ex);
                                                }
                                                con.close();

                                    %>
                                </tbody>
                            </table>
                        </div>
                                <%
                                        String uploadimage = request.getParameter("done1");
                                        if (uploadimage != null && uploadimage.equals("yes")) {
                            %>
                            <p style="font-weight: bold;">  Slider Image Successfully Uploaded.  </p>
                            <%                }
                            %>
                        <br class="clear"/>
                        <br class="clear"/>
                        <h2>Upload Slider Image</h2>


                        <form  id="userform" method="post" action="ins_sliderimg.jsp?viewuploadfile" enctype="multipart/form-data">

                            <fieldset>
                                <ul>
                                    <li>

                                        <table>
                                            <tbody> 
                                                <tr><td>
                                                        <label>Heading:</label></td>
                                                    <td>   <input name="caption_heading" type="text" class="full"/><br/><br/></td>
                                                </tr>
                                                <tr><td>
                                                        <label>Description:</label></td><td></td></tr>
                                                <tr><td></td>

                                                    <td>  <textarea  name="captiontxt"  class="required small" rows="10" cols="10"></textarea><br/><br/></td>
                                                </tr>
                                                <tr><td>
                                                        <label>ImageUpload:</label></td><td> <input name="image" type="file" size="25"/><br/><br/></td></tr>
                                                <tr><td></td><td>
                                                        <div class="buttons">
                                                            <button class="submit " type="submit" value="Upload">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Submit
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>
                                                            <br class="clear" />
                                                        </div>
                                                    </td></tr>         </tbody></table>

                                    </li>
                                </ul>
                            </fieldset>
                        </form>

                    </div>
                </div>

            </div>


        </div>




        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>