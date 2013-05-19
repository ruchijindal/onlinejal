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
    String sess;
    String path;
    String file;
    File dir;
    String filepath;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Content</title>
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
            function selectpos()
            {
                var w = document.getElementById("content_type").selectedIndex;
                var value = document.getElementById("content_type").options[w].value;
                
                if(value=="page")
                {
                    //   document.write(value);
                    document.getElementById("page_position").removeAttribute("disabled");
                }else{
                    document.getElementById("page_position").setAttribute("disabled", "true");
                }
            }
        </script>

        <script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
    </head>
    <%
                request.getSession(false);
                request.setAttribute("t", t);

                sess = (String) session.getAttribute("userrole");
                //  String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                // String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

    %>
    <body>



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
                                            Create Content
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
                        <h2>Create Content</h2>

                        <form id="adminform"  method="post" action="ins_content.jsp" >
                            <fieldset>
                                <ul>
                                    <li>
                                        <table><tbody>
                                                <tr>

                                                    <td><label for="con_title">Content Title:</label></td>
                                                    <td> <input id="con_title" name="con_title" type="text" class="required"/></td>

                                                    <td> <label for="content_type">Content Type: </label></td>
                                                    <td> <select id= "content_type"   name="content_type" onchange="selectpos()" >
                                                            <option value="testimonial">Testimonial</option>
                                                            <option value="news">News</option>
                                                            <option value="service">Service</option>
                                                            <option value="notice">Event</option>
                                                            <option value="message">Message</option>
                                                            <option value="schemes">Schemes</option>
                                                            <option value="ratelist">RateList</option>
                                                            <option value="information">Information</option>
                                                            <option value="links">Links</option>
                                                            <option value="policy">Policy</option>
                                                            <option value="terms">Terms &amp; Conditions</option>
                                                            <option value="page"  >Page</option>
                                                            <option value="contact">Contact</option>
                                                            <option value="others">Others</option>
                                                        </select></td>
                                                    <td> <label for="page_position">Position:</label></td>

                                                    <td> <select id= "page_position"   disabled="true" name="page_position"  >
                                                            <option value="select">Select</option>
                                                            <option value="news">News &amp; Events</option>
                                                            <option value="consumer">Consumer</option>
                                                            <option value="contact">Contact Us</option>
                                                            <option value="download">Downloads</option>
                                                            <option value="root">Root</option>
                                                      <%
                                                                try {
                                                                    InitialContext initialContext = new InitialContext();
                                                                    DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                                                    Connection connection = dataSource.getConnection();
                                                                    String sql = "select con_title,position from jal_content where position='root' and content_type='page'";
                                                                    // con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                                    PreparedStatement pst = connection.prepareStatement(sql);
                                                                    ResultSet rs = pst.executeQuery();
                                                                    while (rs.next()) {
                                                                             //   System.out.println("values " + rs.getString("con_title"));
                                                                                String id1=rs.getString("position");
                                                                                String id2=rs.getString("con_title");
                                            %>
                                                    <option value="<%=id2 %>"><%=id2 %></option>
                                                    <% }
                                                                } catch (Exception e) {
                                                                    e.printStackTrace();
                                                                }
                                                    %>
                                                   </select> </td>
                                                </tr>
                                                <tr>

                                                    <td>  <label  for="priority">Priority:</label></td>
                                                    <td> <input id="priority"   name="priority" type="text"   /></td>

                                                    <td>   <label for="display">Display: </label></td>
                                                    <td><select id="display"   name="display">
                                                            <option value="default">Visible</option>
                                                            <option value="home">Home</option>
                                                            <option value="default">Default</option>
                                                            <option value="none">None</option>
                                                        </select><br/><br/></td>


                                                </tr>

                                                <tr><td colspan="6">
                                                        <textarea name="content1" id="textarea1" cols="80" rows="20"></textarea><br/></td></tr>

                                                <tr><td>
                                                        <div class="buttons">
                                                            <button class="submit a" type="submit" value="Submit">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    			Submit
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>
                                                    </td><td></td></tr></tbody></table>
                                    </li>
                                </ul>
                            </fieldset>

                        </form>

                        <br class="clear"/><br class="clear"/>       <br class="clear"/><br class="clear"/>




                        <h2>Upload File</h2>


                        <form  id="userform" method="post" action="ins_uploadfile.jsp?viewuploadfile" enctype="multipart/form-data">

                            <fieldset>
                                <ul>
                                    <li>

                                        <table>
                                            <tbody>

                                                <tr>
                                                    <td>

                                                        <label for="heading">Heading:</label></td>
                                                    <td> <input id="heading" name="heading" type="text" class="full" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="description">Description:</label></td><td></td>
                                                </tr>
                                                <tr><td></td>
                                                    <td>  <textarea name="description" id="description" class="required small"  cols="40" rows="2"></textarea><br/><br/></td>
                                                </tr>
                                                <tr><td>
                                                        <label for="file"> ImageUpload:</label> </td><td><input id="file" name="image" type="file" size="25"/><br/><br/></td>
                                                </tr>

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
                                                        </div></td></tr>
                                            </tbody></table>
                                    </li>
                                </ul>
                            </fieldset>
                        </form>

                        <br class="clear"/> <br class="clear"/> <br class="clear"/> <br class="clear"/>




                        <h2>Uploaded Files</h2>



                        <div id="table-blk" class="full">
                            <table class="box-table">
                                <colgroup>
                                    <col class="vzebra-odd" />
                                    <col class="vzebra-even" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th   scope="col"  >File Name</th>
                                        <th   scope="col"  >File Path</th>
                                        <th   scope="col"  >File </th>
                                        <th   scope="col"   >Actions</th>
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
                                                        String fpath = path + file;
                                    %>
                                    <tr>
                                        <td>  <%=file%></td>
                                        <td><%=filepath%></td>
                                        <td><a href="<%=impath%>" onclick="return popitup('<%=impath%>')"><img src="<%=impath%>" height="25px" alt="File"/></a></td>
                                        <td class="fix">
                                            <div class="button content">
                                                <a href="deluploadfile.jsp?filename=<%=file%>&amp;page=create_content" onclick="return confirmDel()">
                                                    <img src="../../resources/images/icons/Delete-32.png" title="Delete" height="20" alt="Delete"/>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>


                                    <%
                                                    }
                                                } catch (Exception ex) {
                                                    ex.printStackTrace();
                                                   // System.out.println(ex);
                                                }

                                    %>
                                </tbody>
                            </table>
                        </div>


                    </div> <!-- #news .article -->


                </div>
            </div>
        </div>
        <script type="text/javascript">
            CKEDITOR.replace('content1');
        </script>
        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>

</html>
