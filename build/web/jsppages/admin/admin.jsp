
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache ,must-revalidate");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    int t = 0;
    String userrole;
    String path;
    File dir;
    String filepath;
    String file;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Admin DashBoard</title>
    <jsp:include page="../common/header.jsp"/>

    <script type="text/javascript" src="../../resources/jquery/jquery.validate_1.js"></script>

    <script type="text/javascript" src="../../resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {
            $("#adminform").validate();
            $("#con_date").mask("99/99/99");
      

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

    </script>

    <script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
</head>
    <%
                request.getSession(false);
                request.setAttribute("t", t);

                userrole = (String) session.getAttribute("userrole");
                String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

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

                        <div class="active">
                            <a href="#" title="Admin">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Admin
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

                    <div class="left" >
                        <div  class="news box box620 m ">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h3>Content Management</h3>
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
                                                    <h4><a href="#">Create Content </a>  </h4>
                                                    <p>Click here for creating new content</p>
                                                    <div class="infobar">
                                                        <div class="button right">
                                                            <a href="create_content.jsp" title="Read more">
                                                                <span class="btleftcorners1">
                                                                    <span class="btrightcorners1">
                                                                        <span class="btbg1">
                                                                            &nbsp;Create
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </a>
                                                        </div> <!-- #news .button -->
                                                    </div> <!-- #news .infobar -->
                                                </div> <!-- #news .article -->
                                                <br class="clear" />
                                                <div class="article">
                                                    <h4><a href="#">Manage Content </a>  </h4>
                                                    <p>Click here to View or Update existing contents</p>
                                                    <div class="infobar">
                                                        <div class="button right">
                                                            <a href="viewcontent.jsp" title="Read more">
                                                                <span class="btleftcorners1">
                                                                    <span class="btrightcorners1">
                                                                        <span class="btbg1">
                                                                            Manage
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </a>
                                                        </div> <!-- #news .button -->
                                                    </div> <!-- #news .infobar -->
 <br class="clear" />
                                                </div> <!-- #news .article -->

                                            </div> <!-- #news .article -->
                                        </div>  <!-- #news .insider -->
                                    </div> <!-- #news .bg -->
                                </div> <!-- #news .rightcorners -->
                            </div> <!-- #news .leftcorners -->
                        </div> <!-- #news .content -->
                    </div> <!-- #news -->

                </div> <!-- #centerrail -->

                <div id="right">
                    <div class="twitter box box300 m">
                        <div class="heading heading35">
                            <div class="leftcorners">
                                <div class="rightcorners">
                                    <div class="bg">
                                        <h3>User Settings</h3>
                                    </div> <!-- #twitter .bg -->
                                </div> <!-- #twitter .rightcorners -->
                            </div> <!-- #twitter .leftcorners -->
                        </div> <!-- #twitter .heading -->
                        <div class="content">
                            <div class="leftcorners">
                                <div class="rightcorners">
                                    <div class="bg">
                                        <div class="insider">
                                            <div class="tweet1"><h4>Create User</h4>Click here to create a new User </div>
                                            <div class="button right">
                                                <a href="create_user.jsp" title="Create">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1">Create</span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #twitter .button -->
                                            <br/>
                                            <div class="tweet1"><h4>View User</h4>Click here to view existing Users</div>

                                            <div class="button right">
                                                <a href="view_user.jsp" title="view">
                                                    <span class="btleftcorners1">
                                                        <span class="btrightcorners1">
                                                            <span class="btbg1"> &nbsp;View&nbsp;</span>
                                                        </span>
                                                    </span>
                                                </a>
                                            </div> <!-- #twitter .button -->
                                            <br class="clear" />
                                        </div> <!-- #twitter .insider -->
                                    </div> <!-- #twitter .bg -->
                                </div> <!-- #twitter .rightcorners -->
                            </div> <!-- #twitter .leftcorners -->
                        </div> <!-- #twitter .content -->
                    </div> <!-- #twitter -->
                    <br class="clear" />
                </div> <!-- #rightrail -->
            
            <div class="container">
                <div class="left" >

                    <div  class="news box box620 m ">
                        <div class="heading heading35">
                            <div class="leftcorners">
                                <div class="rightcorners">
                                    <div class="bg">
                                        <h3>Reports Generation</h3>
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
                                                <h4><a href="#">Revenue Reports </a>  </h4>
                                                <p>Click here to create Revenue report</p>
                                                <div class="infobar">
                                                    <div class="button right">
                                                        <a href="../reports/revenuereport.jsp" title="Read more">
                                                            <span class="btleftcorners1">
                                                                <span class="btrightcorners1">
                                                                    <span class="btbg1">
                                                                        &nbsp;Create
                                                                    </span>
                                                                </span>
                                                            </span>
                                                        </a>
                                                    </div> <!-- #news .button -->
                                                </div> <!-- #news .infobar -->
                                            </div> <!-- #news .article -->
                                            <br class="clear" />
                                            <div class="article">
                                                <h4><a href="#">Consumer Details Reports </a></h4>
                                                <p>Click here to create Connection Details report</p>
                                                <div class="infobar">
                                                    <div class="button right">
                                                        <a href="../reports/cons_report.jsp" title="Read more">
                                                            <span class="btleftcorners1">
                                                                <span class="btrightcorners1">
                                                                    <span class="btbg1">
                                                                        Create
                                                                    </span>
                                                                </span>
                                                            </span>
                                                        </a>
                                                    </div> <!-- #news .button -->
                                                </div> <!-- #news .infobar -->
 <br class="clear" />
                                            </div> <!-- #news .article -->
                                        </div> <!-- #news .article -->
                                    </div>  <!-- #news .insider -->
                                </div> <!-- #news .bg -->
                            </div> <!-- #news .rightcorners -->
                        </div> <!-- #news .leftcorners -->
                    </div> <!-- #news .content -->
                </div> <!-- #news -->

          

            <div id="right1">
                <div class="twitter box box300 m">
                    <div class="heading heading35">
                        <div class="leftcorners">
                            <div class="rightcorners">
                                <div class="bg">
                                    <h3>Graph Analysis</h3>
                                </div> <!-- #twitter .bg -->
                            </div> <!-- #twitter .rightcorners -->
                        </div> <!-- #twitter .leftcorners -->
                    </div> <!-- #twitter .heading -->
                    <div class="content">
                        <div class="leftcorners">
                            <div class="rightcorners">
                                <div class="bg">
                                    <div class="insider">

                                        <div class="tweet1"><h4>Create Revenue Graph</h4>Click here to create a Graph </div>

                                        <div class="button right">
                                            <a href="../charts/Code/JSP/jal_chart.jsp" title="view">
                                                <span class="btleftcorners1">
                                                    <span class="btrightcorners1">
                                                        <span class="btbg1"> Create</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </div> <!-- #twitter .button -->

                                        <br/>
                                        <div class="tweet1"><h4>Create Consumers Graph</h4>Click here to create a Graph </div>

                                        <div class="button right">
                                            <a href="../charts/Code/JSP/ConsumerChart.jsp" title="view">
                                                <span class="btleftcorners1">
                                                    <span class="btrightcorners1">
                                                        <span class="btbg1"> Create</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </div> <!-- #twitter .button -->
                                        <br class="clear" />
                                    </div> <!-- #twitter .insider -->
                                </div> <!-- #twitter .bg -->
                            </div> <!-- #twitter .rightcorners -->
                        </div> <!-- #twitter .leftcorners -->
                    </div> <!-- #twitter .content -->
                </div> <!-- #twitter -->
                
            </div> <!-- #rightrail -->
           
                    <br class="clear" />      <br class="clear" />
                    <div id="contentrail" class="full" >
                        <h2>Add Contents</h2>
                        <form id="adminform"  method="post" action="ins_content.jsp" >
                            <fieldset>
                                <ul>
                                    <li>
                                        <table><tbody>
                                                <tr><td>
                                            <label for="con_title">Content Title:</label></td>
                                                    <td>  <input id="con_title" type="text" class="required" /></td>
                                                    <td><label for="content_type">Content Type: </label></td>
                                                    <td><select id="content_type">
                                                <option value="news">News</option>
                                                <option value="service">Service</option>
                                                <option value="notice">Notice</option>
                                                <option value="message">Message</option>
                                                <option value="ratelist">RateList</option>
                                                <option value="information">Information</option>
                                                <option value="links">Links</option>
                                                <option value="policy">Policy</option>
                                                <option value="terms">Terms &amp; Conditions</option>
                                                <option value="page">Page</option>
                                                <option value="others">Others</option>
                                                        </select></td>
                                                    <td><label for="display">Display: </label></td>
                                                    <td>  <select id="display">
                                                <option value="default">Visible</option>
                                                <option value="home">Home</option>
                                                <option value="none">None</option>
                                                        </select></td>

                                                    <td> <label for="priority">Priority:</label></td>
                                                    <td>  <input id="priority" type="text" class="small"/><br/><br/></td>
                                                </tr>

                                                <tr>
                                                    <td colspan="8">  <textarea name="content1" id="textarea1" cols="80" rows="20"></textarea><br/></td></tr>

                                       
                                                <tr><td>

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
                                <br class="clear" />
                            </div></td><td colspan="7"></td></tr>
                                                
                                            </tbody></table>
                                        
 </li>
                                </ul>
                            </fieldset>

                        </form>

                        <br class="clear"/><br class="clear"/>  <br class="clear"/><br class="clear"/>

                       
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
                                                    <td> <input name="heading" type="text" class="full" /><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="description">Description:</label></td><td></td>
                                                </tr>
                                                <tr><td></td>
                                                    <td>  <textarea name="description" id="description" class="required small"  cols="40" rows="2"></textarea><br/><br/></td>
                                                </tr>
                                                <tr><td>
                                                        <label for="image"> ImageUpload:</label> </td>
                                                    <td><input name="image" type="file" size="25"/><br/><br/></td>
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
                            </div>
                                                    </td></tr>     </tbody></table>
                                                 </li>
                                </ul>
                            </fieldset>
                        </form>

                        <br class="clear"/> <br class="clear"/>   <br class="clear"/> <br class="clear"/>


                       
                                        <h2>Uploaded Files</h2>



                                        <div id="table-blk" class="full">
                                            <table class="box-table">
                                                <colgroup>
                                                    <col class="vzebra-odd" />
                                                    <col class="vzebra-even" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th   scope="col">File Name</th>
                                                        <th   scope="col" >File Path</th>
                                                        <th   scope="col">File </th>
                                                        <th   scope="col"  >Actions</th>
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
                                                        <td>
                                                            <div class="button content">
                                                                <a href="deluploadfile.jsp?filename=<%=file%>&amp;page=admin" onclick="return confirmDel()">
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

<script type="text/javascript">
    CKEDITOR.replace('content1');
</script>