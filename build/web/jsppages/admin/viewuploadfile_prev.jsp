<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
    InputStream image;
    String id;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Uploaded Files</title></head>
    <jsp:include page="../common/header.jsp"/>
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

        function popitup(url)
        {
            newwindow=window.open(url,'name','height=400,width=400');
            if (window.focus) {newwindow.focus()}
            return false;
        }

       


    </script>



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
                            <a HREF="admin.jsp" title="Admin">
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
                            <a HREF="#" title="uploaded files">
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
                            <table id="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th   scope="col" id="vzebra-comedy">File Name</th>
                                        <th   scope="col" id="vzebra-comedy">File Path</th>
                                        <th   scope="col" id="vzebra-comedy">File </th>
                                        <th   scope="col" id="vzebra-comedy" >Actions</th>
                                    </tr>
                                </thead>

                                <tbody>




                                    <%
                                                try {
                                                    path = this.getServletContext().getRealPath("") + "/resources/uploadimg/";
                                                    dir = new File(path);

                                                    String children[] = dir.list();
                                                    for (int i = 0; i < children.length; i++) {
                                                        file = children[i];
                                                        filepath = "/resources/uploadimg/" + file;
                                                        String impath = "../../resources/uploadimg/" + file;

                                    %>
                                    <tr>
                                        <td >  <%=file%></td>
                                        <td><%=filepath%></td>
                                        <td ><a href="<%=impath%>" onclick="return popitup('<%=impath%>')"><img src="<%=impath%>" height="25px" alt="File"/></a> <!--<img src="<%//=impath%>" height="25px" alt=" "/>--></td>

                                        <td class="fix"><div class="button content">
                                                <a href="deluploadfile.jsp?filename=<%=file%>&page=viewuploadfile" onclick="return confirmDel()" title="Delete file.">

                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>

                                                </a>
                                            </div>

                                        </td>

                                    </tr>


                                    <%
                                                    }
                                                } catch (Exception ex) {
                                                    System.out.println(ex);
                                                }

                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

            <br class="clear"/>
            <br class="clear"/>


            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="full">


                        <h2>Upload File</h2>


                        <form  id="form2" method="post" action="uploadimg.jsp?viewuploadfile" enctype="MULTIPART/FORM-DATA">
                            <input type="hidden" name="viewuploadfile"/>
                            <fieldset>
                                <ul>
                                    <li>
                                        <div class="inputbox">

                                            <input name="image" type="file" />
                                        </div>
                                    </li>
                                </ul>
                            </fieldset>

                            <div class="buttons">
                                <button class="submit a" type="submit" value="Upload">
                                    <span class="leftcorners">
                                        <span class="rightcorners">
                                            <span class="bg">
                                    			Upload
                                            </span>
                                        </span>
                                    </span>
                                </button>
                                <br class="clear" />
                            </div>


                        </form>



                        <h2>Uploaded Slider Images</h2>



                        <div id="table-blk" class="full">
                            <table id="box-table">
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
                                        <th scope="col" id="vzebra-comedy">Id</th>
                                        <th scope="col" id="vzebra-comedy">Caption Heading</th>
                                        <th scope="col" id="vzebra-comedy">Caption Text</th>
                                        <th scope="col" id="vzebra-comedy">Path</th>
                                        <th scope="col" id="vzebra-comedy">Image</th>
                                        <th scope="col" id="vzebra-comedy">Actions</th>
                                    </tr>
                                </thead>

                                <tbody>




                                    <%
                                                try {
                                                    sql = "select id,path,captiontxt,caption_heading from slider_image";
                                                    InitialContext initialContext = new InitialContext();
                                                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                    con = dataSource.getConnection();
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
                                                } finally {
                                                    con.close();
                                                }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <h2>Upload Slider Image</h2>


                        <form  id="form2" method="post" action="ins_sliderimg.jsp?viewuploadfile" enctype="multipart/form-data">

                            <fieldset>
                                <ul>
                                    <li>
                                        <div class="inputbox">
                                            <label for="caption_heading">Caption Heading:</label>
                                            <input name="caption_heading" type="text" />

                                            <label for="captiontxt">Caption Text:</label>
                                            <input name="captiontxt" type="text" />
                                        </div>
                                        <div class="inputbox">
                                            <label for="file">Upload Slider Image:</label> <input name="image" type="file"/>
                                        </div>
                                    </li>
                                </ul>
                            </fieldset>
                            <div class="buttons">
                                <button class="submit a" type="submit" value="Upload">
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